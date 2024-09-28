using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Clinica.Dominio.Enumeraciones;

namespace Clinica.Dominio.Entidades
{
    public class RecetaDigital: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("receta_digital_id")]
        public int RecetaDigitalID { get; set; }

        [Column("codigo_barras")]
        public int CodigoBarras { get; set; }

        [Column("codigo_qr")]
        public string CodigoQR { get; set; }

        [Column("dosis")]
        public string Dosis{ get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [Column("estado")]
        public EstadoReceta Estado { get; set; }

        [ForeignKey("Medico")]
        [Column("medico_id")]
        public int MedicoID { get; set; }

        [ForeignKey("EvolucionClinica")]
        [Column("evolucion_clinica_id")]
        public int EvolucionClinicaID { get; set; }

        // Navigation properties
        public virtual Medico Medico { get; set; }
        public virtual EvolucionClinica EvolucionClinica { get; set; }
        public virtual ICollection<Medicamento> Medicamentos { get; set; } = new List<Medicamento>();
    }
}