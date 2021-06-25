using Servicos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace EcommerceAdmin.Controllers
{
    public class UsuarioAdminController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Login(string codigo)
        {
            if (codigo == System.Configuration.ConfigurationManager.AppSettings["CodigoAcesso"].ToString())
            {
                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1,
                    codigo,
                    Util.DateTimeNowBR(),
                    Util.DateTimeNowBR().AddDays(1000),
                    true,
                    codigo);
                string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                if (authTicket.IsPersistent)
                    authCookie.Expires = authTicket.Expiration;
                System.Web.HttpContext.Current.Response.Cookies.Add(authCookie);
                return RedirectToAction("Produtos", "Produto");
            }
            else
                return Redirect(Request.UrlReferrer.ToString());
        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "UsuarioAdmin");
        }
    }
}