using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ProdutoObservacoes
    {
        public int CodProdutoObservacoes { get; set; }
        public int CodProduto { get; set; }
        public string Nome { get; set; }
        public string Tipo { get; set; }
        public string OpcoesCombo { get; set; }
        public bool Obrigatorio { get; set; }
    }
}
