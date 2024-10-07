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
        public virtual ICollection<EvolucionClinica> EvolucionesClinicas { get; set; } = new HashSet<EvolucionClinica>();

        public Diagnostico() { }
        public Diagnostico(DiagnosticoDto diagnosticoDto, HistoriaClinica historiaClinica)
        {
            Enfermedad = diagnosticoDto.Enfermedad;
            Observaciones = diagnosticoDto.Observaciones;
            FechaDeCreacion = diagnosticoDto.FechaDeCreacion;
            HistoriaClinica = historiaClinica;
        }
    }
}
