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
    [Route("api/item")]
    [ApiController]
    public class ItemController : ApplicationContext
    {
        private readonly youtubeappContext _context;

        public ItemController(youtubeappContext context)
        {
            _context = context;
        }

        // GET: api/item
        [HttpGet]
        public IEnumerable<item> Getitem()
        {
            int? user_id = HttpContext.Session.GetInt32("user_id");
            if(user_id == null){
                return null;
            }
            var items = _context.item.Where(item =>  item.UserId == user_id);
            return items;
        }

        // GET: api/item/5
        [HttpGet("{id}")]
        public async Task<IActionResult> Getitem([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            int? user_id = HttpContext.Session.GetInt32("user_id");
            if(user_id == null){
                return Unauthorized();
            }

            var item = await _context.item.Where(c =>  c.UserId == user_id && c.VideoId == id).ToArrayAsync();

            if (item == null)
            {
                return NotFound();
            }

            return Ok(item);
        }

        // PUT: api/item/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Putitem([FromRoute] int id, [FromBody] item item)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != item.UserId)
            {
                return BadRequest();
            }

            _context.Entry(item).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!itemExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/item
        [HttpPost]
        public async Task<IActionResult> Postitem([FromBody] item item)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.item.Add(item);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (itemExists(item.UserId))
                {
                    return new StatusCodeResult(StatusCodes.Status409Conflict);
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("Getitem", new { id = item.UserId }, item);
        }

        // DELETE: api/item/5
        [HttpDelete("{id}")]
        public IActionResult Deleteitem([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if(!authorized)
            {
                return Unauthorized();
            }
            try{
                var item = _context.item.First(e => e.UserId == (int) authorized_id && e.VideoId == id);
                _context.item.Remove(item);
                _context.SaveChanges();
                return Ok(item);
            }
            catch(InvalidOperationException e) {
                return NotFound();
            }
            catch(Exception e){
                return Conflict();
            }



        }

        private bool itemExists(int id)
        {
            return _context.item.Any(e => e.UserId == id);
        }
    }
}