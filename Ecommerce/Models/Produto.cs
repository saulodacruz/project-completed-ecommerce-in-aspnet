using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Models
{
    public class Produto
    {
        public int CodProduto { get; set; }
        public string Nome { get; set; }
        public string Descricao { get; set; }
        public decimal Valor { get; set; }
        public string MateriaPrima { get; set; }
        public decimal Altura { get; set; }
        public decimal Largura { get; set; }
        public decimal Comprimento { get; set; }
        public decimal Espessura { get; set; }
        public decimal Diametro { get; set; }
        public decimal Peso { get; set; }
        public string UrlImgA { get; set; }
        public string UrlImgB { get; set; }
        public string UrlImgC { get; set; }
        public string UrlImgD { get; set; }
        public string UrlImgASmall { get; set; }
        public string UrlImgBSmall { get; set; }
        public char CodTipoEmbalagem { get; set; }
        public DateTime? DataDesabilitado { get; set; }
        public DateTime DataCadastro { get; set; }
        public DateTime DataAtualizado { get; set; }
        public bool FreteGratis { get; set; }
        public bool ProdutoEsgotado { get; set; }
        public int? QtdDisponiveis { get; set; }
        public bool OcultarProduto { get; set; }
        public decimal ValorAnterior { get; set; }
        public decimal ValorAtacado { get; set; }
        public string ObsBackOffice { get; set; }
        public int Relevancia { get; set; }
        public List<Categoria> Categorias { get; set; }
        public List<ImagemProduto> ImagensProduto { get; set; }
        public List<ProdutoObservacoes> ProdutoObservacoes { get; set; }
        public List<Avaliacao> Avaliacoes { get; set; }
        public TipoEmbalagem TipoEmbalagem { get; set; }
    }
}
