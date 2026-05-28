using System;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public partial class MenuAdmin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            { Response.Redirect("Login.aspx"); return; }

            if (Session["rol"].ToString() != "Administrador")
            { Response.Redirect("Login.aspx"); return; }

            if (!IsPostBack)
            {
                lblUsuario.Text = Session["usuario"].ToString();
                CargarDatosGraficas();
            }
        }

        private void CargarDatosGraficas()
        {
            try
            {
                Conexion oConexion = new Conexion();
                SqlConnection cn = oConexion.MtAbrirConexion();
                var js = new JavaScriptSerializer();

                var estadosAprendiz = new List<string>();
                var conteoAprendiz = new List<int>();
                SqlCommand cmd1 = new SqlCommand(
                    "SELECT Estado, COUNT(*) AS Total FROM Aprendiz GROUP BY Estado ORDER BY Total DESC", cn);
                SqlDataReader dr1 = cmd1.ExecuteReader();
                while (dr1.Read())
                {
                    estadosAprendiz.Add(dr1["Estado"].ToString());
                    conteoAprendiz.Add(Convert.ToInt32(dr1["Total"]));
                }
                dr1.Close();
                hfAprendizLabels.Value = js.Serialize(estadosAprendiz);
                hfAprendizData.Value = js.Serialize(conteoAprendiz);

                var estadosPlan = new List<string>();
                var conteoPlan = new List<int>();
                SqlCommand cmd2 = new SqlCommand(
                    "SELECT Estado, COUNT(*) AS Total FROM PlanMejoramiento GROUP BY Estado ORDER BY Total DESC", cn);
                SqlDataReader dr2 = cmd2.ExecuteReader();
                while (dr2.Read())
                {
                    estadosPlan.Add(dr2["Estado"].ToString());
                    conteoPlan.Add(Convert.ToInt32(dr2["Total"]));
                }
                dr2.Close();
                hfPlanLabels.Value = js.Serialize(estadosPlan);
                hfPlanData.Value = js.Serialize(conteoPlan);

                var fichas = new List<string>();
                var conteoFichas = new List<int>();
                SqlCommand cmd3 = new SqlCommand(
                    "SELECT f.CodigoFicha, COUNT(a.IdAprendiz) AS Total " +
                    "FROM Ficha f LEFT JOIN Aprendiz a ON f.IdFicha = a.IdFicha " +
                    "GROUP BY f.CodigoFicha ORDER BY Total DESC", cn);
                SqlDataReader dr3 = cmd3.ExecuteReader();
                while (dr3.Read())
                {
                    fichas.Add(dr3["CodigoFicha"].ToString());
                    conteoFichas.Add(Convert.ToInt32(dr3["Total"]));
                }
                dr3.Close();
                hfFichaLabels.Value = js.Serialize(fichas);
                hfFichaData.Value = js.Serialize(conteoFichas);

                SqlCommand cmd4 = new SqlCommand(
                    "SELECT " +
                    "(SELECT COUNT(*) FROM Programa) AS TotalProgramas," +
                    "(SELECT COUNT(*) FROM Ficha WHERE Estado='En ejecución') AS TotalFichas," +
                    "(SELECT COUNT(*) FROM Instructor WHERE Estado='Activo') AS TotalInstructores," +
                    "(SELECT COUNT(*) FROM Aprendiz) AS TotalAprendices", cn);
                SqlDataReader dr4 = cmd4.ExecuteReader();
                if (dr4.Read())
                {
                    lblTotalProgramas.Text = dr4["TotalProgramas"].ToString();
                    lblTotalFichas.Text = dr4["TotalFichas"].ToString();
                    lblTotalInstructores.Text = dr4["TotalInstructores"].ToString();
                    lblTotalAprendices.Text = dr4["TotalAprendices"].ToString();
                }
                dr4.Close();

                oConexion.MtCerrarConexion();
            }
            catch {  }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}