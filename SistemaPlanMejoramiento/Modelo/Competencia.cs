namespace SistemaPlanMejoramiento.Modelo
{
    public class Competencia
    {
        public int IdCompetencia { get; set; }
        public int IdPrograma { get; set; }
        public string CodigoCompetencia { get; set; }
        public string NombreCompetencia { get; set; }
        public string Descripcion { get; set; }

        public Programa Programa { get; set; }
    }
}