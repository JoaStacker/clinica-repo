using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Clinica.Dominio.Entidades
{
    public class PedidoLaboratorio
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("pedido_laboratorio_id")]
        public int PedidoLaboratorioID { get; set; }

        [Column("texto_libre")]
        public string TextoLibre { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [ForeignKey("EvolucionClinica")]
        [Column("evolucion_clinica_id")]
        public int EvolucionClinicaID { get; set; }

        // Navigation properties
        public virtual EvolucionClinica EvolucionClinica { get; set; }
    }
}