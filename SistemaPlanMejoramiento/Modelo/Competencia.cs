using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Competencia
    {
        public int IdCompetencia { get; set; }
        public int IdPrograma { get; set; }
        public string CodigoCompetencia { get; set; }
        public string NombreCompetencia { get; set; }
        public string Descripcion { get; set; }

        // Propiedad de navegacion
        public Programa Programa { get; set; }
    }
}