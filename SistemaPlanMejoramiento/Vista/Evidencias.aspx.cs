using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class Evidencias : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Aprendiz")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                CargarPlanes();
                CargarEvidencias();
            }
        }

        private void CargarPlanes()
        {
            try
            {
                int idAprendiz = Convert.ToInt32(Session["idAprendiz"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand(
                    "SELECT p.IdPlan, i.Nombres + ' ' + i.Apellidos + ' - ' + p.TipoPlan AS Descripcion " +
                    "FROM PlanMejoramiento p " +
                    "INNER JOIN Instructor i ON p.IdInstructor = i.IdInstructor " +
                    "WHERE p.IdAprendiz = @IdAprendiz", cn);
                cmd.Parameters.AddWithValue("@IdAprendiz", idAprendiz);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                oConexion.MtCerrarConexion();
                ddlPlan.DataSource = dt;
                ddlPlan.DataTextField = "Descripcion";
                ddlPlan.DataValueField = "IdPlan";
                ddlPlan.DataBind();
                ddlPlan.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione plan --", "0"));
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "Error cargando planes: " + ex.Message;
                lblMensajeError.Visible = true;
            }
        }

        private void CargarEvidencias()
        {
            try
            {
                int idAprendiz = Convert.ToInt32(Session["idAprendiz"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand(
                    "SELECT a.Nombres + ' ' + a.Apellidos AS NombreAprendiz, p.TipoPlan, " +
                    "e.NombreArchivo, e.TipoArchivo, e.FechaSubida, e.Observaciones " +
                    "FROM Evidencia e " +
                    "INNER JOIN PlanMejoramiento p ON e.IdPlan = p.IdPlan " +
                    "INNER JOIN Aprendiz a ON p.IdAprendiz = a.IdAprendiz " +
                    "WHERE p.IdAprendiz = @IdAprendiz " +
                    "ORDER BY e.FechaSubida DESC", cn);
                cmd.Parameters.AddWithValue("@IdAprendiz", idAprendiz);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                oConexion.MtCerrarConexion();
                gvEvidencias.DataSource = dt;
                gvEvidencias.DataBind();
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "Error cargando evidencias: " + ex.Message;
                lblMensajeError.Visible = true;
            }
        }

        protected void btnSubir_Click(object sender, EventArgs e)
        {
            if (ddlPlan.SelectedValue == "0")
            {
                lblMensajeError.Text = "✖ Selecciona un plan.";
                lblMensajeError.Visible = true;
                return;
            }
            if (!fuEvidencia.HasFile)
            {
                lblMensajeError.Text = "✖ Selecciona un archivo.";
                lblMensajeError.Visible = true;
                return;
            }

            try
            {
                string carpeta = Server.MapPath("~/Evidencias/");
                if (!Directory.Exists(carpeta))
                    Directory.CreateDirectory(carpeta);

                string nombreArchivo = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Path.GetFileName(fuEvidencia.FileName);
                string rutaFisica = Path.Combine(carpeta, nombreArchivo);
                fuEvidencia.SaveAs(rutaFisica);

                string rutaWeb = "~/Evidencias/" + nombreArchivo;

                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Evidencia (IdPlan, NombreArchivo, RutaArchivo, TipoArchivo, FechaSubida, Observaciones) " +
                    "VALUES (@IdPlan, @NombreArchivo, @RutaArchivo, @TipoArchivo, @FechaSubida, @Observaciones)", cn);
                cmd.Parameters.AddWithValue("@IdPlan", int.Parse(ddlPlan.SelectedValue));
                cmd.Parameters.AddWithValue("@NombreArchivo", nombreArchivo);
                cmd.Parameters.AddWithValue("@RutaArchivo", rutaWeb);
                cmd.Parameters.AddWithValue("@TipoArchivo", Path.GetExtension(fuEvidencia.FileName).Replace(".", "").ToUpper());
                cmd.Parameters.AddWithValue("@FechaSubida", DateTime.Now);
                string obs = txtObservaciones.Text.Trim();
                cmd.Parameters.AddWithValue("@Observaciones", obs == "" ? (object)DBNull.Value : obs);
                cmd.ExecuteNonQuery();
                oConexion.MtCerrarConexion();

                lblMensajeOk.Text = "✔ Evidencia subida correctamente.";
                lblMensajeOk.Visible = true;
                lblMensajeError.Visible = false;
                txtObservaciones.Text = "";
                CargarEvidencias();
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "✖ Error: " + ex.Message;
                lblMensajeError.Visible = true;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            ddlPlan.SelectedIndex = 0;
            txtObservaciones.Text = "";
        }

        protected string GetBadgeTipo(string tipo)
        {
            string t = tipo.ToLower();
            if (t.Contains("pdf")) return "badge-tipo badge-pdf";
            if (t.Contains("png") || t.Contains("jpg") || t.Contains("jpeg") || t.Contains("gif"))
                return "badge-tipo badge-img";
            if (t.Contains("doc") || t.Contains("xls") || t.Contains("ppt"))
                return "badge-tipo badge-doc";
            return "badge-tipo badge-otro";
        }

        protected void gvEvidencias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Descargar")
            {
                string nombreArchivoBD = e.CommandArgument.ToString();
                string carpetaEvidencias = Server.MapPath("~/Evidencias/");
                string rutaFisica = null;

                if (Directory.Exists(carpetaEvidencias))
                {
                    string rutaExacta = Path.Combine(carpetaEvidencias, nombreArchivoBD);
                    if (File.Exists(rutaExacta))
                    {
                        rutaFisica = rutaExacta;
                    }
                    else
                    {
                        var archivosCoincidentes = Directory.GetFiles(carpetaEvidencias, "*" + nombreArchivoBD);
                        if (archivosCoincidentes.Length > 0)
                        {
                            rutaFisica = archivosCoincidentes[0];
                        }
                        else
                        {
                            string nombreBase = Path.GetFileNameWithoutExtension(nombreArchivoBD);
                            var todosArchivos = Directory.GetFiles(carpetaEvidencias);
                            var archivoParcial = todosArchivos.FirstOrDefault(f =>
                                Path.GetFileNameWithoutExtension(f).Contains(nombreBase) ||
                                nombreBase.Contains(Path.GetFileNameWithoutExtension(f)));

                            if (archivoParcial != null)
                                rutaFisica = archivoParcial;
                        }
                    }
                }

                if (rutaFisica != null && File.Exists(rutaFisica))
                {
                    string nombreFinal = Path.GetFileName(rutaFisica);
                    string extension = Path.GetExtension(nombreFinal).ToLower();
                    string contentType = "application/octet-stream";

                    switch (extension)
                    {
                        case ".pdf": contentType = "application/pdf"; break;
                        case ".jpg": case ".jpeg": contentType = "image/jpeg"; break;
                        case ".png": contentType = "image/png"; break;
                        case ".doc": contentType = "application/msword"; break;
                        case ".docx": contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"; break;
                        case ".xls": contentType = "application/vnd.ms-excel"; break;
                        case ".xlsx": contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"; break;
                        case ".zip": contentType = "application/zip"; break;
                    }

                    Response.Clear();
                    Response.ContentType = contentType;
                    Response.AddHeader("Content-Disposition", "attachment; filename=\"" + nombreFinal + "\"");
                    Response.TransmitFile(rutaFisica);
                    Response.End();
                }
                else
                {
                    lblMensajeError.Text = "✖ No se encontró el archivo: " + nombreArchivoBD;
                    lblMensajeError.Visible = true;
                }
            }
        }
    }
}