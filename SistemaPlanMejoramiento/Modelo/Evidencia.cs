using System;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Evidencia
    {
        public int IdEvidencia { get; set; }
        public int IdPlan { get; set; }
        public string NombreArchivo { get; set; }
        public string RutaArchivo { get; set; }
        public string TipoArchivo { get; set; }      
        public DateTime FechaSubida { get; set; }
        public string Observaciones { get; set; }

        public PlanMejoramiento PlanMejoramiento { get; set; }
    }
}