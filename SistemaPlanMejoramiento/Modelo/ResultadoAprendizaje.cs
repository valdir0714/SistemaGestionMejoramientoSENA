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

        public Competencia Competencia { get; set; }
    }
}