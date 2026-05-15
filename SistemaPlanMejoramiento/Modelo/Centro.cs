using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Centro
    {
        public int IdCentro { get; set; }
        public string CodigoCentro { get; set; }
        public string NombreCentro { get; set; }
        public string Ciudad { get; set; }
        public string Departamento { get; set; }
        public string Direccion { get; set; }
        public string Telefono { get; set; }
        public string Correo { get; set; }
        public bool Estado { get; set; }
    }
}