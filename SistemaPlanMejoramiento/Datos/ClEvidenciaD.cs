using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClEvidenciaD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Evidencia oEvidencia)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO Evidencia (IdPlan, NombreArchivo, RutaArchivo, TipoArchivo, FechaSubida, Observaciones) VALUES (@IdPlan, @NombreArchivo, @RutaArchivo, @TipoArchivo, @FechaSubida, @Observaciones)", cn);
            cmd.Parameters.AddWithValue("@IdPlan", oEvidencia.IdPlan);
            cmd.Parameters.AddWithValue("@NombreArchivo", oEvidencia.NombreArchivo);
            cmd.Parameters.AddWithValue("@RutaArchivo", "~/Evidencias/" + oEvidencia.NombreArchivo);
            cmd.Parameters.AddWithValue("@TipoArchivo", oEvidencia.TipoArchivo);
            cmd.Parameters.AddWithValue("@FechaSubida", oEvidencia.FechaSubida);
            cmd.Parameters.AddWithValue("@Observaciones", (object)oEvidencia.Observaciones ?? DBNull.Value);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<Evidencia> MtConsultar(int idPlan)
        {
            List<Evidencia> lista = new List<Evidencia>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Evidencia WHERE IdPlan=@IdPlan", cn);
            cmd.Parameters.AddWithValue("@IdPlan", idPlan);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Evidencia oEvidencia = new Evidencia();
                oEvidencia.IdEvidencia = Convert.ToInt32(dr["IdEvidencia"]);
                oEvidencia.IdPlan = Convert.ToInt32(dr["IdPlan"]);
                oEvidencia.NombreArchivo = dr["NombreArchivo"].ToString();
                oEvidencia.RutaArchivo = dr["RutaArchivo"].ToString();
                oEvidencia.TipoArchivo = dr["TipoArchivo"].ToString();
                oEvidencia.FechaSubida = Convert.ToDateTime(dr["FechaSubida"]);
                oEvidencia.Observaciones = dr["Observaciones"].ToString();
                lista.Add(oEvidencia);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtEliminar(int idEvidencia)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM Evidencia WHERE IdEvidencia=@IdEvidencia", cn);
            cmd.Parameters.AddWithValue("@IdEvidencia", idEvidencia);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}