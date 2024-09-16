using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio.Entidades
{
    public class EvolucionClinica
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("evolucion_clinica_id")]
        public int EvolucionClinicaID { get; set; }

        [Column("texto_libre")]
        public string TextoLibre { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [ForeignKey("Medico")]
        [Column("medico_id")]
        public int MedicoID { get; set; }

        [ForeignKey("Diagnostico")]
        [Column("diagnostico_id")]
        public int DiagnosticoID { get; set; }

        // Navigation properties
        public virtual Medico Medico { get; set; }
        public virtual Diagnostico Diagnostico { get; set; }
    }
}
