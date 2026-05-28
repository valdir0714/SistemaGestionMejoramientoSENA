using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClInstructorD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Instructor oInstructor)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO Instructor (IdCentro, TipoDocumento, NumeroDocumento, Nombres, Apellidos, Correo, Telefono, Especialidad, Estado) VALUES (@IdCentro, @TipoDocumento, @NumeroDocumento, @Nombres, @Apellidos, @Correo, @Telefono, @Especialidad, @Estado)", cn);
            cmd.Parameters.AddWithValue("@IdCentro", 1);
            cmd.Parameters.AddWithValue("@TipoDocumento", oInstructor.TipoDocumento);
            cmd.Parameters.AddWithValue("@NumeroDocumento", oInstructor.NumeroDocumento);
            cmd.Parameters.AddWithValue("@Nombres", oInstructor.Nombres);
            cmd.Parameters.AddWithValue("@Apellidos", oInstructor.Apellidos);
            cmd.Parameters.AddWithValue("@Correo", oInstructor.Correo);
            cmd.Parameters.AddWithValue("@Telefono", oInstructor.Telefono);
            cmd.Parameters.AddWithValue("@Especialidad", oInstructor.Especialidad);
            cmd.Parameters.AddWithValue("@Estado", oInstructor.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<Instructor> MtConsultar()
        {
            List<Instructor> lista = new List<Instructor>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Instructor", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Instructor oInstructor = new Instructor();
                oInstructor.IdInstructor = Convert.ToInt32(dr["IdInstructor"]);
                oInstructor.TipoDocumento = dr["TipoDocumento"].ToString();
                oInstructor.NumeroDocumento = dr["NumeroDocumento"].ToString();
                oInstructor.Nombres = dr["Nombres"].ToString();
                oInstructor.Apellidos = dr["Apellidos"].ToString();
                oInstructor.Correo = dr["Correo"].ToString();
                oInstructor.Telefono = dr["Telefono"].ToString();
                oInstructor.Especialidad = dr["Especialidad"].ToString();
                oInstructor.Estado = dr["Estado"].ToString();
                lista.Add(oInstructor);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtModificar(Instructor oInstructor)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("UPDATE Instructor SET TipoDocumento=@TipoDocumento, NumeroDocumento=@NumeroDocumento, Nombres=@Nombres, Apellidos=@Apellidos, Correo=@Correo, Telefono=@Telefono, Especialidad=@Especialidad, Estado=@Estado WHERE IdInstructor=@IdInstructor", cn);
            cmd.Parameters.AddWithValue("@IdInstructor", oInstructor.IdInstructor);
            cmd.Parameters.AddWithValue("@TipoDocumento", oInstructor.TipoDocumento);
            cmd.Parameters.AddWithValue("@NumeroDocumento", oInstructor.NumeroDocumento);
            cmd.Parameters.AddWithValue("@Nombres", oInstructor.Nombres);
            cmd.Parameters.AddWithValue("@Apellidos", oInstructor.Apellidos);
            cmd.Parameters.AddWithValue("@Correo", oInstructor.Correo);
            cmd.Parameters.AddWithValue("@Telefono", oInstructor.Telefono);
            cmd.Parameters.AddWithValue("@Especialidad", oInstructor.Especialidad);
            cmd.Parameters.AddWithValue("@Estado", oInstructor.Estado);
            cmd.ExecuteNonQuery();  
            oConexion.MtCerrarConexion();
        }

        public void MtEliminar(int idInstructor)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM Instructor WHERE IdInstructor=@IdInstructor", cn);
            cmd.Parameters.AddWithValue("@IdInstructor", idInstructor);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}