using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClUsuarioD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Usuario oUsuario)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO Usuario (NombreUsuario, Contrasena, Rol, Activo, FechaCreacion, IdInstructor, IdAprendiz) VALUES (@NombreUsuario, @Contrasena, @Rol, @Activo, @FechaCreacion, @IdInstructor, @IdAprendiz)", cn);
            cmd.Parameters.AddWithValue("@NombreUsuario", oUsuario.NombreUsuario);
            cmd.Parameters.AddWithValue("@Contrasena", oUsuario.Contrasena);
            cmd.Parameters.AddWithValue("@Rol", oUsuario.Rol);
            cmd.Parameters.AddWithValue("@Activo", oUsuario.Activo);
            cmd.Parameters.AddWithValue("@FechaCreacion", oUsuario.FechaCreacion);
            cmd.Parameters.AddWithValue("@IdInstructor", (object)oUsuario.IdInstructor ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@IdAprendiz", (object)oUsuario.IdAprendiz ?? DBNull.Value);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public Usuario MtLogin(string nombreUsuario, string contrasena)
        {
            Usuario oUsuario = null;
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Usuario WHERE NombreUsuario=@NombreUsuario AND Contrasena=@Contrasena AND Activo=1", cn);
            cmd.Parameters.AddWithValue("@NombreUsuario", nombreUsuario);
            cmd.Parameters.AddWithValue("@Contrasena", contrasena);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                oUsuario = new Usuario();
                oUsuario.IdUsuario = Convert.ToInt32(dr["IdUsuario"]);
                oUsuario.NombreUsuario = dr["NombreUsuario"].ToString();
                oUsuario.Rol = dr["Rol"].ToString();
                oUsuario.Activo = Convert.ToBoolean(dr["Activo"]);
                oUsuario.IdInstructor = dr["IdInstructor"] == DBNull.Value ? (int?)null : Convert.ToInt32(dr["IdInstructor"]);
                oUsuario.IdAprendiz = dr["IdAprendiz"] == DBNull.Value ? (int?)null : Convert.ToInt32(dr["IdAprendiz"]);
            }
            oConexion.MtCerrarConexion();
            return oUsuario;
        }

        public List<Usuario> MtConsultar()
        {
            List<Usuario> lista = new List<Usuario>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Usuario", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Usuario oUsuario = new Usuario();
                oUsuario.IdUsuario = Convert.ToInt32(dr["IdUsuario"]);
                oUsuario.NombreUsuario = dr["NombreUsuario"].ToString();
                oUsuario.Rol = dr["Rol"].ToString();
                oUsuario.Activo = Convert.ToBoolean(dr["Activo"]);
                lista.Add(oUsuario);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtEliminar(int idUsuario)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM Usuario WHERE IdUsuario=@IdUsuario", cn);
            cmd.Parameters.AddWithValue("@IdUsuario", idUsuario);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}