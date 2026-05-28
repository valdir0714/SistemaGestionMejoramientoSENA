using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MenuAprendiz : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            { Response.Redirect("Login.aspx"); return; }

            if (Session["rol"].ToString() != "Aprendiz")
            { Response.Redirect("Login.aspx"); return; }

            if (!IsPostBack)
            {
                lblUsuario.Text = Session["usuario"].ToString();
                CargarDatos();
            }
        }

        private void CargarDatos()
        {
            try
            {
                int idAprendiz = Convert.ToInt32(Session["idAprendiz"]);
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();

                SqlCommand cmd1 = new SqlCommand(
                    "SELECT a.Nombres, a.Apellidos, a.Estado, a.NumeroDocumento, " +
                    "f.CodigoFicha, p.NombrePrograma, f.FechaFin " +
                    "FROM Aprendiz a " +
                    "INNER JOIN Ficha f ON a.IdFicha = f.IdFicha " +
                    "INNER JOIN Programa p ON f.IdPrograma = p.IdPrograma " +
                    "WHERE a.IdAprendiz = @Id", cn);
                cmd1.Parameters.AddWithValue("@Id", idAprendiz);
                SqlDataReader dr1 = cmd1.ExecuteReader();
                if (dr1.Read())
                {
                    lblNombreCompleto.Text = dr1["Nombres"].ToString() + " " + dr1["Apellidos"].ToString();
                    lblEstado.Text = dr1["Estado"].ToString();
                    lblDocumento.Text = dr1["NumeroDocumento"].ToString();
                    lblFicha.Text = dr1["CodigoFicha"].ToString();
                    lblPrograma.Text = dr1["NombrePrograma"].ToString();
                    lblFechaFin.Text = Convert.ToDateTime(dr1["FechaFin"]).ToString("dd/MM/yyyy");
                }
                dr1.Close();

                SqlCommand cmd2 = new SqlCommand(
                    "SELECT " +
                    "(SELECT COUNT(*) FROM PlanMejoramiento WHERE IdAprendiz=@Id) AS TotalPlanes," +
                    "(SELECT COUNT(*) FROM PlanMejoramiento WHERE IdAprendiz=@Id AND Estado='Pendiente') AS PlanesPendientes," +
                    "(SELECT COUNT(*) FROM PlanMejoramiento WHERE IdAprendiz=@Id AND Estado='Aprobado') AS PlanesAprobados," +
                    "(SELECT COUNT(*) FROM Evidencia e INNER JOIN PlanMejoramiento p ON e.IdPlan=p.IdPlan WHERE p.IdAprendiz=@Id) AS TotalEvidencias",
                    cn);
                cmd2.Parameters.AddWithValue("@Id", idAprendiz);
                SqlDataReader dr2 = cmd2.ExecuteReader();
                if (dr2.Read())
                {
                    lblTotalPlanes.Text = dr2["TotalPlanes"].ToString();
                    lblPlanesPendientes.Text = dr2["PlanesPendientes"].ToString();
                    lblPlanesAprobados.Text = dr2["PlanesAprobados"].ToString();
                    lblTotalEvidencias.Text = dr2["TotalEvidencias"].ToString();
                }
                dr2.Close();

                oConexion.MtCerrarConexion();
            }
            catch { }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
