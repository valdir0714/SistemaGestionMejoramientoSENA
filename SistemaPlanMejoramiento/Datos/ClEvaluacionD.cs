using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClEvaluacionD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Evaluacion oEvaluacion)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO Evaluacion (IdPlan, Producto, Conocimiento, Desempeno, Observaciones, FechaEvaluacion, ResultadoFinal) VALUES (@IdPlan, @Producto, @Conocimiento, @Desempeno, @Observaciones, @FechaEvaluacion, @ResultadoFinal)", cn);
            cmd.Parameters.AddWithValue("@IdPlan", oEvaluacion.IdPlan);
            cmd.Parameters.AddWithValue("@Producto", oEvaluacion.Producto);
            cmd.Parameters.AddWithValue("@Conocimiento", oEvaluacion.Conocimiento);
            cmd.Parameters.AddWithValue("@Desempeno", oEvaluacion.Desempeno);
            cmd.Parameters.AddWithValue("@Observaciones", oEvaluacion.Observaciones);
            cmd.Parameters.AddWithValue("@FechaEvaluacion", oEvaluacion.FechaEvaluacion);
            cmd.Parameters.AddWithValue("@ResultadoFinal", oEvaluacion.ResultadoFinal);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public Evaluacion MtConsultarPorPlan(int idPlan)
        {
            Evaluacion oEvaluacion = null;
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Evaluacion WHERE IdPlan=@IdPlan", cn);
            cmd.Parameters.AddWithValue("@IdPlan", idPlan);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                oEvaluacion = new Evaluacion();
                oEvaluacion.IdEvaluacion = Convert.ToInt32(dr["IdEvaluacion"]);
                oEvaluacion.IdPlan = Convert.ToInt32(dr["IdPlan"]);
                oEvaluacion.Producto = dr["Producto"].ToString();
                oEvaluacion.Conocimiento = dr["Conocimiento"].ToString();
                oEvaluacion.Desempeno = dr["Desempeno"].ToString();
                oEvaluacion.Observaciones = dr["Observaciones"].ToString();
                oEvaluacion.FechaEvaluacion = Convert.ToDateTime(dr["FechaEvaluacion"]);
                oEvaluacion.ResultadoFinal = dr["ResultadoFinal"].ToString();
            }
            oConexion.MtCerrarConexion();
            return oEvaluacion;
        }
    }
}