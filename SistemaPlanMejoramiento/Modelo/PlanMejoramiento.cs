using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class PlanMejoramiento
    {
        public int IdPlan { get; set; }
        public int IdAprendiz { get; set; }
        public int IdInstructor { get; set; }
        public int IdFicha { get; set; }
        public string TipoPlan { get; set; }          // "Interno" o "Comite"
        public string Actividades { get; set; }
        public string Observaciones { get; set; }
        public DateTime FechaAsignacion { get; set; }
        public DateTime FechaLimite { get; set; }
        public string Estado { get; set; }            // "Pendiente", "Aprobado", "No Aprobado"

        // Propiedades de navegacion
        public Aprendiz Aprendiz { get; set; }
        public Instructor Instructor { get; set; }
        public Ficha Ficha { get; set; }
    }
}