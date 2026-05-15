using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Ficha
    {
        public int IdFicha { get; set; }
        public int IdPrograma { get; set; }
        public string CodigoFicha { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFinalizacion { get; set; }
        public string Jornada { get; set; }
        public string Descripcion { get; set; }
        public string Estado { get; set; }

        // Propiedad de navegacion
        public Programa Programa { get; set; }
    }
}