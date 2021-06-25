using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepLogStatusPedido
    {
        public List<LogStatusPedido> Obter(long codPedido)
        {
            var l = new List<LogStatusPedido>();
            using (var dados = RepUtil.ExecuteReader($@"SELECT * FROM LogStatusPedido lsp
                                JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                WHERE CodPedido = @codPedido", 
                                new[] { new SqlParameter("@codPedido", codPedido) }))
            {
                while (dados.Read())
                    l.Add(PopularObjeto(dados));
            }
            return l;
        }
        public List<StatusPedido> ObterListaStatus()
        {
            var l = new List<StatusPedido>();
            using (var dados = RepUtil.ExecuteReader($@"SELECT * FROM StatusPedido"))
            {
                while (dados.Read())
                    l.Add(PopularObjetoStatusPedido(dados));
            }
            return l;
        }
        public LogStatusPedido Cadastrar(LogStatusPedido l)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"IF (EXISTS (SELECT 1 FROM LogStatusPedido WHERE CodPedido = @codPedido AND CodStatusPedido = @codStatusPedido))
                                                            BEGIN
	                                                            SELECT TOP 1 CodLogStatusPedido FROM LogStatusPedido WHERE CodPedido = @codPedido AND CodStatusPedido = @codStatusPedido
                                                            END
                                                            ELSE
                                                            BEGIN
	                                                            INSERT INTO LogStatusPedido (CodPedido, CodStatusPedido, Data, Observacao) 
	                                                            VALUES (@codPedido, @codStatusPedido, @data, @observacao)
	                                                            SELECT SCOPE_IDENTITY() CodLogStatusPedido;
                                                            END",
                                                            new[] {
                                                                new SqlParameter("@codPedido", l.CodPedido),
                                                                new SqlParameter("@codStatusPedido", l.CodStatusPedido),
                                                                new SqlParameter("@data", l.Data),
                                                                new SqlParameter("@observacao", l.Observacao ?? string.Empty)
                                                            }))
                {
                    while (dados.Read())
                        l.CodLogStatusPedido = Convert.ToInt32(dados["CodLogStatusPedido"]);

                    return l;
                }
            }
            catch(Exception ex)
            {
                return null;
            }
        }
        public bool Remover(long codLogStatusPedido)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM LogStatusPedido WHERE CodLogStatusPedido = @codLogStatusPedido", 
                                        new[] { new SqlParameter("@codLogStatusPedido", codLogStatusPedido) }) > 0;
        }
        public bool Limpar(long codPedido)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM LogStatusPedido WHERE CodPedido = @codPedido",
                                        new[] { new SqlParameter("@codPedido", codPedido) }) > 0;
        }
        public LogStatusPedido PopularObjeto(SqlDataReader sql)
        {
            return new LogStatusPedido
            {
                CodLogStatusPedido = Convert.ToInt32(sql["CodLogStatusPedido"]),
                CodPedido = Convert.ToInt32(sql["CodPedido"]),
                CodStatusPedido = Convert.ToInt32(sql["CodStatusPedido"]),
                Data = Convert.ToDateTime(sql["Data"]),
                Observacao = sql["Observacao"].ToString(),
                StatusPedido = new StatusPedido
                {
                    CodStatusPedido = Convert.ToInt32(sql["CodStatusPedido"]),
                    Nome = sql["Nome"].ToString()
                }
            };
        }
        public StatusPedido PopularObjetoStatusPedido(SqlDataReader sql)
        {
            return new StatusPedido
            {
                CodStatusPedido = Convert.ToInt32(sql["CodStatusPedido"]),
                Nome = sql["Nome"].ToString()
            };
        }
    }
}
