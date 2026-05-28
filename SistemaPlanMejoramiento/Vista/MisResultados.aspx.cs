using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MisResultados : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Aprendiz")
            { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack) CargarResultados();
        }

        private void CargarResultados()
        {
            try
            {
                int idAprendiz = Convert.ToInt32(Session["idAprendiz"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand(
                    "SELECT ra.CodigoResultado, ra.Descripcion, ra.Estado, " +
                    "c.NombreCompetencia " +
                    "FROM Aprendiz a " +
                    "INNER JOIN Ficha f ON a.IdFicha = f.IdFicha " +
                    "INNER JOIN Programa p ON f.IdPrograma = p.IdPrograma " +
                    "INNER JOIN Competencia c ON c.IdPrograma = p.IdPrograma " +
                    "INNER JOIN ResultadoAprendizaje ra ON ra.IdCompetencia = c.IdCompetencia " +
                    "WHERE a.IdAprendiz = @Id", cn);
                cmd.Parameters.AddWithValue("@Id", idAprendiz);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                oConexion.MtCerrarConexion();
                gvResultados.DataSource = dt;
                gvResultados.DataBind();
            }
            catch (Exception ex) { lblError.Text = "Error: " + ex.Message; lblError.Visible = true; }
        }
    }
}