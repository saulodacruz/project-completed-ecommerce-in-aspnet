using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Pedido
    {
        public long CodPedido { get; set; }
        public int CodUsuario { get; set; }
        public decimal ValorTotal { get; set; }
        public int? CodCupom { get; set; }
        public DateTime Data { get; set; }
        public List<ItemPedido> ItensPedido { get; set; }
        public List<LogStatusPedido> LogStatusPedido { get; set; }
        public string Observacao { get; set; }
        public Usuario Usuario { get; set; }
        public Cupom Cupom { get; set; }
        public string CodigoRastreio { get; set; }
        public DateTime? DataPrevista { get; set; }
        public decimal ValorFrete { get; set; }
        public string IdWirecard { get; set; }
        public List<Pagamento> Pagamentos { get; set; }
        public int DiasFrete { get; set; }
        public bool EmailEnviado { get; set; }
        public string TipoFrete { get; set; }
        //not DB
        public string CodPedidoCripto { get; set; }
        public string IdWirecardCripto { get; set; }
    }
}
