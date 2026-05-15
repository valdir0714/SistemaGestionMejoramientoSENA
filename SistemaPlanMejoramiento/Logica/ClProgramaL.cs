using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public class ClProgramaL
    {
        ClProgramaDatos oDatos = new ClProgramaDatos();

        public string MtInsertar(Programa oPrograma)
        {
            string mensaje = "";
            try
            {
                if (string.IsNullOrEmpty(oPrograma.CodigoPrograma))
                    mensaje = "el codigo del programa es obligatorio";
                else if (string.IsNullOrEmpty(oPrograma.NombrePrograma))
                    mensaje = "el nombre del programa es obligatorio";
                else if (oPrograma.Duracion <= 0)
                    mensaje = "la duracion debe ser mayor a 0";
                else
                {
                    oDatos.MtInsertar(oPrograma);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public List<Programa> MtConsultar(string filtro = "")
        {
            List<Programa> lista = new List<Programa>();
            try
            {
                lista = oDatos.MtConsultar(filtro);
            }
            catch (Exception ex)
            {
                // log si es necesario
            }
            return lista;
        }

        public Programa MtObtenerPorId(int idPrograma)
        {
            try
            {
                return oDatos.MtObtenerPorId(idPrograma);
            }
            catch
            {
                return null;
            }
        }

        public string MtModificar(Programa oPrograma)
        {
            string mensaje = "";
            try
            {
                if (string.IsNullOrEmpty(oPrograma.NombrePrograma))
                    mensaje = "el nombre no puede estar vacio";
                else if (oPrograma.Duracion <= 0)
                    mensaje = "la duracion debe ser mayor a 0";
                else
                {
                    oDatos.MtModificar(oPrograma);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public string MtEliminar(int idPrograma)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idPrograma);
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