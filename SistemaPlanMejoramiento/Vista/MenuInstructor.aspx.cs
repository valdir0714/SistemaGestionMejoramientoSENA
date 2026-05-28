using System;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;

namespace SistemaPlanMejoramiento
{
    public partial class MenuInstructor : Page
    {
        Conexion oConexion = new Conexion();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (Session["rol"] == null || Session["rol"].ToString() != "Instructor")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUsuario.Text = Session["usuario"].ToString();
                lblUsuarioBienvenida.Text = Session["usuario"].ToString();

                if (Session["idInstructor"] != null)
                {
                    int idInstructor = Convert.ToInt32(Session["idInstructor"]);
                    CargarResumenInstructor(idInstructor);
                    CargarActividadReciente(idInstructor);
                }
            }
        }

        private void CargarResumenInstructor(int idInstructor)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();

            SqlCommand cmdFichas = new SqlCommand(
                "SELECT COUNT(*) FROM InstructorFicha WHERE IdInstructor = @IdInstructor", cn);
            cmdFichas.Parameters.AddWithValue("@IdInstructor", idInstructor);
            lblTotalFichas.Text = cmdFichas.ExecuteScalar().ToString();

            SqlCommand cmdAprendices = new SqlCommand(@"
                SELECT COUNT(DISTINCT a.IdAprendiz)
                FROM Aprendiz a
                INNER JOIN InstructorFicha ifi ON a.IdFicha = ifi.IdFicha
                WHERE ifi.IdInstructor = @IdInstructor", cn);
            cmdAprendices.Parameters.AddWithValue("@IdInstructor", idInstructor);
            lblTotalAprendices.Text = cmdAprendices.ExecuteScalar().ToString();

            SqlCommand cmdPlanes = new SqlCommand(@"
                SELECT COUNT(*)
                FROM PlanMejoramiento
                WHERE IdInstructor = @IdInstructor
                AND Estado IN ('Pendiente', 'En Proceso')", cn);
            cmdPlanes.Parameters.AddWithValue("@IdInstructor", idInstructor);
            lblPlanesPendientes.Text = cmdPlanes.ExecuteScalar().ToString();

            SqlCommand cmdEvidencias = new SqlCommand(@"
                SELECT COUNT(*)
                FROM Evidencia e
                INNER JOIN PlanMejoramiento p ON e.IdPlan = p.IdPlan
                WHERE p.IdInstructor = @IdInstructor
                AND e.FechaSubida >= DATEADD(DAY, -7, GETDATE())", cn);
            cmdEvidencias.Parameters.AddWithValue("@IdInstructor", idInstructor);
            lblEvidenciasNuevas.Text = cmdEvidencias.ExecuteScalar().ToString();

            oConexion.MtCerrarConexion();
        }

        private void CargarActividadReciente(int idInstructor)
        {
            StringBuilder html = new StringBuilder();
            SqlConnection cn = oConexion.MtAbrirConexion();

            SqlCommand cmdPlan = new SqlCommand(@"
                SELECT TOP 1 a.Nombres + ' ' + a.Apellidos AS Aprendiz, p.Estado
                FROM PlanMejoramiento p
                INNER JOIN Aprendiz a ON p.IdAprendiz = a.IdAprendiz
                WHERE p.IdInstructor = @IdInstructor
                AND p.Estado IN ('Pendiente', 'En Proceso')
                ORDER BY p.FechaAsignacion DESC", cn);
            cmdPlan.Parameters.AddWithValue("@IdInstructor", idInstructor);

            SqlDataReader drPlan = cmdPlan.ExecuteReader();
            if (drPlan.Read())
            {
                html.Append(CrearItemActividad(
                    "dot-orange",
                    "Plan pendiente de " + HttpUtility.HtmlEncode(drPlan["Aprendiz"].ToString()),
                    "Estado actual: " + HttpUtility.HtmlEncode(drPlan["Estado"].ToString())
                ));
            }
            drPlan.Close();

            SqlCommand cmdEvidencia = new SqlCommand(@"
                SELECT TOP 1 a.Nombres + ' ' + a.Apellidos AS Aprendiz, e.NombreArchivo
                FROM Evidencia e
                INNER JOIN PlanMejoramiento p ON e.IdPlan = p.IdPlan
                INNER JOIN Aprendiz a ON p.IdAprendiz = a.IdAprendiz
                WHERE p.IdInstructor = @IdInstructor
                ORDER BY e.FechaSubida DESC", cn);
            cmdEvidencia.Parameters.AddWithValue("@IdInstructor", idInstructor);

            SqlDataReader drEvidencia = cmdEvidencia.ExecuteReader();
            if (drEvidencia.Read())
            {
                html.Append(CrearItemActividad(
                    "dot-blue",
                    "Evidencia cargada por " + HttpUtility.HtmlEncode(drEvidencia["Aprendiz"].ToString()),
                    "Archivo: " + HttpUtility.HtmlEncode(drEvidencia["NombreArchivo"].ToString())
                ));
            }
            drEvidencia.Close();

            SqlCommand cmdEvaluacion = new SqlCommand(@"
                SELECT TOP 1 a.Nombres + ' ' + a.Apellidos AS Aprendiz, p.Estado
                FROM PlanMejoramiento p
                INNER JOIN Aprendiz a ON p.IdAprendiz = a.IdAprendiz
                WHERE p.IdInstructor = @IdInstructor
                AND p.Estado IN ('Aprobado', 'No Aprobado')
                ORDER BY p.FechaAsignacion DESC", cn);
            cmdEvaluacion.Parameters.AddWithValue("@IdInstructor", idInstructor);

            SqlDataReader drEvaluacion = cmdEvaluacion.ExecuteReader();
            if (drEvaluacion.Read())
            {
                html.Append(CrearItemActividad(
                    "dot-green",
                    "Evaluación finalizada",
                    "Aprendiz: " + HttpUtility.HtmlEncode(drEvaluacion["Aprendiz"].ToString()) +
                    " | Resultado: " + HttpUtility.HtmlEncode(drEvaluacion["Estado"].ToString())
                ));
            }
            drEvaluacion.Close();

            oConexion.MtCerrarConexion();

            if (html.Length == 0)
            {
                html.Append(CrearItemActividad(
                    "dot-green",
                    "Sin actividad reciente",
                    "Aún no hay movimientos registrados para este instructor."
                ));
            }

            ltActividadReciente.Text = html.ToString();
        }

        private string CrearItemActividad(string dotClass, string titulo, string detalle)
        {
            return $@"
                <div class='activity-item'>
                    <div class='activity-dot {dotClass}'></div>
                    <div>
                        <h4>{titulo}</h4>
                        <p>{detalle}</p>
                    </div>
                </div>";
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}