using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Clinica.Api.Entities
{
    public class Persona
    {

        [Column("persona_id")]
        [Key]
        public int Id { get; set; }

        [Required]
        [Column("cuil", TypeName = "VARCHAR(100)")]
        public string Cuil { get; set; }

        [Required]
        [Column("dni", TypeName = "VARCHAR(100)")]
        public string Dni { get; set; }

        [Required]
        [Column("fecha_nacimiento", TypeName = "VARCHAR(100)")]
        public string FechaDeNacimiento { get; set; }

        [Required]
        [Column("email", TypeName = "VARCHAR(100)")]
        public string Email { get; set; }

        [Required]
        [Column("telefono", TypeName = "VARCHAR(100)")]
        public string Telefono { get; set; }

        [Required]
        [Column("nombre_apellido", TypeName = "VARCHAR(100)")]
        public string NombreApellido { get; set; }        

    }
}
