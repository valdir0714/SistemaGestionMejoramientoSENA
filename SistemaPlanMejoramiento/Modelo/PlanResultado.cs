namespace SistemaPlanMejoramiento.Modelo
{
    public class PlanResultado
    {
        public int IdPlanResultado { get; set; }
        public int IdPlan { get; set; }
        public int IdResultado { get; set; }

        public PlanMejoramiento PlanMejoramiento { get; set; }
        public ResultadoAprendizaje ResultadoAprendizaje { get; set; }
    }
}