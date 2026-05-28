using OfficeOpenXml;
using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaPlanMejoramiento
{
    public partial class Aprendices : Page
    {
        ClAprendizL oLogica = new ClAprendizL();
        ClFichaL oLogicaFicha = new ClFichaL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                CargarFichas();
                CargarTabla();
                MostrarTabManual();
            }
        }

        private void CargarFichas()
        {
            var fichas = oLogicaFicha.MtConsultar();
            ddlFicha.DataSource = fichas;
            ddlFicha.DataTextField = "CodigoFicha";
            ddlFicha.DataValueField = "IdFicha";
            ddlFicha.DataBind();
            ddlFicha.Items.Insert(0, new ListItem("-- Seleccione ficha --", "0"));
        }

        private void CargarTabla()
        {
            gvAprendices.DataSource = oLogica.MtConsultar();
            gvAprendices.DataBind();
        }

        protected string GetBadgeClass(string estado)
        {
            switch (estado)
            {
                case "En Formación":
                case "En Formacion":
                    return "badge-sena badge-formacion";

                case "Cancelado":
                    return "badge-sena badge-cancelado";

                case "Aplazado":
                    return "badge-sena badge-aplazado";

                case "Condicionado":
                    return "badge-sena badge-condicionado";

                default:
                    return "badge-sena badge-otro";
            }
        }

        protected void btnTabManual_Click(object sender, EventArgs e)
        {
            MostrarTabManual();
        }

        protected void btnTabExcel_Click(object sender, EventArgs e)
        {
            pnlManual.Visible = false;
            pnlExcel.Visible = true;

            btnTabManual.CssClass = "tab-pill";
            btnTabExcel.CssClass = "tab-pill activo";
        }

        private void MostrarTabManual()
        {
            pnlManual.Visible = true;
            pnlExcel.Visible = false;

            btnTabManual.CssClass = "tab-pill activo";
            btnTabExcel.CssClass = "tab-pill";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Aprendiz oAprendiz = new Aprendiz();
            oAprendiz.IdAprendiz = Convert.ToInt32(hfIdAprendiz.Value);
            oAprendiz.TipoDocumento = ddlTipoDoc.SelectedValue;
            oAprendiz.NumeroDocumento = txtNumeroDoc.Text.Trim();
            oAprendiz.Nombres = txtNombres.Text.Trim();
            oAprendiz.Apellidos = txtApellidos.Text.Trim();
            oAprendiz.Correo = txtCorreo.Text.Trim();
            oAprendiz.Telefono = txtTelefono.Text.Trim();
            oAprendiz.IdFicha = Convert.ToInt32(ddlFicha.SelectedValue);
            oAprendiz.Estado = ddlEstado.SelectedValue;

            string resultado;
            if (oAprendiz.IdAprendiz == 0)
                resultado = oLogica.MtInsertar(oAprendiz);
            else
                resultado = oLogica.MtModificar(oAprendiz);

            if (resultado == "ok")
            {
                MostrarOk(oAprendiz.IdAprendiz == 0 ? "Aprendiz registrado correctamente." : "Aprendiz actualizado correctamente.");
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

        private void LimpiarFormulario()
        {
            hfIdAprendiz.Value = "0";
            ddlTipoDoc.SelectedIndex = 0;
            txtNumeroDoc.Text = "";
            txtNombres.Text = "";
            txtApellidos.Text = "";
            txtCorreo.Text = "";
            txtTelefono.Text = "";
            ddlFicha.SelectedIndex = 0;
            ddlEstado.SelectedValue = "En Formación";
            lblTituloFormulario.Text = "Nuevo Aprendiz";
        }


        protected void gvAprendices_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                var lista = oLogica.MtConsultar();
                Aprendiz oAprendiz = lista.Find(a => a.IdAprendiz == id);
                if (oAprendiz != null)
                {
                    hfIdAprendiz.Value = oAprendiz.IdAprendiz.ToString();
                    ddlTipoDoc.SelectedValue = oAprendiz.TipoDocumento;
                    txtNumeroDoc.Text = oAprendiz.NumeroDocumento;
                    txtNombres.Text = oAprendiz.Nombres;
                    txtApellidos.Text = oAprendiz.Apellidos;
                    txtCorreo.Text = oAprendiz.Correo;
                    txtTelefono.Text = oAprendiz.Telefono;
                    ddlFicha.SelectedValue = oAprendiz.IdFicha.ToString();
                    ddlEstado.SelectedValue = oAprendiz.Estado;
                    lblTituloFormulario.Text = "Editar Aprendiz";
                    MostrarTabManual();
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                string resultado = oLogica.MtEliminar(id);
                if (resultado == "ok")
                    MostrarOk("Aprendiz eliminado correctamente.");
                else
                    MostrarError(resultado);
                CargarTabla();
            }
        }

        protected void gvAprendices_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAprendices.PageIndex = e.NewPageIndex;
            CargarTabla();
        }

        protected void btnCargarExcel_Click(object sender, EventArgs e)
        {
            pnlErroresExcel.Visible = false;
            blErrores.Items.Clear();

            if (!fuExcel.HasFile)
            {
                MostrarError("Por favor selecciona un archivo Excel.");
                return;
            }

            if (!fuExcel.FileName.EndsWith(".xlsx"))
            {
                MostrarError("Solo se permiten archivos .xlsx");
                return;
            }

            var fichas = oLogicaFicha.MtConsultar();
            var aprendicesExistentes = oLogica.MtConsultar();
            List<string> errores = new List<string>();
            int registrados = 0;

            using (var paquete = new ExcelPackage(fuExcel.FileContent))
            {
                var hoja = paquete.Workbook.Worksheets[1];
                if (hoja == null || hoja.Dimension == null)
                {
                    MostrarError("El archivo Excel está vacío o no tiene datos.");
                    return;
                }

                int totalFilas = hoja.Dimension.End.Row;

                for (int fila = 2; fila <= totalFilas; fila++)
                {
                    string tipoDoc = ObtenerCelda(hoja, fila, 1);
                    string numDoc = ObtenerCelda(hoja, fila, 2);
                    string nombres = ObtenerCelda(hoja, fila, 3);
                    string apellidos = ObtenerCelda(hoja, fila, 4);
                    string correo = ObtenerCelda(hoja, fila, 5);
                    string telefono = ObtenerCelda(hoja, fila, 6);
                    string codigoFicha = ObtenerCelda(hoja, fila, 7);

                    if (string.IsNullOrWhiteSpace(numDoc)) { errores.Add($"Fila {fila}: Número de documento vacío."); continue; }
                    if (string.IsNullOrWhiteSpace(nombres)) { errores.Add($"Fila {fila}: Nombres vacíos."); continue; }
                    if (string.IsNullOrWhiteSpace(apellidos)) { errores.Add($"Fila {fila}: Apellidos vacíos."); continue; }
                    if (string.IsNullOrWhiteSpace(correo) || !correo.Contains("@")) { errores.Add($"Fila {fila}: Correo inválido."); continue; }
                    if (string.IsNullOrWhiteSpace(codigoFicha)) { errores.Add($"Fila {fila}: Código de ficha vacío."); continue; }

                    string[] tiposValidos = { "CC", "TI", "CE", "PA" };
                    if (!Array.Exists(tiposValidos, t => t == tipoDoc.ToUpper()))
                    { errores.Add($"Fila {fila}: Tipo de documento '{tipoDoc}' no válido."); continue; }

                    if (aprendicesExistentes.Exists(a => a.NumeroDocumento == numDoc))
                    { errores.Add($"Fila {fila}: Documento '{numDoc}' ya existe en el sistema."); continue; }

                    Ficha fichaEncontrada = fichas.Find(f => f.CodigoFicha == codigoFicha);
                    if (fichaEncontrada == null)
                    { errores.Add($"Fila {fila}: Ficha '{codigoFicha}' no encontrada."); continue; }

                    Aprendiz oAprendiz = new Aprendiz();
                    oAprendiz.TipoDocumento = tipoDoc.ToUpper();
                    oAprendiz.NumeroDocumento = numDoc;
                    oAprendiz.Nombres = nombres;
                    oAprendiz.Apellidos = apellidos;
                    oAprendiz.Correo = correo;
                    oAprendiz.Telefono = telefono;
                    oAprendiz.IdFicha = fichaEncontrada.IdFicha;
                    oAprendiz.Estado = "En Formación";

                    try
                    {
                        ClAprendizD oDatos = new ClAprendizD();
                        oDatos.MtInsertar(oAprendiz);
                        registrados++;
                    }
                    catch (Exception ex)
                    {
                        errores.Add($"Fila {fila}: Error al guardar — {ex.Message}");
                    }
                }
            }

            if (errores.Count > 0)
            {
                pnlErroresExcel.Visible = true;
                foreach (var err in errores)
                    blErrores.Items.Add(err);
            }

            if (registrados > 0)
                MostrarOk($"{registrados} aprendiz(ces) registrado(s) correctamente desde Excel.");

            CargarTabla();
        }

        private string ObtenerCelda(OfficeOpenXml.ExcelWorksheet hoja, int fila, int col)
        {
            var val = hoja.Cells[fila, col].Value;
            return val == null ? "" : val.ToString().Trim();
        }

        private void MostrarOk(string msg)
        {
            lblMensajeOk.Text = "✔ " + msg;
            lblMensajeOk.Visible = true;
            lblMensajeError.Visible = false;
        }

        private void MostrarError(string msg)
        {
            lblMensajeError.Text = "✖ " + msg;
            lblMensajeError.Visible = true;
            lblMensajeOk.Visible = false;
        }
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}