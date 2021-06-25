using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepCupom
    {
        public List<Cupom> Obter()
        {
            var list = new List<Cupom>();
            using (var dados = RepUtil.ExecuteReader("SELECT * FROM Cupom WHERE DataDesabilitado IS NULL"))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        public Cupom Obter(int codCupom)
        {
            var c = new Cupom();
            using (var dados = RepUtil.ExecuteReader($@"SELECT * FROM Cupom 
                                                        WHERE CodCupom = @codCupom AND DataDesabilitado IS NULL",
                                                        new[] { new SqlParameter("@codCupom", codCupom) }))
            {
                while (dados.Read())
                    c = PopularObjeto(dados);
            }
            return c;
        }
        public Cupom Obter(string codigo)
        {
            var c = new Cupom();
            using (var dados = RepUtil.ExecuteReader($@"SELECT * FROM Cupom 
                                                        WHERE Codigo = @codigo AND DataDesabilitado IS NULL",
                                                        new[] { new SqlParameter("@codigo", codigo ?? string.Empty) }))
            {
                while (dados.Read())
                    c = PopularObjeto(dados);
            }
            return c;
        }
        public Cupom Cadastrar(Cupom c)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"INSERT INTO Cupom (Valor, Data, Codigo) 
                                                            VALUES (@valor, @data, @codigo)
                                                            SELECT SCOPE_IDENTITY() CodCupom;",
                                                            new[] {
                                                                new SqlParameter("@valor", c.Valor),
                                                                new SqlParameter("@data", c.Data),
                                                                new SqlParameter("@codigo", c.Codigo ?? string.Empty)
                                                            }))
                {
                    while (dados.Read())
                        c.CodCupom = Convert.ToInt32(dados["CodCupom"]);

                    return c;
                }
            }
            catch
            {
                return null;
            }
        }
        public Cupom Editar(Cupom c)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"UPDATE Cupom 
                                        SET Codigo = @codigo, 
                                        Valor = @valor,
                                        Data = @data
                                        WHERE CodCupom = @codCupom",
                                        new[] {
                                            new SqlParameter("@codigo", c.Codigo ?? string.Empty),
                                            new SqlParameter("@valor", c.Valor),
                                            new SqlParameter("@data", c.Data),
                                            new SqlParameter("@codCupom", c.CodCupom),
                                        }) > 0 ? c : null;
            }
            catch
            {
                return null;
            }
        }
        public bool Desabilitar(int codCupom)
        {
            return RepUtil.ExecutaSQL(@"UPDATE Cupom SET DataDesabilitado = @dataDesabilitado WHERE CodCupom = @codCupom",
                                        new[] {
                                            new SqlParameter("@codCupom", codCupom),
                                            new SqlParameter("@dataDesabilitado", RepUtil.DateTimeNowBR())
                                        }) > 0;
        }
        public bool Remover(int codCupom)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM Cupom WHERE CodCupom = @codCupom",
                                        new[] { new SqlParameter("@codCupom", codCupom) }) > 0;
        }
        public Cupom PopularObjeto(SqlDataReader sql)
        {
            return new Cupom
            {
                CodCupom = Convert.ToInt32(sql["CodCupom"]),
                Valor = Convert.ToDecimal(sql["Valor"]),
                Data = Convert.ToDateTime(sql["Data"]),
                DataDesabilitado = string.IsNullOrWhiteSpace(sql["DataDesabilitado"].ToString()) ? (DateTime?)null : Convert.ToDateTime(sql["DataDesabilitado"]),
                Codigo = sql["Codigo"].ToString()
            };
        }
    }
}
