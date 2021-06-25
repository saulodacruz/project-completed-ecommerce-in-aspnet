using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Categoria
    {
        public int CodCategoria { get; set; }
        public string Nome { get; set; }
        public string Descricao { get; set; }
        public DateTime? DataDesabilitado { get; set; }
        public bool CategoriaPrincipal { get; set; }

        //Not DB
        public int CodProduto { get; set; }
    }
}
