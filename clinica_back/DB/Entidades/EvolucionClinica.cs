using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Clinica.Dominio.Entidades
{
    public class EvolucionClinica: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("evolucion_clinica_id")]
        public int EvolucionClinicaID { get; set; }

        [Column("texto_libre")]
        public string TextoLibre { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [ForeignKey("Diagnostico")]
        [Column("diagnostico_id")]
        public int DiagnosticoID { get; set; }

        // Navigation properties
        public virtual Diagnostico Diagnostico { get; set; }
    }
}
