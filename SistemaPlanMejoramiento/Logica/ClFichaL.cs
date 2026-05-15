using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public class ClFichaL
    {
        ClFichaDatos oDatos = new ClFichaDatos();

        public string MtInsertar(Ficha oFicha)
        {
            string mensaje = "";
            try
            {
                if (oFicha.CodigoFicha == "" || oFicha.CodigoFicha == null)
                {
                    mensaje = "el codigo de la ficha es obligatorio";
                }
                else if (oFicha.IdPrograma <= 0)
                {
                    mensaje = "debe seleccionar un programa";
                }
                else if (oFicha.FechaInicio >= oFicha.FechaFinalizacion)
                {
                    mensaje = "la fecha de inicio debe ser menor a la fecha de finalizacion";
                }
                else
                {
                    oDatos.MtInsertar(oFicha);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public List<Ficha> MtConsultar()
        {
            List<Ficha> lista = new List<Ficha>();
            try
            {
                lista = oDatos.MtConsultar();
            }
            catch (Exception ex)
            {
              
            }
            return lista;
        }

        public string MtModificar(Ficha oFicha)
        {
            string mensaje = "";
            try
            {
                if (oFicha.CodigoFicha == "" || oFicha.CodigoFicha == null)
                {
                    mensaje = "el codigo de la ficha no puede estar vacio";
                }
                else if (oFicha.FechaInicio >= oFicha.FechaFinalizacion)
                {
                    mensaje = "la fecha de inicio debe ser menor a la fecha de finalizacion";
                }
                else
                {
                    oDatos.MtModificar(oFicha);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public string MtEliminar(int idFicha)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idFicha);
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