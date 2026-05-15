using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class CentroPrograma
    {
        public int IdCentroPrograma { get; set; }
        public int IdCentro { get; set; }
        public int IdPrograma { get; set; }
        public DateTime FechaAsignacion { get; set; }

        // Propiedades de navegacion
        public Centro Centro { get; set; }
        public Programa Programa { get; set; }
    }
}