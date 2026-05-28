using SistemaPlanMejoramiento.Modelo;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class Instructores : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Administrador")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
                CargarInstructores();
        }

        private void CargarInstructores()
        {
            ClInstructorL oLogica = new ClInstructorL();
            gvInstructores.DataSource = oLogica.MtConsultar();
            gvInstructores.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlTipoDoc.SelectedValue == "" || txtNumeroDoc.Text.Trim() == ""
                || txtNombres.Text.Trim() == "" || txtApellidos.Text.Trim() == ""
                || txtCorreo.Text.Trim() == "")
            {
                MostrarError("completa todos los campos obligatorios");
                return;
            }

            Instructor oInstructor = new Instructor
            {
                IdInstructor = int.Parse(hfIdInstructor.Value),
                TipoDocumento = ddlTipoDoc.SelectedValue,
                NumeroDocumento = txtNumeroDoc.Text.Trim(),
                Nombres = txtNombres.Text.Trim(),
                Apellidos = txtApellidos.Text.Trim(),
                Correo = txtCorreo.Text.Trim(),
                Telefono = txtTelefono.Text.Trim(),
                Especialidad = txtEspecialidad.Text.Trim(),
                Estado = chkEstado.Checked ? "Activo" : "Inactivo"
            };

            ClInstructorL oLogica = new ClInstructorL();
            string resultado;

            if (oInstructor.IdInstructor == 0)
                resultado = oLogica.MtInsertar(oInstructor);
            else
                resultado = oLogica.MtModificar(oInstructor);

            if (resultado == "ok")
            {
                MostrarOk(oInstructor.IdInstructor == 0 ? "Instructor registrado correctamente." : "Instructor actualizado correctamente.");
                LimpiarFormulario();
                CargarInstructores();
            }
            else
            {
                MostrarError(resultado);
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            OcultarMensajes();
        }

        protected void gvInstructores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Editar")
            {
                ClInstructorL oLogica = new ClInstructorL();
                var lista = oLogica.MtConsultar();
                Instructor oInstructor = lista.Find(i => i.IdInstructor == id);
                if (oInstructor != null)
                {
                    hfIdInstructor.Value = oInstructor.IdInstructor.ToString();
                    ddlTipoDoc.SelectedValue = oInstructor.TipoDocumento;
                    txtNumeroDoc.Text = oInstructor.NumeroDocumento;
                    txtNombres.Text = oInstructor.Nombres;
                    txtApellidos.Text = oInstructor.Apellidos;
                    txtCorreo.Text = oInstructor.Correo;
                    txtTelefono.Text = oInstructor.Telefono;
                    txtEspecialidad.Text = oInstructor.Especialidad;
                    chkEstado.Checked = oInstructor.Estado == "Activo";
                    lblTituloFormulario.Text = "Editar Instructor";
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                ClInstructorL oLogica = new ClInstructorL();
                string resultado = oLogica.MtEliminar(id);
                if (resultado == "ok")
                    MostrarOk("Instructor eliminado correctamente.");
                else
                    MostrarError(resultado);
                CargarInstructores();
            }
        }

        protected void gvInstructores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvInstructores.PageIndex = e.NewPageIndex;
            CargarInstructores();
        }

        private void LimpiarFormulario()
        {
            hfIdInstructor.Value = "0";
            ddlTipoDoc.SelectedIndex = 0;
            txtNumeroDoc.Text = "";
            txtNombres.Text = "";
            txtApellidos.Text = "";
            txtCorreo.Text = "";
            txtTelefono.Text = "";
            txtEspecialidad.Text = "";
            chkEstado.Checked = true;
            lblTituloFormulario.Text = "Nuevo Instructor";
        }

        private void MostrarOk(string mensaje)
        {
            lblMensajeOk.Text = mensaje;
            lblMensajeOk.Visible = true;
            lblMensajeError.Visible = false;
        }

        private void MostrarError(string mensaje)
        {
            lblMensajeError.Text = mensaje;
            lblMensajeError.Visible = true;
            lblMensajeOk.Visible = false;
        }

        private void OcultarMensajes()
        {
            lblMensajeOk.Visible = false;
            lblMensajeError.Visible = false;
        }
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}