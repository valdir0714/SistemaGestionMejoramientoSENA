using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClAprendizD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Aprendiz oAprendiz)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO Aprendiz (IdFicha, TipoDocumento, NumeroDocumento, Nombres, Apellidos, Correo, Telefono, Estado, FechaRegistro) VALUES (@IdFicha, @TipoDocumento, @NumeroDocumento, @Nombres, @Apellidos, @Correo, @Telefono, @Estado, @FechaRegistro)", cn);
            cmd.Parameters.AddWithValue("@IdFicha", oAprendiz.IdFicha);
            cmd.Parameters.AddWithValue("@TipoDocumento", oAprendiz.TipoDocumento);
            cmd.Parameters.AddWithValue("@NumeroDocumento", oAprendiz.NumeroDocumento);
            cmd.Parameters.AddWithValue("@Nombres", oAprendiz.Nombres);
            cmd.Parameters.AddWithValue("@Apellidos", oAprendiz.Apellidos);
            cmd.Parameters.AddWithValue("@Correo", oAprendiz.Correo);
            cmd.Parameters.AddWithValue("@Telefono", oAprendiz.Telefono);
            cmd.Parameters.AddWithValue("@Estado", oAprendiz.Estado);
            cmd.Parameters.AddWithValue("@FechaRegistro", oAprendiz.FechaRegistro);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<Aprendiz> MtConsultar()
        {
            List<Aprendiz> lista = new List<Aprendiz>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT a.*, f.CodigoFicha FROM Aprendiz a INNER JOIN Ficha f ON a.IdFicha = f.IdFicha", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Aprendiz oAprendiz = new Aprendiz();
                oAprendiz.IdAprendiz = Convert.ToInt32(dr["IdAprendiz"]);
                oAprendiz.IdFicha = Convert.ToInt32(dr["IdFicha"]);
                oAprendiz.TipoDocumento = dr["TipoDocumento"].ToString();
                oAprendiz.NumeroDocumento = dr["NumeroDocumento"].ToString();
                oAprendiz.Nombres = dr["Nombres"].ToString();
                oAprendiz.Apellidos = dr["Apellidos"].ToString();
                oAprendiz.Correo = dr["Correo"].ToString();
                oAprendiz.Telefono = dr["Telefono"].ToString();
                oAprendiz.Estado = dr["Estado"].ToString();
                oAprendiz.FechaRegistro = Convert.ToDateTime(dr["FechaRegistro"]);
                lista.Add(oAprendiz);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtModificar(Aprendiz oAprendiz)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("UPDATE Aprendiz SET IdFicha=@IdFicha, TipoDocumento=@TipoDocumento, NumeroDocumento=@NumeroDocumento, Nombres=@Nombres, Apellidos=@Apellidos, Correo=@Correo, Telefono=@Telefono, Estado=@Estado WHERE IdAprendiz=@IdAprendiz", cn);
            cmd.Parameters.AddWithValue("@IdAprendiz", oAprendiz.IdAprendiz);
            cmd.Parameters.AddWithValue("@IdFicha", oAprendiz.IdFicha);
            cmd.Parameters.AddWithValue("@TipoDocumento", oAprendiz.TipoDocumento);
            cmd.Parameters.AddWithValue("@NumeroDocumento", oAprendiz.NumeroDocumento);
            cmd.Parameters.AddWithValue("@Nombres", oAprendiz.Nombres);
            cmd.Parameters.AddWithValue("@Apellidos", oAprendiz.Apellidos);
            cmd.Parameters.AddWithValue("@Correo", oAprendiz.Correo);
            cmd.Parameters.AddWithValue("@Telefono", oAprendiz.Telefono);
            cmd.Parameters.AddWithValue("@Estado", oAprendiz.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public void MtEliminar(int idAprendiz)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM Aprendiz WHERE IdAprendiz=@IdAprendiz", cn);
            cmd.Parameters.AddWithValue("@IdAprendiz", idAprendiz);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public void MtCambiarEstado(int idAprendiz, string nuevoEstado)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("UPDATE Aprendiz SET Estado=@Estado WHERE IdAprendiz=@IdAprendiz", cn);
            cmd.Parameters.AddWithValue("@IdAprendiz", idAprendiz);
            cmd.Parameters.AddWithValue("@Estado", nuevoEstado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}