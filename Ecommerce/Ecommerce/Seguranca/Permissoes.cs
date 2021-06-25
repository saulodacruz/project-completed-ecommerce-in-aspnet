using Servicos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Ecommerce.Seguranca
{
    public class Permissoes : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);
            if (filterContext.HttpContext != null)
            {
                if (filterContext.HttpContext.Request.Cookies["aiopSessaoLogin"] == null ||
                    filterContext.HttpContext.Request.Cookies["aiopcod"] == null ||
                    filterContext.HttpContext.Request.Cookies["aiopemail"] == null ||
                    filterContext.HttpContext.Request.Cookies["aiopnome"] == null)
                {
                    if (filterContext.HttpContext.Request.Cookies["aiopSessaoLogin"] != null)
                        filterContext.HttpContext.Response.Cookies["aiopSessaoLogin"].Expires = Util.DateTimeNowBR().AddHours(-1);
                    if (filterContext.HttpContext.Request.Cookies["aiopcod"] != null)
                        filterContext.HttpContext.Response.Cookies["aiopcod"].Expires = Util.DateTimeNowBR().AddHours(-1);
                    if (filterContext.HttpContext.Request.Cookies["aiopemail"] != null)
                        filterContext.HttpContext.Response.Cookies["aiopemail"].Expires = Util.DateTimeNowBR().AddHours(-1);
                    if (filterContext.HttpContext.Request.Cookies["aiopnome"] != null)
                        filterContext.HttpContext.Response.Cookies["aiopnome"].Expires = Util.DateTimeNowBR().AddHours(-1);
                    if (filterContext.HttpContext.Request.Cookies["aioploadingUser"] != null)
                        filterContext.HttpContext.Response.Cookies["aioploadingUser"].Expires = Util.DateTimeNowBR().AddHours(-1);
                }
            }
            if (filterContext.Result is HttpUnauthorizedResult)
                filterContext.HttpContext.Response.Redirect("/Usuario/Login");
        }
    }
}