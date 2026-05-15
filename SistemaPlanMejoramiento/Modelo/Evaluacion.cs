using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Evaluacion
    {
        public int IdEvaluacion { get; set; }
        public int IdPlan { get; set; }
        public string Producto { get; set; }          // "Aprueba" o "No Aprueba"
        public string Conocimiento { get; set; }      // "Aprueba" o "No Aprueba"
        public string Desempeno { get; set; }         // "Aprueba" o "No Aprueba"
        public string Observaciones { get; set; }
        public DateTime FechaEvaluacion { get; set; }
        public string ResultadoFinal { get; set; }    // "Aprobado" o "No Aprobado"

        // Propiedad de navegacion
        public PlanMejoramiento PlanMejoramiento { get; set; }

        // Metodo auxiliar: determina si aprobo todos los criterios
        public bool AproboTodo()
        {
            return Producto == "Aprueba"
                && Conocimiento == "Aprueba"
                && Desempeno == "Aprueba";
        }
    }
}