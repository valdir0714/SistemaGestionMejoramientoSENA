using System;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MenuAdmin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // verifico que sea administrador
            if (Session["rol"].ToString() != "Administrador")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUsuario.Text = Session["usuario"].ToString();
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}