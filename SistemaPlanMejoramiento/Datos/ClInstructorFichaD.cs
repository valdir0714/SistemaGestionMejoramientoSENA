using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClInstructorFichaD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(InstructorFicha oIF)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO InstructorFicha (IdInstructor, IdFicha, FechaAsignacion) VALUES (@IdInstructor, @IdFicha, @FechaAsignacion)", cn);
            cmd.Parameters.AddWithValue("@IdInstructor", oIF.IdInstructor);
            cmd.Parameters.AddWithValue("@IdFicha", oIF.IdFicha);
            cmd.Parameters.AddWithValue("@FechaAsignacion", oIF.FechaAsignacion);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<InstructorFicha> MtConsultar()
        {
            List<InstructorFicha> lista = new List<InstructorFicha>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand(@"
                SELECT if2.IdInstructor, if2.IdFicha, if2.FechaAsignacion,
                       i.Nombres + ' ' + i.Apellidos AS NombreInstructor,
                       f.CodigoFicha
                FROM InstructorFicha if2
                INNER JOIN Instructor i ON if2.IdInstructor = i.IdInstructor
                INNER JOIN Ficha f ON if2.IdFicha = f.IdFicha", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                InstructorFicha oIF = new InstructorFicha();
                oIF.IdInstructor = Convert.ToInt32(dr["IdInstructor"]);
                oIF.IdFicha = Convert.ToInt32(dr["IdFicha"]);
                oIF.FechaAsignacion = Convert.ToDateTime(dr["FechaAsignacion"]);
                oIF.NombreInstructor = dr["NombreInstructor"].ToString();
                oIF.CodigoFicha = dr["CodigoFicha"].ToString();
                lista.Add(oIF);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtEliminar(int idInstructor, int idFicha)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM InstructorFicha WHERE IdInstructor=@IdInstructor AND IdFicha=@IdFicha", cn);
            cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
            cmd.Parameters.AddWithValue("@IdFicha", idFicha);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public bool MtExiste(int idInstructor, int idFicha)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM InstructorFicha WHERE IdInstructor=@IdInstructor AND IdFicha=@IdFicha", cn);
            cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
            cmd.Parameters.AddWithValue("@IdFicha", idFicha);
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            oConexion.MtCerrarConexion();
            return count > 0;
        }
    }
}