using SistemaPlanMejoramiento.Modelo;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class AsignarInstructor : Page
    {
        ClInstructorFichaL oLogica = new ClInstructorFichaL();
        ClInstructorL oLogicaInstructor = new ClInstructorL();
        ClFichaL oLogicaFicha = new ClFichaL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Administrador")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarInstructores();
                CargarFichas();
                CargarTabla();
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

        private void CargarFichas()
        {
            ddlFicha.DataSource = oLogicaFicha.MtConsultar();
            ddlFicha.DataTextField = "CodigoFicha";
            ddlFicha.DataValueField = "IdFicha";
            ddlFicha.DataBind();
            ddlFicha.Items.Insert(0, new ListItem("-- Seleccione ficha --", "0"));
        }

        private void CargarTabla()
        {
            gvAsignaciones.DataSource = oLogica.MtConsultar();
            gvAsignaciones.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlInstructor.SelectedValue == "0" || ddlFicha.SelectedValue == "0")
            {
                MostrarError("Debes seleccionar un instructor y una ficha.");
                return;
            }

            InstructorFicha oIF = new InstructorFicha
            {
                IdInstructor = int.Parse(ddlInstructor.SelectedValue),
                IdFicha = int.Parse(ddlFicha.SelectedValue),
                FechaAsignacion = DateTime.Now
            };

            string resultado = oLogica.MtInsertar(oIF);

            if (resultado == "ok")
            {
                MostrarOk("Instructor asignado correctamente.");
                ddlInstructor.SelectedIndex = 0;
                ddlFicha.SelectedIndex = 0;
                CargarTabla();
            }
            else
            {
                MostrarError(resultado);
            }
        }

        protected void gvAsignaciones_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                string[] ids = e.CommandArgument.ToString().Split('-');
                int idInstructor = int.Parse(ids[0]);
                int idFicha = int.Parse(ids[1]);

                string resultado = oLogica.MtEliminar(idInstructor, idFicha);
                if (resultado == "ok")
                    MostrarOk("Asignación eliminada correctamente.");
                else
                    MostrarError(resultado);

                CargarTabla();
            }
        }

        protected void gvAsignaciones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAsignaciones.PageIndex = e.NewPageIndex;
            CargarTabla();
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