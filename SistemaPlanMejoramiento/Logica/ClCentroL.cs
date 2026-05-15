using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public class ClCentroL
    {
        ClCentroD oDatos = new ClCentroD();

        public string MtInsertar(Centro oCentro)
        {
            string mensaje = "";
            try
            {
                if (oCentro.CodigoCentro == "" || oCentro.CodigoCentro == null)
                {
                    mensaje = "el codigo del centro es obligatorio";
                }
                else if (oCentro.NombreCentro == "" || oCentro.NombreCentro == null)
                {
                    mensaje = "el nombre del centro es obligatorio";
                }
                else if (oCentro.Ciudad == "" || oCentro.Ciudad == null)
                {
                    mensaje = "la ciudad es obligatoria";
                }
                else
                {
                    oDatos.MtInsertar(oCentro);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public List<Centro> MtConsultar()
        {
            List<Centro> lista = new List<Centro>();
            try
            {
                lista = oDatos.MtConsultar();
            }
            catch (Exception ex)
            {
            }
            return lista;
        }

        public string MtModificar(Centro oCentro)
        {
            string mensaje = "";
            try
            {
                if (oCentro.NombreCentro == "" || oCentro.NombreCentro == null)
                {
                    mensaje = "el nombre no puede estar vacio";
                }
                else
                {
                    oDatos.MtModificar(oCentro);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public string MtEliminar(int idCentro)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idCentro);
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