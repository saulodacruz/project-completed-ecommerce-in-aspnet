using EcommerceAdmin.Models;
using Models;
using Servicos;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EcommerceAdmin.Controllers
{
    [Authorize]
    public class ProdutoController : Controller
    {
        readonly string erroCampos = "Cadastro não realizado. Revise os campos.";
        public ActionResult Produtos()
        {
            var produtos = new SerProduto().Obter(string.Empty);
            return View(produtos);
        }
        public ActionResult Produto(int? codProduto)
        {
            ViewBag.TipoEmbalagem = new SerTipoEmbalagem().Obter();
            if (codProduto > 0)
            {
                ViewBag.Categorias = new SerCategoria().Obter().OrderBy(x => x.Nome);
                var produto = new SerProduto().Obter((int)codProduto, true);
                return View(produto);
            }
            return View(new Produto());
        }
        public ActionResult ObterAvaliacoes(int codProduto)
        {
            var result = new SerAvaliacao().ObterPorProduto(codProduto);
            return PartialView("_Avaliacoes", result);
        }
        [HttpPost]
        public ActionResult Produto(ViewModelProduto p)
        {
            Produto produto = new Produto();
            if (p.Produto == null)
            {
                ViewBag.Erro = erroCampos;
                return View(produto);
            }
            p.Produto.FreteGratis = Request["Produto.FreteGratis"] == "on" ? true : false;
            p.Produto.ProdutoEsgotado = Request["Produto.ProdutoEsgotado"] == "on" ? true : false;
            p.Produto.OcultarProduto = Request["Produto.OcultarProduto"] == "on" ? true : false;

            ViewBag.Categorias = new SerCategoria().Obter().OrderBy(x => x.Nome);
            ViewBag.TipoEmbalagem = new SerTipoEmbalagem().Obter();
            if (p.Produto.CodProduto > 0)
            {
                if (p.FileImagemA != null)
                    p.Produto = SalvarImagem(p, "A");
                if (p.FileImagemB != null)
                    p.Produto = SalvarImagem(p, "B");
                if (p.FileImagemC != null)
                    p.Produto = SalvarImagem(p, "C");
                if (p.FileImagemD != null)
                    p.Produto = SalvarImagem(p, "D");
                if (p.FileImagemASmall != null)
                    p.Produto = SalvarImagem(p, "AS");
                if (p.FileImagemBSmall != null)
                    p.Produto = SalvarImagem(p, "BS");

                produto = new SerProduto().Editar(p.Produto);
            }
            else
                produto = new SerProduto().Cadastrar(p.Produto);

            if (produto == null)
            {
                ViewBag.Erro = erroCampos;
                return View(p.Produto);
            }
            else if (produto.CodProduto <= 0)
            {
                ViewBag.Erro = erroCampos;
                return View(p.Produto);
            }
            else
                return RedirectToAction("Produto", new { codProduto = produto.CodProduto });
        }
        private Produto SalvarImagem(ViewModelProduto p, string urlImg)
        {
            var caminhoLogoAntigo = "/";
            switch (urlImg)
            {
                case "A":
                    if (!string.IsNullOrWhiteSpace(p.Produto.UrlImgA))
                        caminhoLogoAntigo = p.Produto.UrlImgA.Replace(ConfigurationManager.AppSettings["AmbienteProducao"], "");
                    break;
                case "B":
                    if (!string.IsNullOrWhiteSpace(p.Produto.UrlImgB))
                        caminhoLogoAntigo = p.Produto.UrlImgB.Replace(ConfigurationManager.AppSettings["AmbienteProducao"], "");
                    break;
                case "C":
                    if (!string.IsNullOrWhiteSpace(p.Produto.UrlImgC))
                        caminhoLogoAntigo = p.Produto.UrlImgC.Replace(ConfigurationManager.AppSettings["AmbienteProducao"], "");
                    break;
                case "D":
                    if (!string.IsNullOrWhiteSpace(p.Produto.UrlImgD))
                        caminhoLogoAntigo = p.Produto.UrlImgD.Replace(ConfigurationManager.AppSettings["AmbienteProducao"], "");
                    break;
                case "AS":
                    if (!string.IsNullOrWhiteSpace(p.Produto.UrlImgASmall))
                        caminhoLogoAntigo = p.Produto.UrlImgASmall.Replace(ConfigurationManager.AppSettings["AmbienteProducao"], "");
                    break;
                case "BS":
                    if (!string.IsNullOrWhiteSpace(p.Produto.UrlImgBSmall))
                        caminhoLogoAntigo = p.Produto.UrlImgBSmall.Replace(ConfigurationManager.AppSettings["AmbienteProducao"], "");
                    break;
            }

            using (ServicoFTP ftp = new ServicoFTP(caminhoLogoAntigo))
            {
                ftp.DeleteFile();
                ftp.CreateDirectory($"/ProdutosEcommerce/{p.Produto.CodProduto}");
                ftp._caminhoArquivo = $"/ProdutosEcommerce/{p.Produto.CodProduto}/{p.Produto.Nome.Trim().Replace(" ", "-")}-{urlImg}.jpg";
                MemoryStream target = new MemoryStream();

                switch (urlImg)
                {
                    case "A":
                        p.FileImagemA.InputStream.CopyTo(target);
                        break;
                    case "B":
                        p.FileImagemB.InputStream.CopyTo(target);
                        break;
                    case "C":
                        p.FileImagemC.InputStream.CopyTo(target);
                        break;
                    case "D":
                        p.FileImagemD.InputStream.CopyTo(target);
                        break;
                    case "AS":
                        p.FileImagemASmall.InputStream.CopyTo(target);
                        break;
                    case "BS":
                        p.FileImagemBSmall.InputStream.CopyTo(target);
                        break;
                }

                if (ftp.SaveFile(target.ToArray()))
                {
                    switch (urlImg)
                    {
                        case "A":
                            p.FileImagemA.InputStream.CopyTo(target);
                            p.Produto.UrlImgA = (ConfigurationManager.AppSettings["AmbienteProducao"].ToString() + ftp._caminhoArquivo);
                            break;
                        case "B":
                            p.FileImagemB.InputStream.CopyTo(target);
                            p.Produto.UrlImgB = (ConfigurationManager.AppSettings["AmbienteProducao"].ToString() + ftp._caminhoArquivo);
                            break;
                        case "C":
                            p.FileImagemC.InputStream.CopyTo(target);
                            p.Produto.UrlImgC = (ConfigurationManager.AppSettings["AmbienteProducao"].ToString() + ftp._caminhoArquivo);
                            break;
                        case "D":
                            p.FileImagemD.InputStream.CopyTo(target);
                            p.Produto.UrlImgD = (ConfigurationManager.AppSettings["AmbienteProducao"].ToString() + ftp._caminhoArquivo);
                            break;
                        case "AS":
                            p.FileImagemASmall.InputStream.CopyTo(target);
                            p.Produto.UrlImgASmall = (ConfigurationManager.AppSettings["AmbienteProducao"].ToString() + ftp._caminhoArquivo);
                            break;
                        case "BS":
                            p.FileImagemBSmall.InputStream.CopyTo(target);
                            p.Produto.UrlImgBSmall = (ConfigurationManager.AppSettings["AmbienteProducao"].ToString() + ftp._caminhoArquivo);
                            break;
                    }
                }
            }
            return p.Produto;
        }
        public ActionResult Remover(int codProduto)
        {
            new SerProduto().Remover(codProduto);
            return RedirectToAction("Produtos");
        }
        public ActionResult AdicionarObservacao(int codProduto, string nome, string tipoObservacao, string opcoesCombo, bool obrigatorio)
        {
            new SerProdutoObservacoes().Cadastrar(new ProdutoObservacoes {
                CodProduto = codProduto,
                Nome = nome,
                Tipo = tipoObservacao,
                OpcoesCombo = opcoesCombo,
                Obrigatorio = obrigatorio
            });
            return RedirectToAction("Produto", new { codProduto});
        }
        public ActionResult RemoverObservacao(int codProduto, int codProdutoObservacoes)
        {
            new SerProdutoObservacoes().Remover(codProdutoObservacoes);
            return RedirectToAction("Produto", new { codProduto });
        }
        public ActionResult RemoverAvaliacao(int codAvaliacao, int codProduto)
        {
            new SerAvaliacao().Remover(codAvaliacao);
            return RedirectToAction("Produto", new { codProduto });
        }
    }
}