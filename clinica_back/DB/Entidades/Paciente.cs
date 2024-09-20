using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Clinica.Dominio.Enumeraciones;

namespace Clinica.Dominio.Entidades
{
    public class Paciente : EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("paciente_id")]
        public int PacienteID { get; set; }

        [Column("nro_afiliado")]
        public int NroAfiliado { get; set; }

        [Column("pasaporte")]
        public string Pasaporte { get; set; }

        [Column("fecha_defuncion")]
        public DateTime? FechaDefuncion { get; set; }

        [Column("estado")]
        public EstadoPaciente Estado { get; set; }

        [ForeignKey("Persona")]
        [Column("persona_id")]
        public int PersonaID { get; set; }

        // Navigation properties
        public virtual Persona Persona { get; set; }
    }
}
