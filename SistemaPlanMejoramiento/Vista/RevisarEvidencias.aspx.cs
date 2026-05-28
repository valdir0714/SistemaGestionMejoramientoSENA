using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.IO;
namespace SistemaPlanMejoramiento
{
    public partial class RevisarEvidencias : System.Web.UI.Page
    {
        Conexion oConexion = new Conexion();

        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (Session["rol"] == null || Session["rol"].ToString() != "Instructor")
            {
                Response.Redirect("~/Vista/Login.aspx");
                return;
            }

            lblUsuario.Text = Session["usuario"]?.ToString() ?? "Instructor";

            if (!IsPostBack)
            {
                CargarAprendices();
                CargarEvidencias(0); 
            }
        }

        private void CargarAprendices()
        {
            int idInstructor = Convert.ToInt32(Session["idInstructor"]);

            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand(
                "SELECT DISTINCT a.IdAprendiz, a.Nombres + ' ' + a.Apellidos AS NombreCompleto " +
                "FROM Aprendiz a " +
                "INNER JOIN PlanMejoramiento pm ON pm.IdAprendiz = a.IdAprendiz " +
                "WHERE pm.IdInstructor = @IdInstructor " +
                "ORDER BY NombreCompleto", cn);
            cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);

            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            oConexion.MtCerrarConexion();

            ddlAprendiz.DataSource = dt;
            ddlAprendiz.DataTextField = "NombreCompleto";
            ddlAprendiz.DataValueField = "IdAprendiz";
            ddlAprendiz.DataBind();
            ddlAprendiz.Items.Insert(0, new ListItem("— Todos los aprendices —", "0"));
        }

        private void CargarEvidencias(int idAprendiz)
        {
            int idInstructor = Convert.ToInt32(Session["idInstructor"]);

            string sql =
                "SELECT a.Nombres + ' ' + a.Apellidos AS NombreAprendiz, " +
                "pm.TipoPlan, " +
                "e.NombreArchivo, " +
                "e.TipoArchivo, " +
                "e.FechaSubida, " +
                "ISNULL(e.Observaciones, '') AS Observaciones " +
                "FROM Evidencia e " +
                "INNER JOIN PlanMejoramiento pm ON pm.IdPlan = e.IdPlan " +
                "INNER JOIN Aprendiz a ON a.IdAprendiz = pm.IdAprendiz " +
                "WHERE pm.IdInstructor = @IdInstructor " +
                (idAprendiz > 0 ? "AND pm.IdAprendiz = @IdAprendiz " : "") +
                "ORDER BY e.FechaSubida DESC";

            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand(sql, cn);
            cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
            if (idAprendiz > 0)
                cmd.Parameters.AddWithValue("@IdAprendiz", idAprendiz);

            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            oConexion.MtCerrarConexion();

            gvEvidencias.DataSource = dt;
            gvEvidencias.DataBind();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            int idAprendiz = 0;
            int.TryParse(ddlAprendiz.SelectedValue, out idAprendiz);
            CargarEvidencias(idAprendiz);
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Vista/Login.aspx");
        }

        public string GetBadgeTipo(string tipo)
        {
            if (string.IsNullOrEmpty(tipo)) return "badge-tipo badge-otro";
            switch (tipo.ToLower())
            {
                case "pdf": return "badge-tipo badge-pdf";
                case "jpg":
                case "jpeg":
                case "png": return "badge-tipo badge-img";
                case "doc":
                case "docx": return "badge-tipo badge-doc";
                default: return "badge-tipo badge-otro";
            }
        }
        protected void btnDescargar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string nombreArchivo = btn.CommandArgument;
            string rutaArchivo = Server.MapPath("~/Evidencias/" + nombreArchivo);

            if (File.Exists(rutaArchivo))
            {
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition",
                    "attachment; filename=\"" + nombreArchivo + "\"");
                Response.TransmitFile(rutaArchivo);
                Response.End();
            }
            else
            {
                Response.Write("<script>alert('Archivo no encontrado.');</script>");
            }
        }
    }
}
