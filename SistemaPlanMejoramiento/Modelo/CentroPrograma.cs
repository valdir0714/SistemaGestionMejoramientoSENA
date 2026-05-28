using System;

namespace SistemaPlanMejoramiento.Modelo
{
    public class CentroPrograma
    {
        public int IdCentroPrograma { get; set; }
        public int IdCentro { get; set; }
        public int IdPrograma { get; set; }
        public DateTime FechaAsignacion { get; set; }

        public Centro Centro { get; set; }
        public Programa Programa { get; set; }
    }
}