using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Clinica.Api.Entities
{
    public class Direccion
    {
        [Key]
        public int DireccionId { get; set; }

        [Required]
        [Column("provincia", TypeName = "VARCHAR(100)")]
        public string Provincia { get; set; }

        [Required]
        [Column("localidad", TypeName = "VARCHAR(100)")]
        public string Localidad { get; set; }
        
        [Required]
        [Column("cop", TypeName = "VARCHAR(10)")]
        public string Cop { get; set; }

        [Required]
        [Column("calle", TypeName = "VARCHAR(100)")]
        public string Calle { get; set; }

        [Column("altura", TypeName = "VARCHAR(100)")]
        public string Altura { get; set; }

        [Column("piso", TypeName = "VARCHAR(100)")]
        public string Piso { get; set; }

        [Column("departamento", TypeName = "VARCHAR(100)")]
        public string Departamento { get; set; }

        public int PersonaId { get; set; }
    }
}
