using SistemaPlanMejoramiento.Modelo;
using System;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class MiPlan : Page
    {
        ClPlanMejoramientoL oLogicaPlan = new ClPlanMejoramientoL();
        ClEvidenciaL oLogicaEvidencia = new ClEvidenciaL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Aprendiz")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
                CargarPlanes();

            if (hfIdPlanSeleccionado.Value != "0" && hfIdPlanSeleccionado.Value != "")
                pnlEvidencias.Visible = true;
        }

        private void CargarPlanes()
        {
            int idAprendiz = Convert.ToInt32(Session["idAprendiz"]);
            var todos = oLogicaPlan.MtConsultar();
            var misPlanes = todos.FindAll(p => p.IdAprendiz == idAprendiz);
            gvPlanes.DataSource = misPlanes;
            gvPlanes.DataBind();
        }

        protected void gvPlanes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerEvidencias")
            {
                int idPlan = int.Parse(e.CommandArgument.ToString());
                hfIdPlanSeleccionado.Value = idPlan.ToString();
                var evidencias = oLogicaEvidencia.MtConsultar(idPlan);
                gvEvidencias.DataSource = evidencias;
                gvEvidencias.DataBind();
                pnlEvidencias.Visible = true;
            }
            else if (e.CommandName == "SubirEvidencia")
            {
                int idPlan = int.Parse(e.CommandArgument.ToString());
                Response.Redirect("SubirEvidencia.aspx?id=" + idPlan);
            }
        }

        protected void gvEvidencias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Descargar")
            {
                string nombreArchivoBD = e.CommandArgument.ToString();
                string carpetaEvidencias = Server.MapPath("~/Evidencias/");
                string rutaFisica = null;

                string rutaDesdeBD = Server.MapPath(nombreArchivoBD);
                if (File.Exists(rutaDesdeBD))
                {
                    rutaFisica = rutaDesdeBD;
                }
                else if (Directory.Exists(carpetaEvidencias))
                {
                    string rutaExacta = Path.Combine(carpetaEvidencias, Path.GetFileName(nombreArchivoBD));
                    if (File.Exists(rutaExacta))
                    {
                        rutaFisica = rutaExacta;
                    }
                    else
                    {
                        string nombreSinPath = Path.GetFileName(nombreArchivoBD);
                        var archivosCoincidentes = Directory.GetFiles(carpetaEvidencias, "*" + nombreSinPath);

                        if (archivosCoincidentes.Length > 0)
                        {
                            rutaFisica = archivosCoincidentes[0];
                        }
                        else
                        {
                            string nombreBase = Path.GetFileNameWithoutExtension(nombreSinPath);
                            var todosArchivos = Directory.GetFiles(carpetaEvidencias, "*.pdf");
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se encontró el archivo en el servidor.\\nNombre buscado: " + nombreArchivoBD.Replace("'", "\\'") + "');", true);
                }
            }
        }

        protected void gvPlanes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPlanes.PageIndex = e.NewPageIndex;
            CargarPlanes();
        }

        protected void gvEvidencias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvEvidencias.PageIndex = e.NewPageIndex;
            int idPlan = int.Parse(hfIdPlanSeleccionado.Value);
            gvEvidencias.DataSource = oLogicaEvidencia.MtConsultar(idPlan);
            gvEvidencias.DataBind();
        }
    }
}