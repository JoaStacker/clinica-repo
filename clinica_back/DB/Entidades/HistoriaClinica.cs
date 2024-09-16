using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dominio.Entidades
{
    public class HistoriaClinica
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
