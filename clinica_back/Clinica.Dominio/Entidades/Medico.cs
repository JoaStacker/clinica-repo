using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Clinica.Dominio.Entidades
{
    public class Medico : EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("medico_id")]
        public int MedicoID { get; set; }

        [Column("matricula")]
        public int Matricula { get; set; }

        [Column("especialidad")]
        [MaxLength(100)]
        public string Especialidad { get; set; }

        [ForeignKey("Persona")]
        [Column("persona_id")]
        public int PersonaID { get; set; }

        // Navigation properties
        public virtual Persona Persona { get; set; }
    }
}
