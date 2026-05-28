using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public class ClInstructorFichaL
    {
        ClInstructorFichaD oDatos = new ClInstructorFichaD();

        public string MtInsertar(InstructorFicha oIF)
        {
            string mensaje = "";
            try
            {
                if (oIF.IdInstructor <= 0)
                    mensaje = "debe seleccionar un instructor";
                else if (oIF.IdFicha <= 0)
                    mensaje = "debe seleccionar una ficha";
                else if (oDatos.MtExiste(oIF.IdInstructor, oIF.IdFicha))
                    mensaje = "ese instructor ya está asignado a esa ficha";
                else
                {
                    oIF.FechaAsignacion = DateTime.Now;
                    oDatos.MtInsertar(oIF);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public List<InstructorFicha> MtConsultar()
        {
            List<InstructorFicha> lista = new List<InstructorFicha>();
            try
            {
                lista = oDatos.MtConsultar();
            }
            catch (Exception ex)
            {
            }
            return lista;
        }

        public string MtEliminar(int idInstructor, int idFicha)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idInstructor, idFicha);
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