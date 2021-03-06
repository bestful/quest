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
    [Route("api")]
    [ApiController]
    public class UserController : ApplicationContext
    {
        private readonly youtubeappContext _context;

        public UserController(youtubeappContext context)
        {
            _context = context;
        }

        // POST: api/User
        [HttpPost("register")]
        public ActionResult Register(User user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
                
            }
            try{
                _context.User.Add(user);
                _context.SaveChanges();
            }
            catch(Exception){
                return StatusCode(403, "User with this name already registered");
            }

            return CreatedAtAction("Register", new { id = user.Id }, user);
        }

        [HttpPost("authorize")]
        public ActionResult Authorize(User user){
            if (!ModelState.IsValid){
                return BadRequest(ModelState);
            }

            try{
                User f = _context.User.First(u => u.Username == user.Username);

                if (f.Password == user.Password){
                    authorized_id = f.Id;
                    return Ok();
                }
                else {
                    return StatusCode(401, "Incorrect password");
                }
            }
            catch(InvalidOperationException){
                return NotFound("User with name " + user.Username +" not found");
            }

            
        }

        [HttpGet("logout")]
        public ActionResult Logout(){
            HttpContext.Session.Clear();
            return Ok();
        }

        [HttpGet("account")]
        public ActionResult Account(){
            var user_id = authorized_id;
            // if authorized
            if(user_id != null){
                User user =  _context.User.Find(user_id);
                return Ok(user);
            }
            else {
                return Unauthorized();
            }
            
        }

        private bool UserExists(int id)
        {
            return _context.User.Any(e => e.Id == id);
        }

    }
}