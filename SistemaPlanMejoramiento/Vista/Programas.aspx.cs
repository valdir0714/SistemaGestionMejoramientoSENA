using SistemaPlanMejoramiento.Modelo;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class Programas : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Administrador")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
                CargarProgramas();
        }

        private void CargarProgramas(string filtro = "")
        {
            ClProgramaL oLogica = new ClProgramaL();
            gvProgramas.DataSource = oLogica.MtConsultar(filtro);
            gvProgramas.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (txtCodigo.Text.Trim() == "" || txtNombre.Text.Trim() == "" ||
                txtVersion.Text.Trim() == "" || ddlNivel.SelectedValue == "" ||
                txtDuracion.Text.Trim() == "")
            {
                MostrarError("Por favor completa todos los campos obligatorios.");
                return;
            }

            int duracion;
            if (!int.TryParse(txtDuracion.Text.Trim(), out duracion) || duracion <= 0)
            {
                MostrarError("La duración debe ser un número entero mayor a cero.");
                return;
            }

            Programa oPrograma = new Programa
            {
                IdPrograma = int.Parse(hfIdPrograma.Value),
                CodigoPrograma = txtCodigo.Text.Trim(),
                NombrePrograma = txtNombre.Text.Trim(),
                Version = txtVersion.Text.Trim(),
                NivelFormacion = ddlNivel.SelectedValue,
                Duracion = duracion,
                Estado = ddlEstado.SelectedValue
            };

            ClProgramaL oLogica = new ClProgramaL();
            string resultado;

            if (oPrograma.IdPrograma == 0)
                resultado = oLogica.MtInsertar(oPrograma);
            else
                resultado = oLogica.MtModificar(oPrograma);

            if (resultado == "ok")
                MostrarOk(oPrograma.IdPrograma == 0 ? "Programa registrado correctamente." : "Programa actualizado correctamente.");
            else
                MostrarError(resultado);

            LimpiarFormulario();
            CargarProgramas();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            OcultarMensajes();
        }

        protected void gvProgramas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            ClProgramaL oLogica = new ClProgramaL();

            if (e.CommandName == "Editar")
            {
                Programa oPrograma = oLogica.MtObtenerPorId(id);
                if (oPrograma != null)
                {
                    hfIdPrograma.Value = oPrograma.IdPrograma.ToString();
                    txtCodigo.Text = oPrograma.CodigoPrograma;
                    txtNombre.Text = oPrograma.NombrePrograma;
                    txtVersion.Text = oPrograma.Version;
                    ddlNivel.SelectedValue = oPrograma.NivelFormacion;
                    txtDuracion.Text = oPrograma.Duracion.ToString();
                    ddlEstado.SelectedValue = oPrograma.Estado;
                    lblTituloFormulario.Text = "Editar Programa";
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                string resultado = oLogica.MtEliminar(id);
                if (resultado == "ok")
                    MostrarOk("Programa eliminado correctamente.");
                else
                    MostrarError("No se puede eliminar: tiene fichas asociadas.");

                CargarProgramas();
            }
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            CargarProgramas(txtBuscar.Text.Trim());
        }

        private void LimpiarFormulario()
        {
            hfIdPrograma.Value = "0";
            txtCodigo.Text = "";
            txtNombre.Text = "";
            txtVersion.Text = "";
            ddlNivel.SelectedIndex = 0;
            txtDuracion.Text = "";
            ddlEstado.SelectedIndex = 0;
            lblTituloFormulario.Text = "Nuevo Programa";
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
    }
}