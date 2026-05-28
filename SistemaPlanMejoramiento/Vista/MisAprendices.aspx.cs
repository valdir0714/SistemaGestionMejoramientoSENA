using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MisAprendices : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Instructor")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
                CargarAprendices();
        }

        private void CargarAprendices()
        {
            try
            {
                int idInstructor = Convert.ToInt32(Session["idInstructor"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand(
                    "SELECT f.CodigoFicha, a.Nombres + ' ' + a.Apellidos AS NombreCompleto, " +
                    "a.TipoDocumento, a.NumeroDocumento, a.Correo, a.Estado " +
                    "FROM InstructorFicha if_ " +
                    "INNER JOIN Ficha f ON if_.IdFicha = f.IdFicha " +
                    "INNER JOIN Aprendiz a ON a.IdFicha = f.IdFicha " +
                    "WHERE if_.IdInstructor = @IdInstructor", cn);
                cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                oConexion.MtCerrarConexion();
                gvAprendices.DataSource = dt;
                gvAprendices.DataBind();
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}