using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ItemDesejo
    {
        public int CodProduto { get; set; }
        public int CodUsuario { get; set; }
        public Produto Produto { get; set; }
    }
}
