using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Dominio.Entidades
{
    public class Diagnostico
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("diagnostico_id")]
        public int DiagnosticoID { get; set; }

        [Column("enfermedad")]
        public string Enfermedad { get; set; }

        [Column("observaciones")]
        public string Observaciones { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [ForeignKey("HistoriaClinica")]
        [Column("historia_clinica_id")]
        public int HistoriaClinicaID { get; set; }

        // Navigation properties
        public virtual HistoriaClinica HistoriaClinica { get; set; }
        public virtual ICollection<EvolucionClinica> EvolucionesClinicas { get; set; } = new HashSet<EvolucionClinica>();

    }
}
