using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public static class RepUtil
    {
        public static bool Producao
        {
            get
            {
                return ConfigurationManager.AppSettings["Producao"].ToString() == "1";
            }
        }
        public readonly static string ConnectionStrings = Producao ? ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString : ConfigurationManager.ConnectionStrings["ConnectionStringDev"].ConnectionString;

        private static SqlConnection Connection()
        {
            return new SqlConnection(ConnectionStrings);
        }
        public static int ExecutaSQL(string command, SqlParameter[] parameters = null)
        {
            using (var cnn = Connection())
            using (var cmd = new SqlCommand(command, cnn))
            {
                cnn.Open();
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);
                if (!cmd.CommandText.StartsWith("SET DATEFORMAT dmy"))
                    cmd.CommandText = "SET DATEFORMAT dmy; " + cmd.CommandText;
                try
                {
                    return cmd.ExecuteNonQuery();
                }
                catch (SqlException e)
                {
                    e.Data.Add("Comando", command);
                    throw;
                }
            }
        }
        public static SqlDataReader ExecuteReader(string sql, SqlParameter[] parameters = null, bool procedure = false)
        {
            SqlConnection cnn = Connection();
            cnn.Open();
            SqlCommand cmd = new SqlCommand
            {
                Connection = cnn,
                CommandText = sql
            };
            if (parameters != null)
                cmd.Parameters.AddRange(parameters);
            if (!cmd.CommandText.StartsWith("SET DATEFORMAT dmy") && !procedure)
                cmd.CommandText = "SET DATEFORMAT dmy; " + cmd.CommandText;
            if (procedure)
                cmd.CommandType = CommandType.StoredProcedure;
            else
                cmd.CommandType = CommandType.Text;
            SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            return reader;
        }
        public static DateTime DateTimeNowBR() =>
            TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.FindSystemTimeZoneById("E. South America Standard Time"));
    }
}
