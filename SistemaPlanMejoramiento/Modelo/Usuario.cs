using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SistemaPlanMejoramiento.Modelo
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasena { get; set; }
        public string Rol { get; set; }               // "Administrador", "Instructor", "Aprendiz"
        public bool Activo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? UltimoAcceso { get; set; }

        // Claves foraneas opcionales segun el rol
        public int? IdInstructor { get; set; }
        public int? IdAprendiz { get; set; }

        // Propiedades de navegacion
        public Instructor Instructor { get; set; }
        public Aprendiz Aprendiz { get; set; }
    }
}