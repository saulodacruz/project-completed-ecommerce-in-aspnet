using Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepCategoria
    {
        public List<Categoria> Obter()
        {
            return Listar(@"SELECT * FROM Categoria 
                            WHERE DataDesabilitado IS NULL");
        }
        public List<Categoria> Obter(string texto, string top = "")
        {
            return Listar($@"SELECT {top} * FROM Categoria WHERE 
                          Nome like '%{@texto.Replace(" ", "-")}%' AND DataDesabilitado IS NULL", new[] { new SqlParameter("@texto", texto) });
        }
        public List<Categoria> ObterPorProduto(int codProduto)
        {
            return Listar(@"SELECT * FROM Categoria c
                            JOIN ProdutoCategoria pc ON c.CodCategoria = pc.CodCategoria
                            WHERE pc.CodProduto = @codProduto
                            AND c.DataDesabilitado IS NULL", 
                            new[] { new SqlParameter("@codProduto", codProduto) }, true);
        }
        public Categoria Obter(int codCategoria)
        {
            var c = new Categoria();
            using (var dados = RepUtil.ExecuteReader(@"SELECT * FROM Categoria 
                                                       WHERE CodCategoria = @codCategoria AND DataDesabilitado IS NULL",
                                                       new[] { new SqlParameter("@codCategoria", codCategoria) }))
            {
                while (dados.Read())
                    c = PopularObjeto(dados);
            }
            return c;
        }
        public Categoria Cadastrar(Categoria c)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader(@"INSERT INTO Categoria (Nome, Descricao) 
                                                            VALUES (@nome, @descricao)
                                                            SELECT SCOPE_IDENTITY() CodCategoria;", 
                                                            new[] {
                                                                new SqlParameter("@nome", c.Nome ?? string.Empty),
                                                                new SqlParameter("@descricao", c.Descricao ?? string.Empty),
                                                            }))
                {
                    while (dados.Read())
                        c.CodCategoria = Convert.ToInt32(dados["CodCategoria"]);

                    return c;
                }
            }
            catch
            {
                return null;
            }
        }
        public Categoria Editar(Categoria c)
        {
            try
            {
                return RepUtil.ExecutaSQL(@"UPDATE Categoria 
                                    SET Nome = @nome, 
                                    Descricao = @descricao
                                    WHERE CodCategoria = @codCategoria",
                                    new[]
                                    {
                                        new SqlParameter("@nome", c.Nome ?? string.Empty),
                                        new SqlParameter("@descricao", c.Descricao ?? string.Empty),
                                        new SqlParameter("@codCategoria", c.CodCategoria)
                                    }) > 0 ? c : null;
            }
            catch
            {
                return null;
            }
        }
        public bool Desabilitar(int codCategoria)
        {
            return RepUtil.ExecutaSQL(@"UPDATE Categoria SET DataDesabilitado = @dataDesabilitado WHERE CodCategoria = @codCategoria",
                                        new[] {
                                            new SqlParameter("@codCategoria", codCategoria),
                                            new SqlParameter("@dataDesabilitado", RepUtil.DateTimeNowBR())
                                        }) > 0;
        }
        public bool Remover(int codCategoria)
        {
            return RepUtil.ExecutaSQL(@"DELETE FROM ProdutoCategoria WHERE CodCategoria = @codCategoria
                                      DELETE FROM Categoria WHERE CodCategoria = @codCategoria",
                                      new[] { new SqlParameter("@codCategoria", codCategoria) }) > 0;
        }
        public bool AdicionarProdutoCategoria(int codProduto, int codCategoria, bool categoriaPrincipal)
        {
            return RepUtil.ExecutaSQL(@"DELETE FROM ProdutoCategoria 
                                            WHERE CodProduto = @codProduto AND CodCategoria = @codCategoria
                                         INSERT INTO ProdutoCategoria (CodProduto, CodCategoria, CategoriaPrincipal)
                                            VALUES (@codProduto, @codCategoria, @categoriaPrincipal)",
                                            new[] {
                                                new SqlParameter("@codProduto", codProduto),
                                                new SqlParameter("@codCategoria", codCategoria),
                                                new SqlParameter("@categoriaPrincipal", (categoriaPrincipal ? 1 : 0))
                                            }) > 0;
        }
        public bool RemoverProdutoCategoria(int codProduto, int codCategoria)
        {
            return RepUtil.ExecutaSQL(@"DELETE FROM ProdutoCategoria 
                                         WHERE CodProduto = @codProduto AND CodCategoria = @codCategoria",
                                         new[]{
                                             new SqlParameter("@codProduto", codProduto),
                                             new SqlParameter("@codCategoria", codCategoria)
                                         }) > 0;
        }
        private List<Categoria> Listar(string command, SqlParameter[] parameters = null, bool popularPrincipal = false)
        {
            var list = new List<Categoria>();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados, popularPrincipal));
            }
            return list;
        }
        public Categoria PopularObjeto(SqlDataReader sql, bool popularPrincipal = false)
        {
            return new Categoria
            {
                CodCategoria = Convert.ToInt32(sql["CodCategoria"]),
                Nome = sql["Nome"].ToString(),
                Descricao = sql["Descricao"].ToString(),
                DataDesabilitado = string.IsNullOrWhiteSpace(sql["DataDesabilitado"].ToString()) ? (DateTime?)null : Convert.ToDateTime(sql["DataDesabilitado"]),
                CategoriaPrincipal = popularPrincipal ? Convert.ToBoolean(sql["CategoriaPrincipal"]) : false
            };
        }
    }
}
