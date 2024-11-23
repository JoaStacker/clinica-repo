namespace Clinica.Dominio.Dtos
{
    public class EvolucionDto
    {
        public int MedicoId { get; set; }
        public int DiagnosticoId { get; set; }

        // Evolucion simple.
        public string Informe { get; set; }
        
        // Pedido de Laboratorio.
        public string? TextoPedido { get; set; } = null;
        
        // Receta Digital.
        public List<MedicamentoDto>? Medicamentos { get; set; } = null;  // Lista de codigos de los medicamentos.
        public string? Indicaciones { get; set; } = null; // Lista de indicaciones de los medicamentos.
    }
}
