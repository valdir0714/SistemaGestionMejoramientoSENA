using SistemaPlanMejoramiento.Modelo;
using System;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                Response.Redirect("MenuAdmin.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string contrasena = txtContrasena.Text.Trim();

            if (usuario == "" || contrasena == "")
            {
                MostrarError("por favor completa todos los campos");
                return;
            }

            ClUsuarioL oLogica = new ClUsuarioL();
            Usuario oUsuario = oLogica.MtLogin(usuario, contrasena);

            if (oUsuario == null)
            {
                MostrarError("usuario o contraseña incorrectos");
                return;
            }

            Session["usuario"] = oUsuario.NombreUsuario;
            Session["rol"] = oUsuario.Rol;
            Session["idUsuario"] = oUsuario.IdUsuario;
            Session["idInstructor"] = oUsuario.IdInstructor;
            Session["idAprendiz"] = oUsuario.IdAprendiz;
            Session["idReferencia"] = oUsuario.IdAprendiz;

            if (oUsuario.Rol == "Administrador")
                Response.Redirect("MenuAdmin.aspx");
            else if (oUsuario.Rol == "Instructor")
                Response.Redirect("MenuInstructor.aspx");
            else if (oUsuario.Rol == "Aprendiz")
                Response.Redirect("MenuAprendiz.aspx");
        }

        private void MostrarError(string mensaje)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.Visible = true;
        }
    }
}