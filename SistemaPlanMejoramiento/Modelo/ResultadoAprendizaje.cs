using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class ResultadoAprendizaje
    {
        public int IdResultado { get; set; }
        public int IdCompetencia { get; set; }
        public string CodigoResultado { get; set; }
        public string NombreResultado { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }

        // Propiedad de navegacion
        public Competencia Competencia { get; set; }
    }
}