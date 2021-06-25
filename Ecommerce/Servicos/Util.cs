using Repositorios;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Security;

namespace Servicos
{
    public static class Util
    {
        public static bool Producao
        {
            get
            {
                return ConfigurationManager.AppSettings["Producao"].ToString() == "1";
            }
        }
        public static readonly string MsgErroComum = "Não foi possível realizar a solicitação. Tente novamente.";
        public static readonly string EmailSuporte = ConfigurationManager.AppSettings["EmailSuporte"].ToString();
        public static readonly string EmailSuporteSenha = ConfigurationManager.AppSettings["EmailSuporteSenha"].ToString();
        public static readonly string EmailInformativo = ConfigurationManager.AppSettings["EmailInformativo"].ToString();
        public static readonly string EmailInformativoSenha = ConfigurationManager.AppSettings["EmailInformativoSenha"].ToString();
        public enum StatusPedido
        {
            AguardandoFormaPagamento = 1,
            PagamentoCriado = 2,
            AguardandoPagamento = 3,
            PagamentoEmAnalise = 4,
            PagamentoPreAutorizado = 5,
            PagamentoAutorizado = 6,
            PagamentoCancelado = 7,
            PagamentoReembolsado = 8,
            PagamentoEstornado = 9,
            PagamentoConcluido = 10,
            AguardandoAprovacao = 11,
            PedidoCancelado = 12,
            SeparandoPedido = 13,
            EncaminhadoParaPostagem = 14,
            PedidoPostadoCorreio = 15,
            PedidoEnviadoDestinatario = 16,
            PedidoCaminho = 17,
            PedidoEntregue = 18,
            PedidoNaoEntregue = 19,
            EntregaCancelada = 20,
            EnvioLiberado = 21
        }
        public static DateTime DateTimeNowBR() =>
            TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time"));
        public static string EncodeBase64(string str) =>
            Convert.ToBase64String(Encoding.UTF8.GetBytes(str));
        public static string DecodeBase64(string str) =>
            Encoding.UTF8.GetString(Convert.FromBase64String(str));
        public static int GetCodUsuario(HttpRequestBase Request)
        {
            try
            {
                return int.Parse(SerCriptografia.Decrypt(Request.Cookies["aiopcod"].Value));
            }
            catch
            {
                return 0;
            }
        } 
    }
}
