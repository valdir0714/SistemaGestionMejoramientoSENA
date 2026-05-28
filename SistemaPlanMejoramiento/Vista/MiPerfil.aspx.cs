using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MiPerfil : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null || Session["rol"].ToString() != "Aprendiz")
            { Response.Redirect("Login.aspx"); return; }
            if (!IsPostBack) CargarPerfil();
        }

        private void CargarPerfil()
        {
            try
            {
                int idAprendiz = Convert.ToInt32(Session["idAprendiz"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Aprendiz WHERE IdAprendiz=@Id", cn);
                cmd.Parameters.AddWithValue("@Id", idAprendiz);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblNombres.Text = dr["Nombres"].ToString();
                    lblApellidos.Text = dr["Apellidos"].ToString();
                    lblTipoDoc.Text = dr["TipoDocumento"].ToString();
                    lblNumeroDoc.Text = dr["NumeroDocumento"].ToString();
                    lblCorreo.Text = dr["Correo"].ToString();
                    lblTelefono.Text = dr["Telefono"].ToString();
                    lblEstado.Text = dr["Estado"].ToString();
                }
                oConexion.MtCerrarConexion();
            }
            catch (Exception ex) { lblError.Text = "Error: " + ex.Message; lblError.Visible = true; }
        }
    }
}