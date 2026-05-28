using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace SistemaPlanMejoramiento
{
    public class ClCentroD
    {
        Conexion oConexion = new Conexion();

        public void MtInsertar(Centro oCentro)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("INSERT INTO Centro (CodigoCentro, NombreCentro, Ciudad, Departamento, Direccion, Telefono, Correo, Estado) VALUES (@CodigoCentro, @NombreCentro, @Ciudad, @Departamento, @Direccion, @Telefono, @Correo, @Estado)", cn);
            cmd.Parameters.AddWithValue("@CodigoCentro", oCentro.CodigoCentro);
            cmd.Parameters.AddWithValue("@NombreCentro", oCentro.NombreCentro);
            cmd.Parameters.AddWithValue("@Ciudad", oCentro.Ciudad);
            cmd.Parameters.AddWithValue("@Departamento", oCentro.Departamento);
            cmd.Parameters.AddWithValue("@Direccion", oCentro.Direccion);
            cmd.Parameters.AddWithValue("@Telefono", oCentro.Telefono);
            cmd.Parameters.AddWithValue("@Correo", oCentro.Correo);
            cmd.Parameters.AddWithValue("@Estado", oCentro.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public List<Centro> MtConsultar()
        {
            List<Centro> lista = new List<Centro>();
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Centro", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Centro oCentro = new Centro();
                oCentro.IdCentro = Convert.ToInt32(dr["IdCentro"]);
                oCentro.CodigoCentro = dr["CodigoCentro"].ToString();
                oCentro.NombreCentro = dr["NombreCentro"].ToString();
                oCentro.Ciudad = dr["Ciudad"].ToString();
                oCentro.Departamento = dr["Departamento"].ToString();
                oCentro.Direccion = dr["Direccion"].ToString();
                oCentro.Telefono = dr["Telefono"].ToString();
                oCentro.Correo = dr["Correo"].ToString();
                oCentro.Estado = Convert.ToBoolean(dr["Estado"]);
                lista.Add(oCentro);
            }
            oConexion.MtCerrarConexion();
            return lista;
        }

        public void MtModificar(Centro oCentro)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("UPDATE Centro SET CodigoCentro=@CodigoCentro, NombreCentro=@NombreCentro, Ciudad=@Ciudad, Departamento=@Departamento, Direccion=@Direccion, Telefono=@Telefono, Correo=@Correo, Estado=@Estado WHERE IdCentro=@IdCentro", cn);
            cmd.Parameters.AddWithValue("@IdCentro", oCentro.IdCentro);
            cmd.Parameters.AddWithValue("@CodigoCentro", oCentro.CodigoCentro);
            cmd.Parameters.AddWithValue("@NombreCentro", oCentro.NombreCentro);
            cmd.Parameters.AddWithValue("@Ciudad", oCentro.Ciudad);
            cmd.Parameters.AddWithValue("@Departamento", oCentro.Departamento);
            cmd.Parameters.AddWithValue("@Direccion", oCentro.Direccion);
            cmd.Parameters.AddWithValue("@Telefono", oCentro.Telefono);
            cmd.Parameters.AddWithValue("@Correo", oCentro.Correo);
            cmd.Parameters.AddWithValue("@Estado", oCentro.Estado);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }

        public void MtEliminar(int idCentro)
        {
            SqlConnection cn = oConexion.MtAbrirConexion();
            SqlCommand cmd = new SqlCommand("DELETE FROM Centro WHERE IdCentro=@IdCentro", cn);
            cmd.Parameters.AddWithValue("@IdCentro", idCentro);
            cmd.ExecuteNonQuery();
            oConexion.MtCerrarConexion();
        }
    }
}