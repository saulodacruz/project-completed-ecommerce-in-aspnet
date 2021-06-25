using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepAvaliacao
    {
        public Avaliacao Obter(int codAvaliacao)
        {
            return Obter($@"SELECT a.*, p.* FROM Avaliacao a
                            JOIN Usuario u ON a.CodUsuario = u.CodUsuario
                            JOIN Pessoa p ON u.CodPessoa = p.CodPessoa WHERE a.CodAvaliacao = @codAvaliacao", 
                            new[] { new SqlParameter("@codAvaliacao", codAvaliacao) });
        }
        public List<Avaliacao> ObterPorProduto(int codProduto)
        {
            return Listar($@"SELECT a.*, p.* FROM Avaliacao a
                            JOIN Usuario u ON a.CodUsuario = u.CodUsuario
                            JOIN Pessoa p ON u.CodPessoa = p.CodPessoa WHERE CodProduto = @codProduto", 
                            new [] { new SqlParameter("@codProduto", codProduto) });
        }
        public Avaliacao Cadastrar(Avaliacao a)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"INSERT INTO Avaliacao (CodUsuario, CodProduto, Estrelas, Comentario, Data) 
                                                            VALUES (@codUsuario, @codProduto, @estrelas, @comentario, @data)
                                                            SELECT SCOPE_IDENTITY() CodAvaliacao;", 
                                                            new[] {
                                                                new SqlParameter("@codUsuario", a.CodUsuario),
                                                                new SqlParameter("@codProduto", a.CodProduto),
                                                                new SqlParameter("@estrelas", a.Estrelas),
                                                                new SqlParameter("@comentario", a.Comentario ?? string.Empty),
                                                                new SqlParameter("@data", RepUtil.DateTimeNowBR())
                                                            }))
                {
                    while (dados.Read())
                        a = Obter(Convert.ToInt32(dados["CodAvaliacao"]));

                    return a;
                }
            }
            catch
            {
                return null;
            }
        }
        public Avaliacao Editar(Avaliacao a)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"UPDATE Avaliacao 
                                        SET Estrelas = @estrelas, 
                                        Comentario = @comentario,
                                        Data = @data
                                        WHERE CodAvaliacao = @codAvaliacao", 
                                        new[] {
                                            new SqlParameter("@estrelas", a.Estrelas),
                                            new SqlParameter("@comentario", a.Comentario ?? string.Empty),
                                            new SqlParameter("@codAvaliacao", a.CodAvaliacao),
                                            new SqlParameter("@data", RepUtil.DateTimeNowBR())
                                        }) > 0 ? a : null;
            }
            catch 
            {
                return null;
            }
        }
        public bool Remover(int codAvaliacao)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM Avaliacao WHERE CodAvaliacao = @codAvaliacao", 
                                        new[] { new SqlParameter("@codAvaliacao", codAvaliacao) }) > 0;
        }
        private Avaliacao Obter(string command, SqlParameter[] parameters = null)
        {
            var item = new Avaliacao();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    item = PopularObjeto(dados);
            }
            return item;
        }
        private List<Avaliacao> Listar(string command, SqlParameter[] parameters = null)
        {
            var list = new List<Avaliacao>();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        public Avaliacao PopularObjeto(SqlDataReader sql)
        {
            return new Avaliacao
            {
                CodAvaliacao = Convert.ToInt32(sql["CodAvaliacao"]),
                CodUsuario = Convert.ToInt32(sql["CodUsuario"]),
                CodProduto = Convert.ToInt32(sql["CodProduto"]),
                Estrelas = Convert.ToInt32(sql["Estrelas"]),
                Comentario = sql["Comentario"].ToString(),
                Data = Convert.ToDateTime(sql["Data"]),
                Usuario = new Usuario {
                    Nome = sql["Nome"].ToString()
                }
            };
        }
    }
}
