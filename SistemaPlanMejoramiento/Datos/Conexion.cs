using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class Conexion
    {
        SqlConnection oConex = new SqlConnection("workstation id=DB_PlanMejoramiento.mssql.somee.com;packet size=4096;user id=Valdir0714_SQLLogin_1;pwd=doan5itouq;data source=DB_PlanMejoramiento.mssql.somee.com;persist security info=False;initial catalog=DB_PlanMejoramiento;TrustServerCertificate=True");
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