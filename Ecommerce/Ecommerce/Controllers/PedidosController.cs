using Ecommerce.Models;
using Ecommerce.Seguranca;
using Models;
using Servicos;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Wirecard.Models;

namespace Ecommerce.Controllers
{
    [Authorize]
    [Permissoes(Roles = "Cliente")]
    public class PedidosController : Controller
    {
        public ActionResult Index()
        {
            int codUsuario = Util.GetCodUsuario(Request);
            if (codUsuario == 0)
            {
                FormsAuthentication.SignOut();
                return RedirectToAction("Login", "Usuario");
            }
            var pedidos = new SerPedido().ObterPorUsuario(codUsuario);
            return View(pedidos);
        }

        public ActionResult Pedido(long codPedido)
        {
            int codUsuario = Util.GetCodUsuario(Request);
            if (codUsuario == 0)
            {
                FormsAuthentication.SignOut();
                return RedirectToAction("Login", "Usuario");
            }
            ViewBag.CodPedido = codPedido;
            return View();
        }

        public ActionResult ObterPedido(long codPedido)
        {
            var s = new SerPedido();
            var w = new ConnectWirecard();
            var pedido = s.Obter(codPedido);
            if (pedido.CodUsuario != Util.GetCodUsuario(Request))
                throw new Exception("Este pedido não pertence a esse usuário");
            ViewBag.Estorno = null;
            if (pedido.LogStatusPedido.Where(x => x.CodStatusPedido == (int)Util.StatusPedido.PedidoCancelado).Any())
                ViewBag.Estorno = s.ObterEstorno(pedido.CodPedido);

            var pedidoWirecard = w.ObterPedido(pedido.IdWirecard);
            var novosStatus = AtualizarStatusPagamento(pedidoWirecard, pedido);
            if (novosStatus.Count > 0)
                pedido = s.Obter(codPedido);
            var viewModel = new ViewModelPedido
            {
                Pedido = pedido,
                PedidoWirecard = pedidoWirecard
            };
            return PartialView("_Pedido", viewModel);
        }

        private List<LogStatusPedido> AtualizarStatusPagamento(OrderResponse pWire, Pedido p)
        {
            List<LogStatusPedido> lsp = new List<LogStatusPedido>();
            var r = new SerLogStatusPedido();
            if (pWire.Payments != null)
            {
                if (pWire.Payments.Count > 0)
                {
                    var pagamento = pWire.Payments.OrderBy(x => x.CreatedAt).Last();
                    pagamento.Events.ForEach(x =>
                    {
                        switch (x.Type)
                        {
                            case "PAYMENT.WAITING":
                                x.CreatedAt = x.CreatedAt.AddSeconds(1);
                                break;
                            case "PAYMENT.IN_ANALYSIS":
                                x.CreatedAt = x.CreatedAt.AddSeconds(2);
                                break;
                            case "PAYMENT.PRE_AUTHORIZED":
                                x.CreatedAt = x.CreatedAt.AddSeconds(3);
                                break;
                            case "PAYMENT.AUTHORIZED":
                                if(pagamento.FundingInstrument.Method == "CREDIT_CARD")
                                    x.CreatedAt = x.CreatedAt.AddHours(4).AddSeconds(4);
                                else
                                    x.CreatedAt = x.CreatedAt.AddSeconds(4);
                                break;
                            case "PAYMENT.CANCELLED":
                                if (pagamento.FundingInstrument.Method == "CREDIT_CARD")
                                    x.CreatedAt = x.CreatedAt.AddHours(4).AddSeconds(5);
                                else
                                    x.CreatedAt = x.CreatedAt.AddSeconds(5);
                                break;
                            case "PAYMENT.REFUNDED":
                                x.CreatedAt = x.CreatedAt.AddSeconds(6);
                                break;
                            case "PAYMENT.REVERSED":
                                x.CreatedAt = x.CreatedAt.AddSeconds(7);
                                break;
                        }
                    });
                    pagamento.Events.ForEach(status =>
                    {
                        var statusLocal = new SerPagamento().ConvertStatusOfWirecardPayment(status.Type);
                        var s = p.LogStatusPedido
                                .Where(x => x.StatusPedido.CodStatusPedido == statusLocal)
                                .FirstOrDefault();

                        if (s == null && status.Type != "PAYMENT.CREATED")
                        {
                            var novoStatus = new LogStatusPedido
                            {
                                CodPedido = p.CodPedido,
                                CodStatusPedido = statusLocal,
                                Data = status.CreatedAt
                            };
                            lsp.Add(r.Cadastrar(novoStatus));
                        }
                    });
                }
            }
            return lsp;
        }

        public ActionResult Carrinho()
        {
            int codUsuario = Util.GetCodUsuario(Request);
            if (codUsuario == 0)
            {
                FormsAuthentication.SignOut();
                return RedirectToAction("Login", "Usuario");
            }
            return View();
        }

        [HttpPost]      
        public JsonResult AtualizarCarrinho(List<JsonItemCarrinho> itens)
        {
            var result = new SerItemCarrinho().AtualizarCarrinho(itens, Util.GetCodUsuario(Request));
            return Json(result);
        }

        public JsonResult ObterCarrinho()
        {
            var result = new SerItemCarrinho().JsonObter(Util.GetCodUsuario(Request));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObterCarrinhoFrete()
        {
            var result = new SerItemCarrinho().JsonObterCarrinhoFrete(Util.GetCodUsuario(Request));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult RemoverItemCarrinho(JsonItemCarrinho item)
        {
            var result = new SerItemCarrinho().RemoverItem(item.cod, item.obs, Util.GetCodUsuario(Request), item.qtd);
            return Json(result);
        }

        [HttpPost]
        public JsonResult AdicionarItemCarrinho(JsonItemCarrinho item, bool update)
        {
            var result = new SerItemCarrinho().AdicionarItem(Util.GetCodUsuario(Request), item, update);
            return Json(result);
        }

        [HttpPost]
        public JsonResult AtualizarItensDesejo(List<JsonItemDesejo> itens)
        {
            var result = new SerItemDesejo().AtualizarItens(itens, Util.GetCodUsuario(Request));
            return Json(result);
        }

        public JsonResult ObterItensDesejo()
        {
            var result = new SerItemDesejo().JsonObter(Util.GetCodUsuario(Request));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RemoverItemDesejo(int codProduto)
        {
            var result = new SerItemDesejo().RemoverItem(codProduto, Util.GetCodUsuario(Request));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AdicionarItemDesejo(int codProduto)
        {
            var result = new SerItemDesejo().AdicionarItem(Util.GetCodUsuario(Request), codProduto);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObterCupom(string codigo)
        {
            var result = new SerCupom().Obter(codigo);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Cadastrar(Pedido p, string valorFreteCrip, string diasFreteCrip)
        {
            p.ValorFrete = valorFreteCrip == "0" ? 0 : Convert.ToDecimal(SerCriptografia.Decrypt(valorFreteCrip).Replace(".", ","));
            p.CodUsuario = Util.GetCodUsuario(Request);
            p.DiasFrete = Convert.ToInt32(SerCriptografia.Decrypt(diasFreteCrip));
            var result = new SerPedido().Cadastrar(p);
            return Json(result);
        }

        [HttpPost]
        public JsonResult Cancelar(Estorno e)
        {
            var s = new SerPedido();
            var pedido = s.Obter(e.CodPedido);
            if (pedido.CodUsuario != Util.GetCodUsuario(Request))
                throw new Exception("Este pedido não pertence a esse usuário");

            var result = s.Cancelar(e);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}