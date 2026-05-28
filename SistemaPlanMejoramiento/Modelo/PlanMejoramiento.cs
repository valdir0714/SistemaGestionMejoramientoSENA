using System;

namespace SistemaPlanMejoramiento.Modelo
{
    public class PlanMejoramiento
    {
        public int IdPlan { get; set; }
        public int IdAprendiz { get; set; }
        public int IdInstructor { get; set; }
        public string TipoPlan { get; set; }          
        public string Actividades { get; set; }
        public string Observaciones { get; set; }
        public DateTime FechaAsignacion { get; set; }
        public DateTime FechaLimite { get; set; }
        public string Estado { get; set; }          

        public Aprendiz Aprendiz { get; set; }
        public Instructor Instructor { get; set; }
        public Ficha Ficha { get; set; }
        public string NombreAprendiz { get; set; }
        public string NombreInstructor { get; set; }
        public string ArchivoPlan { get; set; }

    }
}