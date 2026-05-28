using System;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasena { get; set; }
        public string Rol { get; set; }
        public bool Activo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? UltimoAcceso { get; set; }


        public int? IdInstructor { get; set; }
        public int? IdAprendiz { get; set; }


        public Instructor Instructor { get; set; }
        public Aprendiz Aprendiz { get; set; }
    }
}