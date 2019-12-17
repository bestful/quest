using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using webapi.Models;

namespace webapi.Controllers
{
    [Route("api/vote")]
    [ApiController]
    public class VoteforVideoController : ApplicationContext
    {
        private readonly youtubeappContext _context;

        public VoteforVideoController(youtubeappContext context)
        {
            _context = context;
        }

        // GET: api/VoteforVideo
        [HttpGet]
        public IEnumerable<VoteforVideo> GetVoteforVideo()
        {
            return _context.VoteforVideo;
        }

        // GET: api/VoteforVideo/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetVoteforVideo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var voteforVideo = await _context.VoteforVideo.Where(vote => vote.VideoId == id).ToArrayAsync();

            if (voteforVideo == null)
            {
                return NotFound();
            }

            return Ok(voteforVideo);
        }

        // PUT: api/VoteforVideo/5
        [HttpPut("{id}/{mark}")]
        public IActionResult PutVoteforVideo([FromRoute] int id, [FromRoute] int mark)
        {
            if ( ! (mark >=0 && mark <= 5) )
            {
                return BadRequest();
            }

            // _context.Entry(voteforVideo).State = EntityState.Modified;

            if(!authorized){
                return Unauthorized();
            }


            // try
            // {
                // VoteforVideo vote = _context.VoteforVideo.First(o => o.UserId == authorized_id && o.VideoId == id);
            VoteforVideo vote = _context.VoteforVideo.Find(id, (int) authorized_id);
            if(vote == null) {
                vote = new VoteforVideo();
                vote.UserId = (int) authorized_id;
                vote.VideoId = id;
                vote.Mark = mark; 
                _context.VoteforVideo.Add(vote);
            }
            else{
                vote.Mark = mark;
                _context.VoteforVideo.Update(vote);
            }
            
            try{
                
                _context.SaveChanges();
            }
            catch(Exception e){
                return BadRequest(e);
            }

            return Ok();
        }

        // POST: api/VoteforVideo
        [HttpPost]
        public async Task<IActionResult> PostVoteforVideo([FromBody] VoteforVideo voteforVideo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.VoteforVideo.Add(voteforVideo);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (VoteforVideoExists(voteforVideo.VideoId))
                {
                    return new StatusCodeResult(StatusCodes.Status409Conflict);
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetVoteforVideo", new { id = voteforVideo.VideoId }, voteforVideo);
        }

        // DELETE: api/VoteforVideo/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteVoteforVideo([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var voteforVideo = await _context.VoteforVideo.FindAsync(id);
            if (voteforVideo == null)
            {
                return NotFound();
            }

            _context.VoteforVideo.Remove(voteforVideo);
            await _context.SaveChangesAsync();

            return Ok(voteforVideo);
        }

        private bool VoteforVideoExists(int id)
        {
            return _context.VoteforVideo.Any(e => e.VideoId == id);
        }
    }
}