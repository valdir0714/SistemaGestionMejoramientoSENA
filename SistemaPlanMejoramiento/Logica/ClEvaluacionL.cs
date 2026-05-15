using SistemaPlanMejoramiento.Modelo;
using System;

namespace SistemaPlanMejoramiento
{
    public class ClEvaluacionL
    {
        ClEvaluacionD oDatos = new ClEvaluacionD();
        ClPlanMejoramientoD oDatosPlan = new ClPlanMejoramientoD();
        ClAprendizD oDatosAprendiz = new ClAprendizD();

        public string MtEvaluar(Evaluacion oEvaluacion, int idAprendiz, string tipoPlan)
        {
            string mensaje = "";
            try
            {
                if (oEvaluacion.Producto == "" || oEvaluacion.Producto == null)
                {
                    mensaje = "debe evaluar el producto";
                }
                else if (oEvaluacion.Conocimiento == "" || oEvaluacion.Conocimiento == null)
                {
                    mensaje = "debe evaluar el conocimiento";
                }
                else if (oEvaluacion.Desempeno == "" || oEvaluacion.Desempeno == null)
                {
                    mensaje = "debe evaluar el desempeno";
                }
                else
                {
                    oEvaluacion.FechaEvaluacion = DateTime.Now;

                    if (oEvaluacion.Producto == "Aprueba" && oEvaluacion.Conocimiento == "Aprueba" && oEvaluacion.Desempeno == "Aprueba")
                    {
                        oEvaluacion.ResultadoFinal = "Aprobado";
                        oDatos.MtInsertar(oEvaluacion);
                        mensaje = "ok";
                    }
                    else
                    {
                        oEvaluacion.ResultadoFinal = "No Aprobado";
                        oDatos.MtInsertar(oEvaluacion);

                        if (tipoPlan == "Interno")
                        {
                            PlanMejoramiento oPlanComite = new PlanMejoramiento();
                            oPlanComite.IdAprendiz = idAprendiz;
                            oPlanComite.IdInstructor = oEvaluacion.IdPlan;
                            oPlanComite.TipoPlan = "Comite";
                            oPlanComite.Actividades = "Plan generado automaticamente por no aprobar plan interno";
                            oPlanComite.FechaAsignacion = DateTime.Now;
                            oPlanComite.FechaLimite = DateTime.Now.AddDays(15);
                            oPlanComite.Estado = "Pendiente";
                            oDatosPlan.MtInsertar(oPlanComite);
                            mensaje = "ok-comite";
                        }
                        else if (tipoPlan == "Comite")
                        {
                            oDatosAprendiz.MtCambiarEstado(idAprendiz, "Cancelado");
                            mensaje = "ok-cancelado";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }
    }
}