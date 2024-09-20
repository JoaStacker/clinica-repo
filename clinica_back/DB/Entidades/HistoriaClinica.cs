using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Clinica.Dominio.Entidades
{
    public class HistoriaClinica: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("historia_clinica_id")]
        public int HistoriaClinicaID { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        // Navigation properties
        public virtual ICollection<Diagnostico> Diagnosticos { get; set; } = new HashSet<Diagnostico>();

    }
}
