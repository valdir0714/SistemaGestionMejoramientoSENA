using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class PlanResultado
    {
        public int IdPlanResultado { get; set; }
        public int IdPlan { get; set; }
        public int IdResultado { get; set; }

        // Propiedades de navegacion
        public PlanMejoramiento PlanMejoramiento { get; set; }
        public ResultadoAprendizaje ResultadoAprendizaje { get; set; }
    }
}