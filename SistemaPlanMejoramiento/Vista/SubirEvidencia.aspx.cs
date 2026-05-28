using SistemaPlanMejoramiento.Modelo;
using System;
using System.IO;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class SubirEvidencia : Page
    {
        ClEvidenciaL oLogica = new ClEvidenciaL();
        ClPlanMejoramientoL oLogicaPlan = new ClPlanMejoramientoL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Aprendiz")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int idPlan = 0;
                if (Request.QueryString["id"] != null)
                    idPlan = int.Parse(Request.QueryString["id"]);

                if (idPlan == 0)
                {
                    Response.Redirect("MiPlan.aspx");
                    return;
                }

                hfIdPlan.Value = idPlan.ToString();
                CargarDatosPlan(idPlan);
                CargarEvidencias(idPlan);
            }
        }

        private void CargarDatosPlan(int idPlan)
        {
            var lista = oLogicaPlan.MtConsultar();
            Modelo.PlanMejoramiento oPlan = lista.Find(p => p.IdPlan == idPlan);
            if (oPlan != null)
            {
                lblTipoPlan.Text = oPlan.TipoPlan;
                lblFechaLimite.Text = oPlan.FechaLimite.ToString("dd/MM/yyyy");
                lblActividades.Text = oPlan.Actividades;
                lblEstado.Text = oPlan.Estado;
            }
        }

        private void CargarEvidencias(int idPlan)
        {
            gvEvidencias.DataSource = oLogica.MtConsultar(idPlan);
            gvEvidencias.DataBind();
        }

        protected void btnSubir_Click(object sender, EventArgs e)
        {
            if (!fuArchivo.HasFile)
            {
                MostrarError("Debes seleccionar un archivo.");
                return;
            }

            string extension = Path.GetExtension(fuArchivo.FileName).ToLower();
            string[] permitidos = { ".pdf", ".docx", ".jpg", ".jpeg", ".png", ".zip" };
            bool extensionValida = false;
            foreach (string ext in permitidos)
                if (extension == ext) { extensionValida = true; break; }

            if (!extensionValida)
            {
                MostrarError("Formato no permitido. Solo se aceptan PDF, DOCX, JPG, PNG, ZIP.");
                return;
            }

            if (fuArchivo.PostedFile.ContentLength > 10 * 1024 * 1024)
            {
                MostrarError("El archivo no puede superar los 10 MB.");
                return;
            }

            string carpeta = Server.MapPath("~/Evidencias/");
            if (!Directory.Exists(carpeta))
                Directory.CreateDirectory(carpeta);

            string nombreUnico = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Path.GetFileName(fuArchivo.FileName);
            string rutaFisica = Path.Combine(carpeta, nombreUnico);
            fuArchivo.SaveAs(rutaFisica);

            Evidencia oEvidencia = new Evidencia
            {
                IdPlan = int.Parse(hfIdPlan.Value),
                NombreArchivo = fuArchivo.FileName,
                RutaArchivo = "~/Evidencias/" + nombreUnico,
                TipoArchivo = extension.Replace(".", "").ToUpper(),
                FechaSubida = DateTime.Now,
                Observaciones = txtObservaciones.Text.Trim()
            };

            string resultado = oLogica.MtInsertar(oEvidencia);

            if (resultado == "ok")
            {
                MostrarOk("Evidencia subida correctamente.");
                txtObservaciones.Text = "";
                CargarEvidencias(int.Parse(hfIdPlan.Value));
            }
            else
            {
                MostrarError(resultado);
            }
        }

        protected void gvEvidencias_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvEvidencias.PageIndex = e.NewPageIndex;
            CargarEvidencias(int.Parse(hfIdPlan.Value));
        }

        private void MostrarOk(string mensaje)
        {
            lblMensajeOk.Text = "✔ " + mensaje;
            lblMensajeOk.Visible = true;
            lblMensajeError.Visible = false;
        }

        private void MostrarError(string mensaje)
        {
            lblMensajeError.Text = "✖ " + mensaje;
            lblMensajeError.Visible = true;
            lblMensajeOk.Visible = false;
        }
    }
}