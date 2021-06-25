using Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Wirecard.Models;

namespace Servicos
{
    public class SerEmail
    {
        private readonly string Assinatura = @"<table>
		                                           <tr>
                                                       <td>
                                                           <img src='https://aiopratas.com.br/Content/images/logo-min320x92.jpg' style='width: 104px;padding-right: 32px;'>
                                                       </td>
			                                           <td style='font-family:tahoma,arial,verdana;font-size:12px'> <strong>Equipe AIO Pratas</strong>
				                                           <br/> <strong>E-mail de atendimento:</strong> aiopratas@gmail.com
				                                           <br><a href='https://www.aiopratas.com.br/' target='_blank'><span style='color:blue'>www.aiopratas.com.br</span></a> 
			                                           </td>
		                                           </tr>
	                                           </table>";
        public async Task<bool> EnviarAsync(string dest, string assunto, string mensagem, string from, string fromPass)
        {
            var client = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(from, fromPass)
            };
            var mail = new MailMessage
            {
                Sender = new MailAddress(from),
                From = new MailAddress(dest, "AIO Pratas")
            };
            mail.To.Add(new MailAddress(dest));
            mail.Subject = assunto;
            mail.Body = mensagem;
            mail.IsBodyHtml = true;
            try
            {
                await client.SendMailAsync(mail);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool Enviar(string dest, string assunto, string mensagem, string from, string fromPass)
        {
            var client = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(from, fromPass)
            };
            var mail = new MailMessage
            {
                Sender = new MailAddress(from),
                From = new MailAddress(dest, "AIO Pratas")
            };
            mail.To.Add(new MailAddress(dest));
            mail.Subject = assunto;
            mail.Body = mensagem;
            mail.IsBodyHtml = true;
            try
            {
                client.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool EnviarComImagem(string email, string assunto, string mensagem, string from, string fromPass)
        {
            var client = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Credentials = new NetworkCredential(from, fromPass),
                EnableSsl = true,
                Port = 587,
                DeliveryMethod = SmtpDeliveryMethod.Network
            };
            var mail = new MailMessage
            {
                Sender = new MailAddress(from),
                From = new MailAddress(email)
            };

            mail.To.Add(new MailAddress(email));
            mail.Subject = assunto;
            mail.IsBodyHtml = true;
            mail.AlternateViews.Add(ObterEmailComImagem($"{ConfigurationManager.AppSettings["Ambiente"]}Content/images/logo/Logo_tm_13.png", mensagem));
            mail.Priority = MailPriority.High;
            try
            {
                client.Send(mail);
                return true;
            }
            catch
            {
                return false;
            }
        }
        private AlternateView ObterEmailComImagem(string url, string mensagem)
        {
            Stream stream = new WebClient().OpenRead(url);
            LinkedResource res = new LinkedResource(stream)
            {
                ContentId = Guid.NewGuid().ToString()
            };
            mensagem = mensagem.Replace("{imgLogo}", $"https://www.bomagendador.com.br/Content/images/logo/Logo_tm_13.png");
            AlternateView alternateView = AlternateView.CreateAlternateViewFromString(mensagem, null, MediaTypeNames.Text.Html);
            alternateView.LinkedResources.Add(res);
            return alternateView;
        }
        public string CorpoPedidoRealizado(Pedido p, OrderResponse pWire)
        {
            var trs = string.Empty;
            var pagamento = p.Pagamentos.OrderBy(x => x.Data).Last();
            var pagamentoWirecard = ((List<Payment>)((dynamic)pWire).Payments)
                             .Where(x => x.Id == pagamento.IdWirecardPagamento).Last();
            foreach (var item in p.ItensPedido)
            {
                string obs = string.IsNullOrWhiteSpace(item.Observacao) ? string.Empty:  $"<small>Observações: <span>{item.Observacao}</span></small>";
                trs += $@"<tr>
				            <td style='padding: 11px 11px 11px 13px;border: 1px solid #dee2e6 !important;vertical-align: middle;text-align: center;border-right: 1px solid white !important;width: 100px;min-width: 100px;'>
					            <img src='{item.Produto.UrlImgASmall}' width='100' height='100'>
				            </td>
				            <td style='border: 1px solid #dee2e6;border-left: 1px solid white;padding-left: 11px;'>
					            <b><a href='{ConfigurationManager.AppSettings["AmbienteSite"]}Produto/{item.Produto.Nome.Replace(" ", "-")}' style='text-decoration: none; color: #000000c4; text-transform: uppercase;font-size: 14px;'>{item.Produto.Nome}</a></b><br>
					            <small>Quantidade: <span class='txtValues'>{item.Quantidade}<span>x</span></span></small><br>
					            <span>R$ {item.Produto.Valor.ToString().Replace(".", ",")}</span><br>
					            {obs}
				            </td>
			            </tr>";
            }
            string txtPagamento = string.Empty;
            if (pagamento.Boleto)
            {
                txtPagamento = $@"O seu pedido foi realizado com sucesso, segue o Link do boleto e a linha digitável a abaixo. <br /><br />
		                    Link do Boleto: <a href='{pagamentoWirecard._Links.Payboleto.PrintHref}'>CLIQUE AQUI</a><br /><br />
		                    Linha digitável: <b>{pagamentoWirecard.FundingInstrument.Boleto.LineCode}</b>";
            }
            else
            {
                txtPagamento = $@"O seu pedido foi realizado com sucesso, segue as informações da cobrança abaixo. <br /><br />
		                    Cartão de Crédito<br />
		                    Nome: <b style='text-transform:capitalize'>{pagamentoWirecard.FundingInstrument.CreditCard.Holder.FullName}</b><br />
		                    Cartão: <b>XXXX XXXX XXXX {pagamentoWirecard.FundingInstrument.CreditCard.Last4}</b><br />
                            Bandeira: <b>{pagamentoWirecard.FundingInstrument.CreditCard.Brand}</b>";
            }
            return $@"<div style='padding-left:10px;font-family:tahoma,arial,verdana;' >
	                    <p>
		                    Olá <span style='text-transform:capitalize'>{p.Usuario.Nome}</span>, <br /><br /><br />
		                    {txtPagamento}
		                    <br/>
		                    <br/>
		                    O pedido será enviado em até 2 dias úteis após a confirmação do pagamento.
                            <br />
                            <br />
                            Número do Pedido: <b>AIO-{p.CodPedido}</b>
	                    </p>
	                    <h4 style='margin-bottom: 8px;'>PRODUTOS</h4>
	                    <table style='border-spacing: 0 10px;width:100%;'>
		                    <tbody>
			                   {trs}
		                    </tbody>
	                    </table>
	                    <br />
	                    {Assinatura}
                    </div>";
        }
        public string CorpoPedidoEnviado(Pedido p, OrderResponse pWire)
        {
            var trs = string.Empty;
            var pagamento = p.Pagamentos.OrderBy(x => x.Data).Last();
            var pagamentoWirecard = ((List<Payment>)((dynamic)pWire).Payments)
                             .Where(x => x.Id == pagamento.IdWirecardPagamento).Last();
            foreach (var item in p.ItensPedido)
            {
                string obs = string.IsNullOrWhiteSpace(item.Observacao) ? string.Empty : $"<small>Observações: <span>{item.Observacao}</span></small>";
                trs += $@"<tr>
				            <td style='padding: 11px 11px 11px 13px;border: 1px solid #dee2e6 !important;vertical-align: middle;text-align: center;border-right: 1px solid white !important;width: 100px;min-width: 100px;'>
					            <img src='{item.Produto.UrlImgASmall}' width='100' height='100'>
				            </td>
				            <td style='border: 1px solid #dee2e6;border-left: 1px solid white;padding-left: 11px;'>
					            <b><a href='{ConfigurationManager.AppSettings["AmbienteSite"]}Produto/{item.Produto.Nome.Replace(" ", "-")}' style='text-decoration: none; color: #000000c4; text-transform: uppercase;font-size: 14px;'>{item.Produto.Nome}</a></b><br>
					            <small>Quantidade: <span class='txtValues'>{item.Quantidade}<span>x</span></span></small><br>
					            <span>R$ {item.Produto.Valor.ToString().Replace(".", ",")}</span><br>
					            {obs}
				            </td>
			            </tr>";
            }
            return $@"<div style='padding-left:10px;font-family:tahoma,arial,verdana;' >
	                    <p style='text-transform:capitalize'>
		                    Olá {p.Usuario.Nome}, <br /><br />
	                    </p>
                        <span>O pagamento do seu pedido foi <b>confirmado</b>, seu pedido já está com a transportadora para entregar no prazo estimado. <br /></span>
                        <h4>SEGUE AS INFORMAÇÕES:</h4>
                        Número do Pedido: <b>AIO-{p.CodPedido}</b><br>
                        <span>Código de rastreio para acompanhar o pedido com a transportadora:</span>
		                <a href='https://www.melhorrastreio.com.br/rastreio/{p.CodigoRastreio}'>{p.CodigoRastreio}</a><br />
                        <span>Para acompanhar o pedido em nosso site:</span>
                        <a href='{ConfigurationManager.AppSettings["AmbienteSite"] + $"Pedido/{p.CodPedido}"}'>CLIQUE AQUI</a>
                        <br />
                        <br />                        
                        <h4>ENDEREÇO DE ENTREGA:</h4>
		                {p.Usuario.Logradouro + ", " + p.Usuario.Numero + (p.Usuario.Complemento != null && p.Usuario.Complemento != string.Empty ? ", " + p.Usuario.Complemento : string.Empty) + "<br>" + p.Usuario.Bairro + ", " + p.Usuario.Cidade + "-" + p.Usuario.UF + ", " + p.Usuario.CEP}
                        <br />                        
                        <br />
	                    <h4 style='margin-bottom: 8px;'>PRODUTOS</h4>
	                    <table style='border-spacing: 0 10px;width:100%;'>
		                    <tbody>
			                   {trs}
		                    </tbody>
	                    </table>
                        <p>Nós agradecemos muito a sua compra, é um prazer te-lo como nosso cliente.</p>
	                    <br />
	                    {Assinatura}
                    </div>";
        }
        public string CorpoRecuperacaoSenha(Usuario u)
        {
            return $@"<div style='padding-left:10px;font-family:tahoma,arial,verdana;'>
                        <p style='text-transform:capitalize'>Olá {u.Nome},</p><br />
	                    <span>
	                        Olá à sua senha de acesso é: <b>{SerCriptografia.Decrypt(u.Senha)}</b>
	                    </span><br />
                        <span>
	                        Recomendamos que exclua este e-mail para a segurança de sua conta.
	                    </span><br /><br />
	                    {Assinatura}
                      </div>";
        }
        public string CorpoVerificacaoEmail(string codigo, string nome)
        {
            return $@"<div style='padding-left:10px;font-family:tahoma,arial,verdana;'>
                        <p style='text-transform:capitalize'>Olá {nome},</p>
	                    <span>O seu código de verificação da conta é: </span><b style='font-size: 24px;'>{codigo}</b>
                        <br />
                        <br />
	                    {Assinatura}
                      </div>";
        }
    }
}