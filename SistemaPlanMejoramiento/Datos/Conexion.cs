using System;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class Conexion
    {
        SqlConnection oConex = new SqlConnection("Data Source=localhost\\SQLEXPRESS;Initial Catalog=DB_PlanMejoramiento;Integrated Security=True;");

        public SqlConnection MtAbrirConexion()
        {
            oConex.Open();
            return oConex;
        }

        public void MtCerrarConexion()
        {
            oConex.Close();
        }
    }
}