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
        public string Estado { get; set; }

        public string NombreCompleto
        {
            get { return Nombres + " " + Apellidos; }
        }
    }
}