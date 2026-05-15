using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public class ClPlanMejoramientoL
    {
        ClPlanMejoramientoD oDatos = new ClPlanMejoramientoD();
        ClAprendizD oDatosAprendiz = new ClAprendizD();

        public string MtInsertar(PlanMejoramiento oPlan)
        {
            string mensaje = "";
            try
            {
                if (oPlan.IdAprendiz <= 0)
                {
                    mensaje = "debe seleccionar un aprendiz";
                }
                else if (oPlan.IdInstructor <= 0)
                {
                    mensaje = "debe seleccionar un instructor";
                }
                else if (oPlan.Actividades == "" || oPlan.Actividades == null)
                {
                    mensaje = "las actividades son obligatorias";
                }
                else if (oPlan.FechaLimite <= DateTime.Now)
                {
                    mensaje = "la fecha limite debe ser mayor a la fecha actual";
                }
                else
                {
                    oPlan.FechaAsignacion = DateTime.Now;
                    oPlan.Estado = "Pendiente";
                    oDatos.MtInsertar(oPlan);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public List<PlanMejoramiento> MtConsultar()
        {
            List<PlanMejoramiento> lista = new List<PlanMejoramiento>();
            try
            {
                lista = oDatos.MtConsultar();
            }
            catch (Exception ex)
            {
            }
            return lista;
        }

        public string MtModificar(PlanMejoramiento oPlan)
        {
            string mensaje = "";
            try
            {
                if (oPlan.Actividades == "" || oPlan.Actividades == null)
                {
                    mensaje = "las actividades no pueden estar vacias";
                }
                else
                {
                    oDatos.MtModificar(oPlan);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public string MtEliminar(int idPlan)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idPlan);
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