using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MiFicha : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Aprendiz")
            { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack) CargarFicha();
        }

        private void CargarFicha()
        {
            try
            {
                int idAprendiz = Convert.ToInt32(Session["idAprendiz"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand(
                    "SELECT f.CodigoFicha, p.NombrePrograma, f.FechaInicio, f.FechaFin, f.Jornada, f.Estado " +
                    "FROM Aprendiz a INNER JOIN Ficha f ON a.IdFicha = f.IdFicha " +
                    "INNER JOIN Programa p ON f.IdPrograma = p.IdPrograma " +
                    "WHERE a.IdAprendiz = @Id", cn);
                cmd.Parameters.AddWithValue("@Id", idAprendiz);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblCodigo.Text = dr["CodigoFicha"].ToString();
                    lblPrograma.Text = dr["NombrePrograma"].ToString();
                    lblFechaInicio.Text = Convert.ToDateTime(dr["FechaInicio"]).ToString("dd/MM/yyyy");
                    lblFechaFin.Text = Convert.ToDateTime(dr["FechaFin"]).ToString("dd/MM/yyyy");
                    lblJornada.Text = dr["Jornada"].ToString();
                    lblEstado.Text = dr["Estado"].ToString();
                }
                oConexion.MtCerrarConexion();
            }
            catch (Exception ex) { lblError.Text = "Error: " + ex.Message; lblError.Visible = true; }
        }
    }
}