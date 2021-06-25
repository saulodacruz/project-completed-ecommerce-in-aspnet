using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;

namespace Repositorios
{
    public class RepTipoEmbalagem
    {
        public List<TipoEmbalagem> Obter()
        {
            var list = new List<TipoEmbalagem>();
            using (var dados = RepUtil.ExecuteReader("SELECT * FROM TipoEmbalagem"))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        public TipoEmbalagem Obter(char codTipoEmbalagem)
        {
            var c = new TipoEmbalagem();
            using (var dados = RepUtil.ExecuteReader($@"SELECT * FROM TipoEmbalagem 
                                                        WHERE CodTipoEmbalagem = @codTipoEmbalagem",
                                                        new[] { new SqlParameter("@codTipoEmbalagem", codTipoEmbalagem) }))
            {
                while (dados.Read())
                    c = PopularObjeto(dados);
            }
            return c;
        }
        public TipoEmbalagem Cadastrar(TipoEmbalagem c)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"INSERT INTO TipoEmbalagem (CodTipoEmbalagem, Altura, Largura, Comprimento, Diametro, Peso) 
                                                            VALUES (@codTipoEmbalagem, @altura, @largura, @comprimento, @diametro, @peso)
                                                            SELECT SCOPE_IDENTITY() CodTipoEmbalagem;",
                                                            new[] {
                                                                new SqlParameter("@codTipoEmbalagem", c.CodTipoEmbalagem),
                                                                new SqlParameter("@altura", c.Altura),
                                                                new SqlParameter("@largura", c.Largura),
                                                                new SqlParameter("@comprimento", c.Comprimento),
                                                                new SqlParameter("@diametro", c.Diametro),
                                                                new SqlParameter("@peso", c.Peso)
                                                            }))
                {
                    while (dados.Read())
                        c.CodTipoEmbalagem = Convert.ToChar(dados["CodTipoEmbalagem"]);

                    return c;
                }
            }
            catch
            {
                return null;
            }
        }
        public TipoEmbalagem Editar(TipoEmbalagem t)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"UPDATE TipoEmbalagem 
                                        SET Altura = @altura, 
                                        Largura = @largura,
                                        Comprimento = @comprimento
                                        Diametro = @diametro
                                        Peso = @peso
                                        WHERE CodTipoEmbalagem = @codTipoEmbalagem",
                                        new[] {
                                            new SqlParameter("@codTipoEmbalagem", t.CodTipoEmbalagem),
                                            new SqlParameter("@altura", t.Altura),
                                            new SqlParameter("@largura", t.Largura),
                                            new SqlParameter("@comprimento", t.Comprimento),
                                            new SqlParameter("@diametro", t.Diametro),
                                            new SqlParameter("@peso", t.Peso)                                            
                                        }) > 0 ? t : null;
            }
            catch
            {
                return null;
            }
        }
        public bool Remover(char codTipoEmbalagem)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM TipoEmbalagem WHERE CodTipoEmbalagem = @codTipoEmbalagem",
                                        new[] { new SqlParameter("@codTipoEmbalagem", codTipoEmbalagem) }) > 0;
        }
        public TipoEmbalagem PopularObjeto(SqlDataReader sql)
        {
            return new TipoEmbalagem
            {
                CodTipoEmbalagem = Convert.ToChar(sql["CodTipoEmbalagem"]),
                Altura = Convert.ToDecimal(sql["Altura"]),
                Largura = Convert.ToDecimal(sql["Largura"]),
                Comprimento = Convert.ToDecimal(sql["Comprimento"]),
                Diametro = Convert.ToDecimal(sql["Diametro"]),
                Peso = Convert.ToDecimal(sql["Peso"]),
            };
        }
        public TipoEmbalagem PopularObjetoAlias(SqlDataReader sql)
        {
            return new TipoEmbalagem
            {
                CodTipoEmbalagem = Convert.ToChar(sql["TipCodTipoEmbalagem"]),
                Altura = Convert.ToDecimal(sql["TipAltura"]),
                Largura = Convert.ToDecimal(sql["TipLargura"]),
                Comprimento = Convert.ToDecimal(sql["TipComprimento"]),
                Diametro = Convert.ToDecimal(sql["TipDiametro"]),
                Peso = Convert.ToDecimal(sql["TipPeso"]),
            };
        }
    }
}
