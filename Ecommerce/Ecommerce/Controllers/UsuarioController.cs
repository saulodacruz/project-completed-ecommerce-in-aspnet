using Ecommerce.Seguranca;
using Models;
using Servicos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

namespace Ecommerce.Controllers
{
    [Authorize]
    [Permissoes(Roles = "Cliente")]
    public class UsuarioController : Controller
    {
        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult Login(Usuario u)
        {
            if (!string.IsNullOrWhiteSpace(u.Email) && !string.IsNullOrWhiteSpace(u.Senha))
            {
                u.Email = u.Email.Trim();
                var result = new SerUsuario().EfetuarLogin(u);
                if (result.sucesso)
                {
                    Response.Cookies.Add(new HttpCookie("aiopcod")
                    {
                        Value = SerCriptografia.Encrypt(result.obj.CodUsuario.ToString()),
                        Expires = Util.DateTimeNowBR().AddHours(1),
                        HttpOnly = false
                    });
                    Response.Cookies.Add(new HttpCookie("aiopemail")
                    {
                        Value = result.obj.Email,
                        Expires = Util.DateTimeNowBR().AddHours(1),
                        HttpOnly = false
                    });
                    Response.Cookies.Add(new HttpCookie("aiopnome")
                    {
                        Value = result.obj.Nome,
                        Expires = Util.DateTimeNowBR().AddHours(1),
                        HttpOnly = false
                    });
                    Response.Cookies.Add(new HttpCookie("aioploadingUser")
                    {
                        Value = "1",
                        Expires = Util.DateTimeNowBR().AddHours(1),
                        HttpOnly = false
                    });

                    FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1,
                    u.Email,
                    Util.DateTimeNowBR(),
                    Util.DateTimeNowBR().AddHours(1),
                    true,
                    u.Email);
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                    HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    if (authTicket.IsPersistent)
                        authCookie.Expires = authTicket.Expiration;
                    authCookie.HttpOnly = false;
                    System.Web.HttpContext.Current.Response.Cookies.Add(authCookie);
                }
                return Json(result);
            }
            return Json(new JsonObject { sucesso = false, mensagem = "Erro ao efetuar o login. Revise os campos ou tente novamente." });
        }

        [AllowAnonymous]
        public ActionResult Cadastro(Usuario u)
        {
            return View(u);
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult Cadastrar(Usuario u)
        {
            var result = new SerUsuario().Cadastrar(u);
            if (result.sucesso)
            {
                u.Email = u.Email.Trim();
                Response.Cookies.Add(new HttpCookie("aiopcod")
                {
                    Value = SerCriptografia.Encrypt(result.obj.CodUsuario.ToString()),
                    Expires = Util.DateTimeNowBR().AddHours(1)
                });
                Response.Cookies.Add(new HttpCookie("aiopemail")
                {
                    Value = u.Email,
                    Expires = Util.DateTimeNowBR().AddHours(1)
                });
                Response.Cookies.Add(new HttpCookie("aiopnome")
                {
                    Value = u.Nome,
                    Expires = Util.DateTimeNowBR().AddHours(1)
                });
                Response.Cookies.Add(new HttpCookie("aioploadingUser")
                {
                    Value = "1",
                    Expires = Util.DateTimeNowBR().AddHours(1)
                });

                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1,
                u.Email,
                Util.DateTimeNowBR(),
                Util.DateTimeNowBR().AddHours(1),
                true,
                u.Email);
                string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                if (authTicket.IsPersistent)
                    authCookie.Expires = authTicket.Expiration;
                System.Web.HttpContext.Current.Response.Cookies.Add(authCookie);
            }
            return Json(result);
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult VerificarEmail(Usuario u)
        {
            var result = new SerUsuario().VerificarEmail(u.Email.Trim());            
            return Json(new JsonObject { sucesso = result });
        }

        [AllowAnonymous]
        public JsonResult VerificarCPF(string cpf)
        {
            var result = new SerUsuario().VerificarCPF(cpf);
            if(result)
                return Json(new JsonObject { sucesso = false, mensagem = "CPF já cadastrado!" }, JsonRequestBehavior.AllowGet);
            else
                return Json(new JsonObject { sucesso = true }, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult VerificarCodigoEmail(string codigo, string email)
        {
            var result = new SerUsuario().VerificarCodigoEmail(codigo, email);

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult EnviarCodigoEmail(string email, string nome)
        {
            var result = new SerUsuario().EnviarCodigoEmail(email, nome);

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public ActionResult Sair()
        {
            if (Request.Cookies["aiopcod"] != null)
                Response.Cookies["aiopcod"].Expires = Util.DateTimeNowBR().AddHours(-1);
            if (Request.Cookies["aiopemail"] != null)
                Response.Cookies["aiopemail"].Expires = Util.DateTimeNowBR().AddHours(-1);
            if (Request.Cookies["aiopnome"] != null)
                Response.Cookies["aiopnome"].Expires = Util.DateTimeNowBR().AddHours(-1);
            if (Request.Cookies["aioploadingUser"] != null)
                Response.Cookies["aioploadingUser"].Expires = Util.DateTimeNowBR().AddHours(-1);
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult RecuperarSenha(Usuario u)
        {
            var result = new SerUsuario().RecuperarLogin(u.Email, out string mensagem);
            if (result)
                mensagem = $"A recuperação de senha foi enviada para o e-mail: {u.Email}. Caso não ache, verifique em sua caixa de spam.";
            else if (!result && string.IsNullOrWhiteSpace(mensagem))
                mensagem = "Não foi possível completar a solicitação. Tente novamente.";
            return Json(new JsonObject { mensagem = mensagem, sucesso = result });
        }

        public ActionResult Conta()
        {
            int codUsuario = Util.GetCodUsuario(Request);
            if (codUsuario == 0)
            {
                FormsAuthentication.SignOut();
                return RedirectToAction("Login", "Usuario");
            }
            var u = new SerUsuario().Obter(codUsuario);
            return View(u);
        }

        [HttpPost]
        public JsonResult SalvarUsuario(Usuario u)
        {
            var result = new SerUsuario().Editar(u);
            if(result.sucesso)
            {
                Response.Cookies.Add(new HttpCookie("aiopnome")
                {
                    Value = u.Nome,
                    Expires = Util.DateTimeNowBR().AddHours(1)
                });
            }
            return Json(result);
        }

        public JsonResult SalvarNovaSenha(string senhaAtual, string novaSenha)
        {
            var result = new SerUsuario().SalvarNovaSenha(Util.GetCodUsuario(Request), senhaAtual, novaSenha);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult SalvarEndereco(Endereco e)
        {
            var result = new SerUsuario().SalvarEndereco(e, Util.GetCodUsuario(Request));
            return Json(result);
        }

        public JsonResult ObterEndereco()
        {
            var result = new SerUsuario().ObterEndereco(Util.GetCodUsuario(Request));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult SalvarEnderecoCobranca(Endereco e)
        {
            var result = new SerUsuario().SalvarEnderecoCobranca(e, Util.GetCodUsuario(Request));
            return Json(result);
        }

        public JsonResult ObterEnderecoCobranca()
        {
            var result = new SerUsuario().ObterEnderecoCobranca(Util.GetCodUsuario(Request));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Obter()
        {
            var result = new SerUsuario().ObterSerialize(Util.GetCodUsuario(Request));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public JsonResult AssinarEmail(string email)
        {
            var result = new SerUsuario().AssinarEmail(email);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}