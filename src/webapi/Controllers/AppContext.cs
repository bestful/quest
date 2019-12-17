using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace webapi.Controllers {
  public abstract class ApplicationContext : ControllerBase {
            // My classes
      const string session_AuthorizedID = "user_id";

      // Authorized user id 
      public int? authorized_id{
          get{
              return HttpContext.Session.GetInt32(session_AuthorizedID);
          }
          set{
              if(value != null)
                  HttpContext.Session.SetInt32(session_AuthorizedID, (int)value);
          }
      }
      public bool authorized{
          get{
              return authorized_id != null;
          }
      } 
  }

}