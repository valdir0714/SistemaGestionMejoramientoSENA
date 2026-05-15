using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public class ClUsuarioL
    {
        ClUsuarioD oDatos = new ClUsuarioD();

        public string MtInsertar(Usuario oUsuario)
        {
            string mensaje = "";
            try
            {
                if (oUsuario.NombreUsuario == "" || oUsuario.NombreUsuario == null)
                {
                    mensaje = "el nombre de usuario es obligatorio";
                }
                else if (oUsuario.Contrasena == "" || oUsuario.Contrasena == null)
                {
                    mensaje = "la contrasena es obligatoria";
                }
                else if (oUsuario.Contrasena.Length < 6)
                {
                    mensaje = "la contrasena debe tener minimo 6 caracteres";
                }
                else if (oUsuario.Rol == "" || oUsuario.Rol == null)
                {
                    mensaje = "debe seleccionar un rol";
                }
                else
                {
                    oUsuario.Activo = true;
                    oUsuario.FechaCreacion = DateTime.Now;
                    oDatos.MtInsertar(oUsuario);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public Usuario MtLogin(string nombreUsuario, string contrasena)
        {
            Usuario oUsuario = null;
            try
            {
                if (nombreUsuario == "" || nombreUsuario == null || contrasena == "" || contrasena == null)
                {
                    return null;
                }
                oUsuario = oDatos.MtLogin(nombreUsuario, contrasena);
            }
            catch (Exception ex)
            {
            }
            return oUsuario;
        }

        public List<Usuario> MtConsultar()
        {
            List<Usuario> lista = new List<Usuario>();
            try
            {
                lista = oDatos.MtConsultar();
            }
            catch (Exception ex)
            {
            }
            return lista;
        }

        public string MtEliminar(int idUsuario)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idUsuario);
                mensaje = "ok";
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }
    }
}