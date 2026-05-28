using SistemaPlanMejoramiento.Modelo;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class Fichas : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Administrador")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarProgramas();
                CargarFichas();
            }
        }

        private void CargarProgramas()
        {
            ClProgramaL oLogica = new ClProgramaL();
            ddlPrograma.DataSource = oLogica.MtConsultar();
            ddlPrograma.DataTextField = "NombrePrograma";
            ddlPrograma.DataValueField = "IdPrograma";
            ddlPrograma.DataBind();
            ddlPrograma.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
        }

        private void CargarFichas()
        {
            ClFichaL oLogica = new ClFichaL();
            gvFichas.DataSource = oLogica.MtConsultar();
            gvFichas.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (txtCodigo.Text.Trim() == "" || ddlPrograma.SelectedValue == "0"
                || txtFechaInicio.Text.Trim() == "" || txtFechaFin.Text.Trim() == ""
                || ddlJornada.SelectedValue == "")
            {
                MostrarError("completa todos los campos obligatorios");
                return;
            }

            Ficha oFicha = new Ficha
            {
                IdFicha = int.Parse(hfIdFicha.Value),
                CodigoFicha = txtCodigo.Text.Trim(),
                IdPrograma = int.Parse(ddlPrograma.SelectedValue),
                IdCentro = 1,
                FechaInicio = DateTime.Parse(txtFechaInicio.Text),
                FechaFinalizacion = DateTime.Parse(txtFechaFin.Text),
                Jornada = ddlJornada.SelectedValue,
                Descripcion = txtDescripcion.Text.Trim(),
                Estado = ddlEstado.SelectedValue
            };

            ClFichaL oLogica = new ClFichaL();
            string resultado;

            if (oFicha.IdFicha == 0)
                resultado = oLogica.MtInsertar(oFicha);
            else
                resultado = oLogica.MtModificar(oFicha);

            if (resultado == "ok")
            {
                MostrarOk(oFicha.IdFicha == 0 ? "Ficha registrada correctamente." : "Ficha actualizada correctamente.");
                LimpiarFormulario();
                CargarFichas();
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

        protected void gvFichas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Editar")
            {
                ClFichaL oLogica = new ClFichaL();
                var lista = oLogica.MtConsultar();
                Ficha oFicha = lista.Find(f => f.IdFicha == id);
                if (oFicha != null)
                {
                    hfIdFicha.Value = oFicha.IdFicha.ToString();
                    txtCodigo.Text = oFicha.CodigoFicha;
                    ddlPrograma.SelectedValue = oFicha.IdPrograma.ToString();
                    txtFechaInicio.Text = oFicha.FechaInicio.ToString("yyyy-MM-dd");
                    txtFechaFin.Text = oFicha.FechaFinalizacion.ToString("yyyy-MM-dd");
                    ddlJornada.SelectedValue = oFicha.Jornada;
                    txtDescripcion.Text = oFicha.Descripcion;
                    ddlEstado.SelectedValue = oFicha.Estado;
                    lblTituloFormulario.Text = "Editar Ficha";
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                ClFichaL oLogica = new ClFichaL();
                string resultado = oLogica.MtEliminar(id);
                if (resultado == "ok")
                    MostrarOk("Ficha eliminada correctamente.");
                else
                    MostrarError(resultado);
                CargarFichas();
            }
        }

        protected void gvFichas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFichas.PageIndex = e.NewPageIndex;
            CargarFichas();
        }

        private void LimpiarFormulario()
        {
            hfIdFicha.Value = "0";
            txtCodigo.Text = "";
            ddlPrograma.SelectedIndex = 0;
            txtFechaInicio.Text = "";
            txtFechaFin.Text = "";
            ddlJornada.SelectedIndex = 0;
            txtDescripcion.Text = "";
            ddlEstado.SelectedValue = "En ejecución";
            lblTituloFormulario.Text = "Nueva Ficha";
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
        protected string GetBadgeClass(string estado)
        {
            switch (estado)
            {
                case "En ejecución":
                    return "badge-ficha badge-ejecucion";

                case "Terminada":
                    return "badge-ficha badge-terminada";

                case "Cancelada":
                    return "badge-ficha badge-cancelada";

                default:
                    return "badge-ficha badge-ejecucion";
            }
        }
    }
}