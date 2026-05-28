using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MisFichas : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Instructor")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
                CargarFichas();
        }

        private void CargarFichas()
        {
            try
            {
                int idInstructor = Convert.ToInt32(Session["idInstructor"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand(
                    "SELECT f.CodigoFicha, p.NombrePrograma, f.FechaInicio, f.FechaFin, f.Jornada, f.Estado " +
                    "FROM InstructorFicha if_ " +
                    "INNER JOIN Ficha f ON if_.IdFicha = f.IdFicha " +
                    "INNER JOIN Programa p ON f.IdPrograma = p.IdPrograma " +
                    "WHERE if_.IdInstructor = @IdInstructor", cn);
                cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                oConexion.MtCerrarConexion();
                gvFichas.DataSource = dt;
                gvFichas.DataBind();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}