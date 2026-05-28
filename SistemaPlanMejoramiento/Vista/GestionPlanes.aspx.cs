using SistemaPlanMejoramiento.Modelo;
using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class GestionPlanes : Page
    {
        ClPlanMejoramientoL oLogica = new ClPlanMejoramientoL();
        ClAprendizL oLogicaAprendiz = new ClAprendizL();
        ClInstructorL oLogicaInstructor = new ClInstructorL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Instructor")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarAprendices();
                CargarInstructores();
                CargarTabla();
            }
        }

        private void CargarAprendices()
        {
            try
            {
                var lista = oLogicaAprendiz.MtConsultar();
                ddlAprendiz.DataSource = lista;
                ddlAprendiz.DataTextField = "NombreCompleto";
                ddlAprendiz.DataValueField = "IdAprendiz";
                ddlAprendiz.DataBind();
                ddlAprendiz.Items.Insert(0, new ListItem("-- Seleccione aprendiz --", "0"));
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "ERROR: " + ex.Message;
                lblMensajeError.Visible = true;
            }
        }

        private void CargarInstructores()
        {
            ddlInstructor.DataSource = oLogicaInstructor.MtConsultar();
            ddlInstructor.DataTextField = "NombreCompleto";
            ddlInstructor.DataValueField = "IdInstructor";
            ddlInstructor.DataBind();
            ddlInstructor.Items.Insert(0, new ListItem("-- Seleccione instructor --", "0"));
        }

        private void CargarTabla()
        {
            gvPlanes.DataSource = oLogica.MtConsultar();
            gvPlanes.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlAprendiz.SelectedValue == "0" || ddlInstructor.SelectedValue == "0"
                || txtActividades.Text.Trim() == "" || txtFechaLimite.Text.Trim() == "")
            {
                MostrarError("Completa todos los campos obligatorios.");
                return;
            }

            string nombreArchivo = null;

            if (fuArchivoPlan.HasFile)
            {
                string ext = Path.GetExtension(fuArchivoPlan.FileName).ToLower();
                if (ext != ".pdf")
                {
                    MostrarError("Solo se permiten archivos PDF para el plan.");
                    return;
                }

                string carpeta = Server.MapPath("~/Planes/");
                if (!Directory.Exists(carpeta))
                    Directory.CreateDirectory(carpeta);

                nombreArchivo = "Plan_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + "_" + Path.GetFileName(fuArchivoPlan.FileName);
                fuArchivoPlan.SaveAs(Path.Combine(carpeta, nombreArchivo));
            }

            Modelo.PlanMejoramiento oPlan = new Modelo.PlanMejoramiento
            {
                IdPlan = int.Parse(hfIdPlan.Value),
                IdAprendiz = int.Parse(ddlAprendiz.SelectedValue),
                IdInstructor = int.Parse(ddlInstructor.SelectedValue),
                TipoPlan = "Interno",
                Actividades = txtActividades.Text.Trim(),
                Observaciones = txtObservaciones.Text.Trim(),
                FechaAsignacion = DateTime.Now,
                FechaLimite = DateTime.Parse(txtFechaLimite.Text),
                Estado = "Pendiente",
                ArchivoPlan = nombreArchivo 
            };

            string resultado;
            if (oPlan.IdPlan == 0)
                resultado = oLogica.MtInsertar(oPlan);
            else
                resultado = oLogica.MtModificar(oPlan);

            if (resultado == "ok")
            {
                MostrarOk(oPlan.IdPlan == 0 ? "Plan registrado correctamente." : "Plan actualizado correctamente.");
                LimpiarFormulario();
                CargarTabla();
            }
            else
            {
                MostrarError(resultado);
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        protected void gvPlanes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Editar")
            {
                var lista = oLogica.MtConsultar();
                Modelo.PlanMejoramiento oPlan = lista.Find(p => p.IdPlan == id);
                if (oPlan != null)
                {
                    hfIdPlan.Value = oPlan.IdPlan.ToString();
                    ddlAprendiz.SelectedValue = oPlan.IdAprendiz.ToString();
                    ddlInstructor.SelectedValue = oPlan.IdInstructor.ToString();
                    txtActividades.Text = oPlan.Actividades;
                    txtObservaciones.Text = oPlan.Observaciones;
                    txtFechaLimite.Text = oPlan.FechaLimite.ToString("yyyy-MM-dd");
                    lblTituloFormulario.Text = "Editar Plan";

                    if (!string.IsNullOrEmpty(oPlan.ArchivoPlan))
                    {
                        lblArchivoActual.Text = "📎 Archivo actual: " + oPlan.ArchivoPlan + " (sube uno nuevo para reemplazarlo)";
                        lblArchivoActual.Visible = true;
                    }
                    else
                    {
                        lblArchivoActual.Visible = false;
                    }
                }
            }
            else if (e.CommandName == "Evaluar")
            {
                Response.Redirect("EvaluarPlan.aspx?id=" + id);
            }
            else if (e.CommandName == "Eliminar")
            {
                string resultado = oLogica.MtEliminar(id);
                if (resultado == "ok")
                    MostrarOk("Plan eliminado correctamente.");
                else
                    MostrarError(resultado);
                CargarTabla();
            }
        }

        protected void gvPlanes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPlanes.PageIndex = e.NewPageIndex;
            CargarTabla();
        }

        private void LimpiarFormulario()
        {
            hfIdPlan.Value = "0";
            ddlAprendiz.SelectedIndex = 0;
            ddlInstructor.SelectedIndex = 0;
            txtActividades.Text = "";
            txtObservaciones.Text = "";
            txtFechaLimite.Text = "";
            lblTituloFormulario.Text = "Nuevo Plan de Mejoramiento";
            lblArchivoActual.Visible = false;
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

        protected string GetBadgeClass(string estado)
        {
            switch (estado)
            {
                case "Pendiente": return "badge-plan badge-pendiente";
                case "Aprobado": return "badge-plan badge-aprobado";
                case "No Aprobado": return "badge-plan badge-noaprobado";
                case "En Proceso": return "badge-plan badge-proceso";
                default: return "badge-plan badge-otro";
            }
        }
    }
}
