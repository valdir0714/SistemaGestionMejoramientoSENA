using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClProgramaDatos
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Programa oPrograma)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Programa (CodigoPrograma, NombrePrograma, Version, NivelFormacion, Duracion, Estado) " +
                "VALUES (@CodigoPrograma, @NombrePrograma, @Version, @NivelFormacion, @Duracion, @Estado)", cn);
            cmd.Parameters.AddWithValue("@CodigoPrograma", oPrograma.CodigoPrograma);
            cmd.Parameters.AddWithValue("@NombrePrograma", oPrograma.NombrePrograma);
            cmd.Parameters.AddWithValue("@Version", oPrograma.Version);
            cmd.Parameters.AddWithValue("@NivelFormacion", oPrograma.NivelFormacion);
            cmd.Parameters.AddWithValue("@Duracion", oPrograma.Duracion);
            cmd.Parameters.AddWithValue("@Estado", oPrograma.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<Programa> MtConsultar(string filtro = "")
        {
            List<Programa> lista = new List<Programa>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            string query = "SELECT * FROM Programa";
            if (filtro != "")
                query += " WHERE CodigoPrograma LIKE @filtro OR NombrePrograma LIKE @filtro";
            query += " ORDER BY NombrePrograma";
            SqlCommand cmd = new SqlCommand(query, cn);
            if (filtro != "")
                cmd.Parameters.AddWithValue("@filtro", "%" + filtro + "%");
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Programa oPrograma = new Programa();
                oPrograma.IdPrograma = Convert.ToInt32(dr["IdPrograma"]);
                oPrograma.CodigoPrograma = dr["CodigoPrograma"].ToString();
                oPrograma.NombrePrograma = dr["NombrePrograma"].ToString();
                oPrograma.Version = dr["Version"].ToString();
                oPrograma.NivelFormacion = dr["NivelFormacion"].ToString();
                oPrograma.Duracion = Convert.ToInt32(dr["Duracion"]);
                oPrograma.Estado = dr["Estado"].ToString();
                lista.Add(oPrograma);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public Programa MtObtenerPorId(int idPrograma)
        {
            Programa oPrograma = null;
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Programa WHERE IdPrograma = @IdPrograma", cn);
            cmd.Parameters.AddWithValue("@IdPrograma", idPrograma);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                oPrograma = new Programa();
                oPrograma.IdPrograma = Convert.ToInt32(dr["IdPrograma"]);
                oPrograma.CodigoPrograma = dr["CodigoPrograma"].ToString();
                oPrograma.NombrePrograma = dr["NombrePrograma"].ToString();
                oPrograma.Version = dr["Version"].ToString();
                oPrograma.NivelFormacion = dr["NivelFormacion"].ToString();
                oPrograma.Duracion = Convert.ToInt32(dr["Duracion"]);
                oPrograma.Estado = dr["Estado"].ToString();
            }
            oConexion.MtCerrarConexion();
            return oPrograma;
        }

        public void MtModificar(Programa oPrograma)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand(
                "UPDATE Programa SET CodigoPrograma=@CodigoPrograma, NombrePrograma=@NombrePrograma, " +
                "Version=@Version, NivelFormacion=@NivelFormacion, Duracion=@Duracion, Estado=@Estado " +
                "WHERE IdPrograma=@IdPrograma", cn);
            cmd.Parameters.AddWithValue("@IdPrograma", oPrograma.IdPrograma);
            cmd.Parameters.AddWithValue("@CodigoPrograma", oPrograma.CodigoPrograma);
            cmd.Parameters.AddWithValue("@NombrePrograma", oPrograma.NombrePrograma);
            cmd.Parameters.AddWithValue("@Version", oPrograma.Version);
            cmd.Parameters.AddWithValue("@NivelFormacion", oPrograma.NivelFormacion);
            cmd.Parameters.AddWithValue("@Duracion", oPrograma.Duracion);
            cmd.Parameters.AddWithValue("@Estado", oPrograma.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public void MtEliminar(int idPrograma)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM Programa WHERE IdPrograma=@IdPrograma", cn);
            cmd.Parameters.AddWithValue("@IdPrograma", idPrograma);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}