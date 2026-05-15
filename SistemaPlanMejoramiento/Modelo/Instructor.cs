using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Instructor
    {
        public int IdInstructor { get; set; }
        public string TipoDocumento { get; set; }
        public string NumeroDocumento { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Correo { get; set; }
        public string Telefono { get; set; }
        public string Especialidad { get; set; }
        public bool Estado { get; set; }

        // Propiedad calculada (no se guarda en BD)
        public string NombreCompleto
        {
            get { return Nombres + " " + Apellidos; }
        }
    }
}