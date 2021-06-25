using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
using Repositorios;
using Servicos.Wirecard;

namespace Servicos
{
    public class SerPagamento
    {
        public JsonObject Finalizar(Pagamento p, int codUsuario)
        {
            try
            {
                if (Validar(p))
                {
                    var usuario = new SerUsuario().Obter(codUsuario);
                    var serWire = new ConnectWirecard();
                    var serPedido = new SerPedido();
                    var resultPagamentoWirecard = serWire.CriarPagamento(p, usuario);
                    if (!string.IsNullOrWhiteSpace(resultPagamentoWirecard.Id))
                    {
                        var status = resultPagamentoWirecard.Events.OrderBy(x => x.CreatedAt).Last();
                        var statusLocal = ConvertStatusOfWirecardPayment(status.Type);
                        var msgErroCartao = "Revise os dados do seu cartão de crédito e tente novamente.";
                        switch (statusLocal)
                        {
                            case (int)Util.StatusPedido.PagamentoCancelado:
                                if (resultPagamentoWirecard.CancellationDetails.Code == "3")
                                    resultPagamentoWirecard.CancellationDetails.Description = msgErroCartao;
                                return new JsonObject { sucesso = false, mensagem = resultPagamentoWirecard.CancellationDetails.Description };
                            case (int)Util.StatusPedido.PagamentoEstornado:
                                return new JsonObject { sucesso = false, mensagem = msgErroCartao };
                            case (int)Util.StatusPedido.PagamentoReembolsado:
                                return new JsonObject { sucesso = false, mensagem = msgErroCartao };
                        }

                        p.IdWirecardPagamento = resultPagamentoWirecard.Id;
                        p.Parcelas = p.Parcelas == 0 ? 1 : p.Parcelas;
                        var pagamento = new RepPagamento().Cadastrar(p);
                        if(pagamento == null)
                            return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };

                        serPedido.AlterarStatus(p.CodPedido, ConvertStatusOfWirecard(resultPagamentoWirecard.Status));
                        var pedidoWirecard = serWire.ObterPedido(p.IdWirecardPedido);
                        var pedido = serPedido.Obter(p.CodPedido);
                        var s = new SerEmail();
                        Task.Run(() =>
                            new SerEmail().EnviarAsync(
                                dest: pedido.Usuario.Email,
                                assunto: "Pedido Realizado",
                                mensagem: s.CorpoPedidoRealizado(pedido, pedidoWirecard),
                                from: Util.EmailInformativo,
                                fromPass: Util.EmailInformativoSenha)
                        );

                        return new JsonObject { sucesso = true, obj = p};
                    }
                    else
                        return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
                }
                else
                    return new JsonObject { sucesso = false, mensagem = "O pagamento não passou da validação. Revise os campos ou tente novamente." };
            }
            catch(Exception ex)
            {
                try
                {
                    var error = ((dynamic)ex.InnerException).wirecardError.errors[0].code;
                    string msg;
                    switch (error)
                    {
                        case "PAY-681":
                            msg = "O seu endereço de entrega ou cobrança foram informados incorretamente. Por favor realize um novo pedido com as informações corretas para corrigir isso.";
                            break;
                        default:
                            msg = "Houve um erro desconhecido ao processar o pagamento. Por favor revise os dados de sua conta e tente novamente ou entre em contato conosco.";
                            break;
                    }
                    return new JsonObject {
                        sucesso = false, mensagem = msg
                    };
                }
                catch
                {
                    return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
                }
            }
        }
        private bool Validar(Pagamento p)
        {
            if (p.CodPedido <= 0)
                return false;

            if (p.Boleto)
                return true;
            else
            {
                if (string.IsNullOrWhiteSpace(p.Nome))
                    return false;

                if (p.Parcelas <= 0)
                    return false;

                if (!IsCPF(p.CPF))
                    return false;

                if (p.DataNascimento == null)
                    return false;

                if (string.IsNullOrWhiteSpace(p.Hash))
                    return false;

                return true;
            }
        }
        private bool IsCPF(string cpf)
        {
            int[] multiplicador1 = new int[9] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplicador2 = new int[10] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            string tempCpf;
            string digito;
            int soma;
            int resto;
            cpf = cpf.Trim();
            cpf = cpf.Replace(".", "").Replace("-", "");
            if (cpf.Length != 11)
                return false;
            tempCpf = cpf.Substring(0, 9);
            soma = 0;

            for (int i = 0; i < 9; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador1[i];
            resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = resto.ToString();
            tempCpf = tempCpf + digito;
            soma = 0;
            for (int i = 0; i < 10; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador2[i];
            resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = digito + resto.ToString();
            return cpf.EndsWith(digito);
        }
        public int ConvertStatusOfWirecard(string statusWirecard)
        {
            switch (statusWirecard)
            {
                case "CREATED":
                    return (int)Util.StatusPedido.PagamentoCriado;
                case "WAITING":
                    return (int)Util.StatusPedido.AguardandoPagamento;
                case "IN_ANALYSIS":
                    return (int)Util.StatusPedido.PagamentoEmAnalise;
                case "PRE_AUTHORIZED":
                    return (int)Util.StatusPedido.PagamentoPreAutorizado;
                case "AUTHORIZED":
                    return (int)Util.StatusPedido.PagamentoAutorizado;
                case "CANCELLED":
                    return (int)Util.StatusPedido.PagamentoCancelado;
                case "REFUNDED":
                    return (int)Util.StatusPedido.PagamentoReembolsado;
                case "REVERSED":
                    return (int)Util.StatusPedido.PagamentoEstornado;
                case "SETTLED":
                    return (int)Util.StatusPedido.PagamentoConcluido;
                default:
                    throw new Exception();
            }
        }
        public int ConvertStatusOfWirecardPayment(string statusWirecard)
        {
            switch (statusWirecard)
            {
                case "PAYMENT.CREATED":
                    return (int)Util.StatusPedido.PagamentoCriado;
                case "PAYMENT.WAITING":
                    return (int)Util.StatusPedido.AguardandoPagamento;
                case "PAYMENT.IN_ANALYSIS":
                    return (int)Util.StatusPedido.PagamentoEmAnalise;
                case "PAYMENT.PRE_AUTHORIZED":
                    return (int)Util.StatusPedido.PagamentoPreAutorizado;
                case "PAYMENT.AUTHORIZED":
                    return (int)Util.StatusPedido.PagamentoAutorizado;
                case "PAYMENT.CANCELLED":
                    return (int)Util.StatusPedido.PagamentoCancelado;
                case "PAYMENT.REFUNDED":
                    return (int)Util.StatusPedido.PagamentoReembolsado;
                case "PAYMENT.REVERSED":
                    return (int)Util.StatusPedido.PagamentoEstornado;
                case "PAYMENT.SETTLED":
                    return (int)Util.StatusPedido.PagamentoConcluido;
                default:
                    throw new Exception();
            }
        }
    }
}
