using System;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Evaluacion
    {
        public int IdEvaluacion { get; set; }
        public int IdPlan { get; set; }
        public int IdInstructor { get; set; }  
        public string Producto { get; set; }          
        public string Conocimiento { get; set; }      
        public string Desempeno { get; set; }         
        public string Observaciones { get; set; }
        public DateTime FechaEvaluacion { get; set; }

       
        public string ResultadoFinal
        {
            get
            {
                return AproboTodo() ? "Aprobado" : "No Aprobado";
            }
        }

        
        public PlanMejoramiento PlanMejoramiento { get; set; }

      
        public bool AproboTodo()
        {
            return Producto == "Aprueba"
                && Conocimiento == "Aprueba"
                && Desempeno == "Aprueba";
        }
    }
}