using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class InstructorFicha
    {
        public int IdInstructorFicha { get; set; }
        public int IdInstructor { get; set; }
        public int IdFicha { get; set; }
        public DateTime FechaAsignacion { get; set; }

        // Propiedades de navegacion
        public Instructor Instructor { get; set; }
        public Ficha Ficha { get; set; }
    }
}