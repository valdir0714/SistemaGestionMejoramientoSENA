using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClPlanMejoramientoD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(PlanMejoramiento oPlan)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO PlanMejoramiento (IdAprendiz, IdInstructor, IdFicha, TipoPlan, Actividades, Observaciones, FechaAsignacion, FechaLimite, Estado) VALUES (@IdAprendiz, @IdInstructor, @IdFicha, @TipoPlan, @Actividades, @Observaciones, @FechaAsignacion, @FechaLimite, @Estado)", cn);
            cmd.Parameters.AddWithValue("@IdAprendiz", oPlan.IdAprendiz);
            cmd.Parameters.AddWithValue("@IdInstructor", oPlan.IdInstructor);
            cmd.Parameters.AddWithValue("@IdFicha", oPlan.IdFicha);
            cmd.Parameters.AddWithValue("@TipoPlan", oPlan.TipoPlan);
            cmd.Parameters.AddWithValue("@Actividades", oPlan.Actividades);
            cmd.Parameters.AddWithValue("@Observaciones", oPlan.Observaciones);
            cmd.Parameters.AddWithValue("@FechaAsignacion", oPlan.FechaAsignacion);
            cmd.Parameters.AddWithValue("@FechaLimite", oPlan.FechaLimite);
            cmd.Parameters.AddWithValue("@Estado", oPlan.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<PlanMejoramiento> MtConsultar()
        {
            List<PlanMejoramiento> lista = new List<PlanMejoramiento>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT p.*, a.Nombres + ' ' + a.Apellidos AS NombreAprendiz, i.Nombres + ' ' + i.Apellidos AS NombreInstructor FROM PlanMejoramiento p INNER JOIN Aprendiz a ON p.IdAprendiz = a.IdAprendiz INNER JOIN Instructor i ON p.IdInstructor = i.IdInstructor", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                PlanMejoramiento oPlan = new PlanMejoramiento();
                oPlan.IdPlan = Convert.ToInt32(dr["IdPlan"]);
                oPlan.IdAprendiz = Convert.ToInt32(dr["IdAprendiz"]);
                oPlan.IdInstructor = Convert.ToInt32(dr["IdInstructor"]);
                oPlan.IdFicha = Convert.ToInt32(dr["IdFicha"]);
                oPlan.TipoPlan = dr["TipoPlan"].ToString();
                oPlan.Actividades = dr["Actividades"].ToString();
                oPlan.Observaciones = dr["Observaciones"].ToString();
                oPlan.FechaAsignacion = Convert.ToDateTime(dr["FechaAsignacion"]);
                oPlan.FechaLimite = Convert.ToDateTime(dr["FechaLimite"]);
                oPlan.Estado = dr["Estado"].ToString();
                lista.Add(oPlan);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtModificar(PlanMejoramiento oPlan)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("UPDATE PlanMejoramiento SET Actividades=@Actividades, Observaciones=@Observaciones, FechaLimite=@FechaLimite, Estado=@Estado WHERE IdPlan=@IdPlan", cn);
            cmd.Parameters.AddWithValue("@IdPlan", oPlan.IdPlan);
            cmd.Parameters.AddWithValue("@Actividades", oPlan.Actividades);
            cmd.Parameters.AddWithValue("@Observaciones", oPlan.Observaciones);
            cmd.Parameters.AddWithValue("@FechaLimite", oPlan.FechaLimite);
            cmd.Parameters.AddWithValue("@Estado", oPlan.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public void MtEliminar(int idPlan)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM PlanMejoramiento WHERE IdPlan=@IdPlan", cn);
            cmd.Parameters.AddWithValue("@IdPlan", idPlan);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}