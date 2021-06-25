using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class ImagemProduto
    {
        public int CodImagemProduto { get; set; }
        public int CodProduto { get; set; }
        public string Url { get; set; }
        public int Ordem { get; set; }
        public bool Miniatura { get; set; }
    }
}
