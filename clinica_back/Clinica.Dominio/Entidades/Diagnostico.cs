using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Clinica.Dominio.Dtos;
using System.Text.Json.Serialization;

namespace Clinica.Dominio.Entidades
{
    public class Diagnostico: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("diagnostico_id")]
        public int DiagnosticoID { get; set; }

        [Column("enfermedad")]
        [MaxLength(100)]
        public string Enfermedad { get; set; }

        [Column("observaciones")]
        [MaxLength(500)]
        public string Observaciones { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [ForeignKey("HistoriaClinica")]
        [Column("historia_clinica_id")]
        public int HistoriaClinicaID { get; set; }

        // Navigation properties
        [JsonIgnore] // Prevent circular reference
        public virtual HistoriaClinica HistoriaClinica { get; set; }

        [JsonIgnore] // Prevent circular reference
        public virtual ICollection<EvolucionClinica> EvolucionesClinicas { get; set; } = new HashSet<EvolucionClinica>();

        public Diagnostico() { }
        public Diagnostico(string enfermedad, string observaciones)
        {
            Enfermedad = enfermedad;
            Observaciones = observaciones;
            FechaDeCreacion = DateTime.Now;
        }

        public void agregarEvolucion(EvolucionDto evolucionDto, Medico medico)
        {
            EvolucionClinica evolucion = new EvolucionClinica(evolucionDto.Informe, medico);
            
            // Con Pedido de Laboratorio.
            if (!string.IsNullOrEmpty(evolucionDto.TextoPedido))
            {
                evolucion.ConPedidoLaboratorio(evolucionDto.TextoPedido);
            }
            
            // Con Receta Digital.
            if (evolucionDto.Medicamentos != null && 
                evolucionDto.Medicamentos.Count > 0 && 
                !string.IsNullOrEmpty(evolucionDto.Indicaciones))
            {
                evolucion.ConRecetaDigital(evolucionDto.Medicamentos, evolucionDto.Indicaciones);
            }
            
            EvolucionesClinicas.Add(evolucion);
        }
    }
}
