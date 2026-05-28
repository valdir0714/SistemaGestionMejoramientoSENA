using System;

namespace SistemaPlanMejoramiento.Modelo
{
    public class InstructorFicha
    {
        public int IdInstructorFicha { get; set; }
        public int IdInstructor { get; set; }
        public int IdFicha { get; set; }
        public DateTime FechaAsignacion { get; set; }

        public string NombreInstructor { get; set; }
        public string CodigoFicha { get; set; }

        public Instructor Instructor { get; set; }
        public Ficha Ficha { get; set; }
    }
}