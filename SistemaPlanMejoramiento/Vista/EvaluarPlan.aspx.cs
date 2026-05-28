using SistemaPlanMejoramiento.Modelo;
using System;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class EvaluarPlan : Page
    {
        ClEvaluacionL oLogica = new ClEvaluacionL();
        ClPlanMejoramientoL oLogicaPlan = new ClPlanMejoramientoL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Instructor")
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
                    Response.Redirect("GestionPlanes.aspx");
                    return;
                }

                hfIdPlan.Value = idPlan.ToString();
                CargarDatosPlan(idPlan);
            }
        }

        private void CargarDatosPlan(int idPlan)
        {
            var lista = oLogicaPlan.MtConsultar();
            Modelo.PlanMejoramiento oPlan = lista.Find(p => p.IdPlan == idPlan);
            if (oPlan != null)
            {
                lblAprendiz.Text = oPlan.NombreAprendiz;
                lblInstructor.Text = oPlan.NombreInstructor;
                lblTipoPlan.Text = oPlan.TipoPlan;
                lblFechaLimite.Text = oPlan.FechaLimite.ToString("dd/MM/yyyy");
                lblEstadoPlan.Text = oPlan.Estado;
                lblActividades.Text = oPlan.Actividades;
                hfIdAprendiz.Value = oPlan.IdAprendiz.ToString();
                hfIdInstructor.Value = oPlan.IdInstructor.ToString();
                hfTipoPlan.Value = oPlan.TipoPlan;
            }
        }

        protected void btnEvaluar_Click(object sender, EventArgs e)
        {
            if (ddlProducto.SelectedValue == "" || ddlConocimiento.SelectedValue == ""
                || ddlDesempeno.SelectedValue == "")
            {
                MostrarError("Debes evaluar todos los criterios.");
                return;
            }

            Evaluacion oEvaluacion = new Evaluacion
            {
                IdPlan = int.Parse(hfIdPlan.Value),
                IdInstructor = int.Parse(hfIdInstructor.Value),
                Producto = ddlProducto.SelectedValue,
                Conocimiento = ddlConocimiento.SelectedValue,
                Desempeno = ddlDesempeno.SelectedValue,
                Observaciones = txtObservaciones.Text.Trim(),
                FechaEvaluacion = DateTime.Now
            };

            int idAprendiz = int.Parse(hfIdAprendiz.Value);
            string tipoPlan = hfTipoPlan.Value;

            string resultado = oLogica.MtEvaluar(oEvaluacion, idAprendiz, tipoPlan);

            if (resultado == "ok")
            {
                MostrarOk("Plan evaluado y aprobado correctamente.");
                btnEvaluar.Enabled = false;
            }
            else if (resultado == "ok-comite")
            {
                MostrarOk("El aprendiz no aprobó. Se generó automáticamente un plan por comité.");
                btnEvaluar.Enabled = false;
            }
            else if (resultado == "ok-cancelado")
            {
                MostrarOk("El aprendiz no aprobó el plan por comité. Su estado cambió a Cancelado.");
                btnEvaluar.Enabled = false;
            }
            else
            {
                MostrarError(resultado);
            }
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