using Models;
using Repositorios;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerPedido
    {
        public List<Pedido> Obter()
        {
            var list = new RepPedido().Obter();
            return list;
        }
        public List<Pedido> ObterPorStatus(int codStatus)
        {
            var list = new RepPedido().ObterPorStatus(codStatus);
            return list;
        }
        public List<Pedido> ObterPorUsuario(int codUsuario)
        {
            var list = new RepPedido().ObterPorUsuario(codUsuario);
            return list;
        }
        public List<Pedido> ObterPorCupom(string codigo)
        {
            var list = new RepPedido().ObterPorCupom(codigo);
            return list;
        }
        public Pedido Obter(long codPedido)
        {
            var item = new RepPedido().Obter(codPedido);
            return item;
        }
        public JsonObject Cadastrar(Pedido p)
        {
            var r = new RepPedido();
            var itensCarrinho = new RepItemCarrinho().Obter(p.CodUsuario, false);
            p.Data = Util.DateTimeNowBR();
            if (Validar(p, novo: true) && itensCarrinho.Count > 0)
            {
                var usuario = new RepUsuario().Obter(p.CodUsuario);
                p.ValorTotal = 0;
                var pedido = r.Cadastrar(p);
                if (pedido == null)
                    return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
                if (pedido.CodPedido <= 0)
                    return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };

                bool acaoPedidoParaCarrinhoFeito = false;
                try
                {
                    pedido.ItensPedido = PassarCarrinhoParaPedido(pedido, itensCarrinho);
                    pedido.ValorTotal = ObterValorTotal(pedido, out decimal valorCupom);
                    pedido.LogStatusPedido = new List<LogStatusPedido> { GravarLog(pedido.CodPedido, novoCadastro: true, codStatusPedido: (int)Util.StatusPedido.AguardandoFormaPagamento) };
                    if (r.Editar(pedido) == null)
                    {
                        PassarPedidoParaCarrinho(pedido);
                        acaoPedidoParaCarrinhoFeito = true;
                        r.Remover(pedido.CodPedido);
                        return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
                    }
                    pedido.Usuario = usuario;
                    var pedidoWirecard = new ConnectWirecard().CriarPedido(pedido, valorCupom);
                    if (pedidoWirecard.Id.Length > 0)
                    {
                        r.InserirIdWirecard(pedido.CodPedido, pedidoWirecard.Id);
                        return new JsonObject { sucesso = true, obj = pedido };
                    }
                    else
                    {
                        PassarPedidoParaCarrinho(pedido);
                        acaoPedidoParaCarrinhoFeito = true;
                        r.Remover(pedido.CodPedido);
                        return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
                    }
                }
                catch
                {
                    if (!acaoPedidoParaCarrinhoFeito)
                        PassarPedidoParaCarrinho(pedido);
                    r.Remover(pedido.CodPedido);
                }
            }
            else if (itensCarrinho.Count <= 0)
                return new JsonObject { sucesso = false, mensagem = "O Carrinho está vazio." };
            return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
        }
        public bool Salvar(Pedido p)
        {
            if (p == null)
                return false;
            return new RepPedido().Salvar(p);
        }
        public Pedido Editar(Pedido p)
        {
            var r = new RepPedido();
            if (Validar(p) && p.CodPedido > 0)
            {
                p.ItensPedido = new RepItemPedido().ObterPorPedido(p.CodPedido);
                p.ValorTotal = ObterValorTotal(p, out decimal valorCupom);
                p.LogStatusPedido = new List<LogStatusPedido> { GravarLog(p.CodPedido, novoCadastro: false, codStatusPedido: (int)Util.StatusPedido.AguardandoAprovacao) };
                p = r.Editar(p);
                return p;
            }
            return null;
        }
        public bool AlterarStatus(long codPedido, int codStatusPedido)
        {
            var r = new RepLogStatusPedido().Cadastrar(new LogStatusPedido
            {
                CodPedido = codPedido,
                CodStatusPedido = codStatusPedido,
                Data = Util.DateTimeNowBR()
            });

            if (r == null)
                return false;

            return r.CodLogStatusPedido > 0;
        }
        private bool Validar(Pedido p, bool novo = false)
        {
            if (p.CodUsuario <= 0)
                return false;
            if (p.Data == null)
                return false;

            return true;
        }
        public LogStatusPedido GravarLog(long codPedido, bool novoCadastro, int codStatusPedido)
        {
            var r = new RepLogStatusPedido();
            if (!novoCadastro)
            {
                var log = r.Obter(codPedido).Where(x => x.CodStatusPedido == codStatusPedido);
                if (log.Count() > 0)
                    return log.FirstOrDefault();
            }
            return r.Cadastrar(new LogStatusPedido
            {
                CodPedido = codPedido,
                CodStatusPedido = codStatusPedido,
                Data = Util.DateTimeNowBR()
            });
        }
        private List<ItemPedido> PassarCarrinhoParaPedido(Pedido p, List<ItemCarrinho> itensCarrinho)
        {
            var list = new List<ItemPedido>();
            var ric = new RepItemCarrinho();
            var rip = new RepItemPedido();
            var rp = new RepProduto();
            itensCarrinho.ForEach(x =>
            {
                var itemPedido = new ItemPedido
                {
                    CodPedido = p.CodPedido,
                    CodProduto = x.CodProduto,
                    Quantidade = x.Quantidade,
                    Observacao = x.Observacao
                };
                if (rip.Cadastrar(itemPedido))
                {
                    itemPedido.Produto = rp.Obter(x.CodProduto);
                    list.Add(itemPedido);
                    ric.Remover(x.CodProduto, x.CodUsuario);
                }
                else throw new Exception();
            });
            return list;
        }
        private void PassarPedidoParaCarrinho(Pedido p)
        {
            var list = new List<ItemCarrinho>();
            var ric = new RepItemCarrinho();
            var rip = new RepItemPedido();
            var rp = new RepProduto();
            p.ItensPedido.ForEach(x =>
            {
                var itemCarrinho = new ItemCarrinho
                {
                    CodProduto = x.CodProduto,
                    Quantidade = x.Quantidade,
                    Observacao = x.Observacao,
                    CodUsuario = p.CodUsuario
                };
                if (ric.Cadastrar(itemCarrinho))
                {
                    rip.Remover(x.CodProduto, p.CodPedido);
                }
                else throw new Exception();
            });
        }
        private decimal ObterValorTotal(Pedido p, out decimal valorCupom)
        {
            decimal valorTotal = 0;
            p.ItensPedido.ForEach(x =>
            {
                valorTotal += (x.Produto.Valor * x.Quantidade);
            });
            if (p.CodCupom > 0)
            {
                var cupom = new RepCupom().Obter((int)p.CodCupom);
                valorTotal = valorTotal - cupom.Valor;
                valorCupom = cupom.Valor;
                if (valorTotal < 0)
                    return 0;
            }
            else
                valorCupom = 0;
            valorTotal += p.ValorFrete;
            return valorTotal;
        }
        public JsonObject Cancelar(Estorno e)
        {
            var rlsp = new RepLogStatusPedido();
            var r = new RepPedido();
            var pedido = r.Obter(e.CodPedido);
            bool isBoleto = pedido.Pagamentos.OrderBy(x => x.Data).LastOrDefault().Boleto;
            if (isBoleto)
                e.TipoPagamento = "BOLETO";
            else
                e.TipoPagamento = "CREDITO";
            var estorno = r.CadastrarEstorno(e);
            estorno.Pedido = pedido;
            long codLogStatusPedido = 0;
            try
            {
                if (estorno.CodEstorno > 0)
                {
                    var log = rlsp.Cadastrar(new LogStatusPedido
                                            {
                                                CodPedido = e.CodPedido,
                                                CodStatusPedido = (int)Util.StatusPedido.PedidoCancelado,
                                                Data = Util.DateTimeNowBR()
                                            });
                    if (log.CodLogStatusPedido > 0)
                    {
                        codLogStatusPedido = log.CodLogStatusPedido;
                        if (isBoleto)
                            return new JsonObject { sucesso = true, mensagem = "Solicitação de reembolso realizada com sucesso. O reembolso será realizado em até 45 dias na conta bancária informada."};
                        else
                        {
                            var reembolso = new ConnectWirecard().ReembolsarPedido(estorno);
                            if (!string.IsNullOrWhiteSpace(reembolso.Id))
                            {
                                r.InserirIdWirecardEstorno(estorno.CodEstorno, reembolso.Id);
                                r.FinalizarEstorno(estorno.CodEstorno);
                                rlsp.Cadastrar(new LogStatusPedido
                                {
                                    CodPedido = e.CodPedido,
                                    CodStatusPedido = (int)Util.StatusPedido.PagamentoReembolsado,
                                    Data = Util.DateTimeNowBR()
                                });
                                return new JsonObject { sucesso = true, mensagem = "O Reembolso foi realizado com sucesso no mesmo cartão de crédito utilizado na compra." };
                            }
                            else
                                throw new Exception();
                        }
                    }
                    else
                    {
                        r.RemoverEstorno(estorno.CodPedido, (int)Util.StatusPedido.PagamentoEstornado);
                        return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
                    }
                }
                else
                    return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
            }
            catch(Exception ex)
            {
                r.RemoverEstorno(estorno.CodPedido, (int)Util.StatusPedido.PagamentoEstornado);
                rlsp.Remover(codLogStatusPedido);
                try
                {
                    return new JsonObject { sucesso = false, mensagem = ((dynamic)ex.InnerException).wirecardError.errors[0].description };
                }
                catch
                {
                    return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
                }
            }
        }
        public Estorno ObterEstorno(long codPedido)
        {
            var item = new RepPedido().ObterEstorno(codPedido);
            return item;
        }
        public bool EnviarEmail(long codPedido)
        {
            var serPedido = new SerPedido();
            var pedido = serPedido.Obter(codPedido);
            var pedidoWirecard = new ConnectWirecard().ObterPedido(pedido.IdWirecard);
            var s = new SerEmail();
            var result = Task.Run(() => s.EnviarAsync(
                                    dest: pedido.Usuario.Email,
                                    assunto: "Pedido em Transporte",
                                    mensagem: s.CorpoPedidoEnviado(pedido, pedidoWirecard),
                                    from: Util.EmailInformativo,
                                    fromPass: Util.EmailInformativoSenha));
            return new RepPedido().MarcarEmailEnviado(codPedido);
        }
        public int ConvertStatusOfMEnvio(string statusMEnvio)
        {
            switch (statusMEnvio)
            {
                case "pending":
                    return (int)Util.StatusPedido.EncaminhadoParaPostagem;
                case "released":
                    return (int)Util.StatusPedido.EnvioLiberado;
                case "posted":
                    return (int)Util.StatusPedido.PedidoPostadoCorreio;
                case "delivered":
                    return (int)Util.StatusPedido.PedidoEntregue;
                case "canceled":
                    return (int)Util.StatusPedido.PedidoCancelado;
                case "undelivered":
                    return (int)Util.StatusPedido.PedidoEntregue;
                default:
                    throw new Exception();
            }
        }
    }
}