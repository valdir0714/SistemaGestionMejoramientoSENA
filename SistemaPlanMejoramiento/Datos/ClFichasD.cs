using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClFichaDatos
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Ficha oFicha)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO Ficha (IdPrograma, CodigoFicha, FechaInicio, FechaFinalizacion, Jornada, Descripcion, Estado) VALUES (@IdPrograma, @CodigoFicha, @FechaInicio, @FechaFinalizacion, @Jornada, @Descripcion, @Estado)", cn);
            cmd.Parameters.AddWithValue("@IdPrograma", oFicha.IdPrograma);
            cmd.Parameters.AddWithValue("@CodigoFicha", oFicha.CodigoFicha);
            cmd.Parameters.AddWithValue("@FechaInicio", oFicha.FechaInicio);
            cmd.Parameters.AddWithValue("@FechaFinalizacion", oFicha.FechaFinalizacion);
            cmd.Parameters.AddWithValue("@Jornada", oFicha.Jornada);
            cmd.Parameters.AddWithValue("@Descripcion", oFicha.Descripcion);
            cmd.Parameters.AddWithValue("@Estado", oFicha.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<Ficha> MtConsultar()
        {
            List<Ficha> lista = new List<Ficha>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT f.*, p.NombrePrograma FROM Ficha f INNER JOIN Programa p ON f.IdPrograma = p.IdPrograma", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Ficha oFicha = new Ficha();
                oFicha.IdFicha = Convert.ToInt32(dr["IdFicha"]);
                oFicha.IdPrograma = Convert.ToInt32(dr["IdPrograma"]);
                oFicha.CodigoFicha = dr["CodigoFicha"].ToString();
                oFicha.FechaInicio = Convert.ToDateTime(dr["FechaInicio"]);
                oFicha.FechaFinalizacion = Convert.ToDateTime(dr["FechaFinalizacion"]);
                oFicha.Jornada = dr["Jornada"].ToString();
                oFicha.Descripcion = dr["Descripcion"].ToString();
                oFicha.Estado = dr["Estado"].ToString();
                lista.Add(oFicha);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtModificar(Ficha oFicha)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("UPDATE Ficha SET IdPrograma=@IdPrograma, CodigoFicha=@CodigoFicha, FechaInicio=@FechaInicio, FechaFinalizacion=@FechaFinalizacion, Jornada=@Jornada, Descripcion=@Descripcion, Estado=@Estado WHERE IdFicha=@IdFicha", cn);
            cmd.Parameters.AddWithValue("@IdFicha", oFicha.IdFicha);
            cmd.Parameters.AddWithValue("@IdPrograma", oFicha.IdPrograma);
            cmd.Parameters.AddWithValue("@CodigoFicha", oFicha.CodigoFicha);
            cmd.Parameters.AddWithValue("@FechaInicio", oFicha.FechaInicio);
            cmd.Parameters.AddWithValue("@FechaFinalizacion", oFicha.FechaFinalizacion);
            cmd.Parameters.AddWithValue("@Jornada", oFicha.Jornada);
            cmd.Parameters.AddWithValue("@Descripcion", oFicha.Descripcion);
            cmd.Parameters.AddWithValue("@Estado", oFicha.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public void MtEliminar(int idFicha)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM Ficha WHERE IdFicha=@IdFicha", cn);
            cmd.Parameters.AddWithValue("@IdFicha", idFicha);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}