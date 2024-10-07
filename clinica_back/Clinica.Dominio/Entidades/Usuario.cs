using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clinica.Dominio.Entidades
{
    public class Usuario : EntidadBase
    {
        [Key]
        public int Id { get; set; }

        [Column("clave")]
        public string Clave { get; set; }

        [Column("email")]
        public string Email { get; set; }

        // Clave foránea a Persona
        [ForeignKey("Persona")]
        [Column("persona_id")]
        public int PersonaID { get; set; }

        // Propiedad de navegación
        public virtual Persona Persona { get; set; }
    }
}
