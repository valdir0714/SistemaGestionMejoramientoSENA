using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Evidencia
    {
        public int IdEvidencia { get; set; }
        public int IdPlan { get; set; }
        public string NombreArchivo { get; set; }
        public string RutaArchivo { get; set; }
        public string TipoArchivo { get; set; }       // pdf, docx, jpg, png, zip
        public DateTime FechaSubida { get; set; }
        public string Observaciones { get; set; }

        // Propiedad de navegacion
        public PlanMejoramiento PlanMejoramiento { get; set; }
    }
}