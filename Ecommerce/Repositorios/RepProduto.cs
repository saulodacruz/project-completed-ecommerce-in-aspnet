using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepProduto
    {
        public List<Produto> Obter(string top)
        {
            return Listar($@"SELECT {top} * FROM Produto 
                             WHERE DataDesabilitado IS NULL

                             SELECT * FROM TipoEmbalagem");
        }
        public List<Produto> Obter(string nome, string top)
        {
            return Listar($@"SELECT {top} * FROM Produto 
                             WHERE Nome LIKE '%{@nome}%' AND DataDesabilitado IS NULL

                             SELECT * FROM TipoEmbalagem", 
                             new[] { new SqlParameter("@nome", nome) });
        }
        public List<Produto> ObterPorCategoria(int[] codsCategoria, string top, bool incluirCategoria = false)
        {
            string query = $@"SELECT DISTINCT {top} (p.CodProduto)n, p.* FROM Produto p
                            JOIN ProdutoCategoria pc ON p.CodProduto = pc.CodProduto 
                            JOIN Categoria c ON pc.CodCategoria = c.CodCategoria
                            WHERE p.DataDesabilitado IS NULL AND c.CodCategoria IN({AddArrayParameters(codsCategoria, "categorias")})

                            SELECT * FROM TipoEmbalagem

                            SELECT c.*, pc.CodProduto, pc.CategoriaPrincipal
                            FROM ProdutoCategoria pc 
                            JOIN Categoria c ON pc.CodCategoria = c.CodCategoria";
            return Listar(query);
        }
        private string AddArrayParameters(int[] array, string paramName)
        {
            SqlCommand sqlCommand = new SqlCommand();
            var parameters = new string[array.Length];
            for (int i = 0; i < array.Length; i++)
            {
                parameters[i] = $"'{array[i]}'";
                sqlCommand.Parameters.AddWithValue(parameters[i], array[i]);
            }

            return string.Join(", ", parameters);
        }
        public List<Produto> ObterProdutosShop(string[] categorias, string top, bool incluirCategoria = false)
        {
            string query = $@"SELECT p.* FROM Produto p
                            JOIN ProdutoCategoria pc ON p.CodProduto = pc.CodProduto 
                            JOIN Categoria c ON pc.CodCategoria = c.CodCategoria
                            WHERE p.DataDesabilitado IS NULL AND c.Nome IN(@categorias)

                            SELECT * FROM TipoEmbalagem

                            SELECT c.*, pc.CodProduto, pc.CategoriaPrincipal
                            FROM ProdutoCategoria pc 
                            JOIN Categoria c ON pc.CodCategoria = c.CodCategoria";
            return Listar(query,
                          new[] { new SqlParameter("@categorias", string.Join(",", categorias.Select(x => x).ToArray())) });
        }
        public Produto Obter(int codProduto, bool incluirCategoria = false)
        {
            string queryCategoria = incluirCategoria ?
                @"SELECT c.*, pc.CodProduto, pc.CategoriaPrincipal FROM Produto p
                 JOIN ProdutoCategoria pc ON p.CodProduto = pc.CodProduto
                 JOIN Categoria c ON pc.CodCategoria = c.CodCategoria
                 WHERE p.DataDesabilitado IS NULL AND p.CodProduto = @codProduto"
                : string.Empty;
            return Obter($@"DECLARE @codTipoEmbalagem CHAR = (SELECT CodTipoEmbalagem FROM Produto WHERE CodProduto = @codProduto AND DataDesabilitado IS NULL)
                        SELECT * FROM Produto p
                        WHERE CodProduto = @codProduto AND DataDesabilitado IS NULL
                        SELECT * FROM dbo.TipoEmbalagem
                        WHERE CodTipoEmbalagem = @codTipoEmbalagem
                        SELECT * from dbo.ProdutoObservacoes 
                        WHERE CodProduto = @codProduto
                        {queryCategoria}",
                        new[] { new SqlParameter("@codProduto", codProduto) });
        }
        public Produto ObterPorNome(string nome, bool incluirCategoria = false, bool incluirImagens = false, bool incluirObservacoes = false, bool incluirAvaliacoes = false)
        {
            return Obter(@"DECLARE 
                            @codProduto INT = (SELECT TOP 1 CodProduto FROM Produto WHERE Nome = @nome AND DataDesabilitado IS NULL),
                            @codTipoEmbalagem CHAR = (SELECT CodTipoEmbalagem FROM Produto WHERE Nome = @nome AND DataDesabilitado IS NULL)

                            SELECT * FROM Produto 
                            WHERE CodProduto = @codProduto AND DataDesabilitado IS NULL

                            SELECT * FROM dbo.TipoEmbalagem
                            WHERE CodTipoEmbalagem = @codTipoEmbalagem

                            SELECT * from dbo.ProdutoObservacoes po
                            JOIN dbo.Produto p ON po.CodProduto = p.CodProduto
                            WHERE p.CodProduto = @codProduto

                            SELECT * FROM dbo.Categoria c
                            JOIN dbo.ProdutoCategoria pc ON c.CodCategoria = pc.CodCategoria
                            WHERE pc.CodProduto = @codProduto
                            AND c.DataDesabilitado IS NULL

                            SELECT a.*, p.* FROM Avaliacao a
                            JOIN Usuario u ON a.CodUsuario = u.CodUsuario
                            JOIN Pessoa p ON u.CodPessoa = p.CodPessoa WHERE CodProduto = @codProduto

                            SELECT * FROM dbo.ImagemProduto 
                            WHERE CodProduto = @codProduto",
                           new[] { new SqlParameter("@nome", nome) });
        }
        public Produto Cadastrar(Produto p)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"INSERT INTO Produto (Nome,Descricao,Valor,MateriaPrima,Altura,Largura,Comprimento,Espessura,Diametro,Peso,UrlImgA,UrlImgB,UrlImgC,UrlImgD,UrlImgASmall,UrlImgBSmall,DataCadastro,DataAtualizado,CodTipoEmbalagem,FreteGratis,ProdutoEsgotado,QtdDisponiveis,OcultarProduto,ValorAnterior,ValorAtacado,ObsBackOffice,Relevancia)
                                            VALUES(@nome,@descricao,@valor,@materiaPrima,@altura,@largura,@comprimento,@espessura,@diametro,@peso,@urlImgA,@urlImgB,@urlImgC,@urlImgD,@urlImgASmall,@urlImgBSmall,@dataCadastro,@dataAtualizado, @codTipoEmbalagem, @freteGratis, @produtoEsgotado, @qtdDisponiveis, @ocultarProduto, @valorAnterior, @valorAtacado, @obsBackOffice, @relevancia)
                                            SELECT SCOPE_IDENTITY() CodProduto;",
                                            new[] {
                                                new SqlParameter("@nome", p.Nome ?? string.Empty),
                                                new SqlParameter("@descricao", p.Descricao ?? string.Empty),
                                                new SqlParameter("@valor", p.Valor),
                                                new SqlParameter("@materiaPrima", p.MateriaPrima ?? string.Empty),
                                                new SqlParameter("@altura", p.Altura),
                                                new SqlParameter("@largura", p.Largura),
                                                new SqlParameter("@comprimento", p.Comprimento),
                                                new SqlParameter("@espessura", p.Espessura),
                                                new SqlParameter("@peso", p.Peso),
                                                new SqlParameter("@diametro", p.Diametro),
                                                new SqlParameter("@urlImgA", p.UrlImgA ?? string.Empty),
                                                new SqlParameter("@urlImgB", p.UrlImgB ?? string.Empty),
                                                new SqlParameter("@urlImgC", p.UrlImgC ?? string.Empty),
                                                new SqlParameter("@urlImgD", p.UrlImgD ?? string.Empty),
                                                new SqlParameter("@urlImgASmall", p.UrlImgASmall ?? string.Empty),
                                                new SqlParameter("@urlImgBSmall", p.UrlImgBSmall ?? string.Empty),
                                                new SqlParameter("@dataCadastro", RepUtil.DateTimeNowBR()),
                                                new SqlParameter("@dataAtualizado", RepUtil.DateTimeNowBR()),
                                                new SqlParameter("@codTipoEmbalagem", p.CodTipoEmbalagem),
                                                new SqlParameter("@freteGratis", p.FreteGratis),
                                                new SqlParameter("@produtoEsgotado", p.ProdutoEsgotado),
                                                new SqlParameter("@qtdDisponiveis", p.QtdDisponiveis ?? (object)DBNull.Value),
                                                new SqlParameter("@ocultarProduto", p.OcultarProduto),
                                                new SqlParameter("@valorAnterior", p.ValorAnterior),
                                                new SqlParameter("@valorAtacado", p.ValorAtacado),
                                                new SqlParameter("@obsBackOffice", p.ObsBackOffice ?? string.Empty),
                                                new SqlParameter("@relevancia", p.Relevancia)
                                            }))
                {
                    while(dados.Read())
                        p.CodProduto = Convert.ToInt32(dados["CodProduto"]);

                    return p;
                };
            }
            catch
            {
                return null;
            }
        }
        public Produto Editar(Produto p)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"UPDATE Produto 
                                            SET Nome = @nome,
                                            Descricao = @descricao,
                                            Valor = @valor,
                                            MateriaPrima = @materiaPrima,
                                            Altura = @altura,
                                            Largura = @largura,
                                            Comprimento = @comprimento,
                                            Espessura = @espessura,
                                            Diametro = @diametro,
                                            Peso = @peso,
                                            UrlImgA = @urlImgA,
                                            UrlImgB = @urlImgB,
                                            UrlImgC = @urlImgC,
                                            UrlImgD = @urlImgD,
                                            UrlImgASmall = @urlImgASmall,
                                            UrlImgBSmall = @urlImgBSmall,
                                            DataAtualizado = @dataAtualizado,
                                            CodTipoEmbalagem = @codTipoEmbalagem,
                                            FreteGratis = @freteGratis,
                                            ProdutoEsgotado = @produtoEsgotado,
                                            QtdDisponiveis = @qtdDisponiveis,
                                            OcultarProduto = @ocultarProduto,
                                            ValorAnterior = @valorAnterior,
                                            ValorAtacado = @valorAtacado,
                                            ObsBackOffice = @obsBackOffice,
                                            Relevancia = @relevancia
                                            WHERE CodProduto = @codProduto",
                                            new[] {
                                                new SqlParameter("@nome", p.Nome ?? string.Empty),
                                                new SqlParameter("@descricao", p.Descricao ?? string.Empty),
                                                new SqlParameter("@valor", p.Valor),
                                                new SqlParameter("@materiaPrima", p.MateriaPrima ?? string.Empty),
                                                new SqlParameter("@altura", p.Altura),
                                                new SqlParameter("@largura", p.Largura),
                                                new SqlParameter("@comprimento", p.Comprimento),
                                                new SqlParameter("@espessura", p.Espessura),
                                                new SqlParameter("@diametro", p.Diametro),
                                                new SqlParameter("@peso", p.Peso),
                                                new SqlParameter("@urlImgA", p.UrlImgA ?? string.Empty),
                                                new SqlParameter("@urlImgB", p.UrlImgB ?? string.Empty),
                                                new SqlParameter("@urlImgC", p.UrlImgC ?? string.Empty),
                                                new SqlParameter("@urlImgD", p.UrlImgD ?? string.Empty),
                                                new SqlParameter("@urlImgASmall", p.UrlImgASmall ?? string.Empty),
                                                new SqlParameter("@urlImgBSmall", p.UrlImgBSmall ?? string.Empty),
                                                new SqlParameter("@dataAtualizado", RepUtil.DateTimeNowBR()),
                                                new SqlParameter("@codProduto", p.CodProduto),
                                                new SqlParameter("@codTipoEmbalagem", p.CodTipoEmbalagem),
                                                new SqlParameter("@freteGratis", p.FreteGratis),
                                                new SqlParameter("@produtoEsgotado", p.ProdutoEsgotado),
                                                new SqlParameter("@qtdDisponiveis", p.QtdDisponiveis ?? (object)DBNull.Value),
                                                new SqlParameter("@ocultarProduto", p.OcultarProduto),
                                                new SqlParameter("@valorAnterior", p.ValorAnterior),
                                                new SqlParameter("@valorAtacado", p.ValorAtacado),
                                                new SqlParameter("@obsBackOffice", p.ObsBackOffice ?? string.Empty),
                                                new SqlParameter("@relevancia", p.Relevancia)
                                            }) > 0 ? Obter(p.CodProduto) : null;                

            }
            catch
            {
                return null;
            }
        }
        public bool Desabilitar(int codProduto)
        {
            return RepUtil.ExecutaSQL($@"UPDATE Produto SET DataDesabilitado = @dataDesabilitado
                                         WHERE CodProduto = @codProduto",
                                         new[] {
                                             new SqlParameter("@codProduto", codProduto),
                                             new SqlParameter("@dataDesabilitado", RepUtil.DateTimeNowBR())
                                         }) > 0;
        }
        public bool Remover(int codProduto)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM Avaliacao  
                                            WHERE CodProduto = @codProduto
                                         DELETE FROM ProdutoObservacoes 
                                            WHERE CodProduto = @codProduto
                                         DELETE FROM ProdutoCategoria 
                                            WHERE CodProduto = @codProduto
                                         DELETE FROM Produto
                                            WHERE CodProduto = @codProduto",
                                            new[] { new SqlParameter("@codProduto", codProduto) }) > 0;
        }
        public bool CadastrarProdutoCategoria(int codProduto, int codCategoria)
        {
            return RepUtil.ExecutaSQL($@"INSERT INTO ProdutoCategoria (CodProduto, CodCategoria) 
                                         VALUES (@codProduto, @codCategoria)",
                                         new[] {
                                             new SqlParameter("@codProduto", codProduto),
                                             new SqlParameter("@codCategoria", codCategoria)
                                         }) > 0;
        }
        public bool RemoverProdutoCategoria(int codProduto, int codCategoria)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM ProdutoCategoria 
                                         WHERE CodProduto = @codProduto AND CodCategoria = @codCategoria",
                                         new[] {
                                             new SqlParameter("@codProduto", codProduto),
                                             new SqlParameter("@codCategoria", codCategoria)
                                         }) > 0;
        }
        private Produto Obter(string command, SqlParameter[] parameters = null)
        {
            var p = new Produto();
            var repCategoria = new RepCategoria();
            var repImagemProduto = new RepImagemProduto();
            var repAvaliacao = new RepAvaliacao();
            var repTipoEmbalagem = new RepTipoEmbalagem();
            var repProdutoObservacoes = new RepProdutoObservacoes();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    p = PopularObjeto(dados);

                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.TipoEmbalagem = repTipoEmbalagem.PopularObjeto(dados);
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.ProdutoObservacoes.Add(repProdutoObservacoes.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.Categorias.Add(repCategoria.PopularObjeto(dados, true));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.Avaliacoes.Add(repAvaliacao.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.ImagensProduto.Add(repImagemProduto.PopularObjeto(dados));
                }               
            }
            return p;
        }
        private List<Produto> Listar(string command, SqlParameter[] parameters = null)
        {
            var list = new List<Produto>();
            var tiposEmbalagem = new List<TipoEmbalagem>();
            var repTipoEmbalagem = new RepTipoEmbalagem();
            var repCategoria = new RepCategoria();
            var categorias = new List<Categoria>();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
                if (dados.NextResult())
                {
                    while (dados.Read())
                        tiposEmbalagem.Add(repTipoEmbalagem.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                    {
                        var cat = repCategoria.PopularObjeto(dados, true);
                        cat.CodProduto = Convert.ToInt32(dados["CodProduto"]);
                        categorias.Add(cat);
                    }
                }
                list.ForEach(x =>
                {
                    x.TipoEmbalagem = tiposEmbalagem.Where(z => z.CodTipoEmbalagem == x.CodTipoEmbalagem).FirstOrDefault();
                    x.Categorias.AddRange(categorias.Where(z => z.CodProduto == x.CodProduto));
                });
            }
            return list;
        }
        public Produto PopularObjeto(SqlDataReader sql)
        {
            return new Produto
            {
                CodProduto = Convert.ToInt32(sql["CodProduto"]),
                Nome = sql["Nome"].ToString(),
                Descricao = sql["Descricao"].ToString(),
                Valor = Convert.ToDecimal(sql["Valor"]),
                MateriaPrima = sql["MateriaPrima"].ToString(),
                Altura = Convert.ToDecimal(sql["Altura"]),
                Largura = Convert.ToDecimal(sql["Largura"]),
                Comprimento = Convert.ToDecimal(sql["Comprimento"]),
                Espessura = Convert.ToDecimal(sql["Espessura"]),
                Diametro = Convert.ToDecimal(sql["Diametro"]),
                Peso = Convert.ToDecimal(sql["Peso"]),
                UrlImgA = sql["UrlImgA"].ToString(),
                UrlImgB = sql["UrlImgB"].ToString(),
                UrlImgC = sql["UrlImgC"].ToString(),
                UrlImgD = sql["UrlImgD"].ToString(),
                UrlImgASmall = sql["UrlImgASmall"].ToString(),
                UrlImgBSmall = sql["UrlImgBSmall"].ToString(),
                DataDesabilitado = string.IsNullOrWhiteSpace(sql["DataDesabilitado"].ToString()) ? (DateTime?)null : Convert.ToDateTime(sql["DataDesabilitado"]),
                DataCadastro = Convert.ToDateTime(sql["DataCadastro"]),
                DataAtualizado = Convert.ToDateTime(sql["DataAtualizado"]),
                CodTipoEmbalagem = Convert.ToChar(sql["CodTipoEmbalagem"]),
                FreteGratis = Convert.ToBoolean(sql["FreteGratis"]),
                ProdutoEsgotado = Convert.ToBoolean(sql["ProdutoEsgotado"]),
                QtdDisponiveis = string.IsNullOrWhiteSpace(sql["QtdDisponiveis"].ToString()) ? (int?)null : Convert.ToInt32(sql["QtdDisponiveis"]),
                OcultarProduto = Convert.ToBoolean(sql["OcultarProduto"]),
                ValorAnterior = Convert.ToDecimal(sql["ValorAnterior"]),
                ValorAtacado = Convert.ToDecimal(sql["ValorAtacado"]),
                ObsBackOffice = sql["ObsBackOffice"].ToString(),
                Relevancia = Convert.ToInt32(sql["Relevancia"]),
                ProdutoObservacoes = new List<ProdutoObservacoes>(),
                Categorias = new List<Categoria>(),
                ImagensProduto = new List<ImagemProduto>(),
                Avaliacoes = new List<Avaliacao>(),
                TipoEmbalagem = new TipoEmbalagem()
            };
        }
    }
}
