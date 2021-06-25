using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ItemCarrinho
    {
        public int CodProduto { get; set; }
        public int CodUsuario { get; set; }
        public int Quantidade { get; set; }
        public Produto Produto { get; set; }
        public string Observacao { get; set; }
    }
}
