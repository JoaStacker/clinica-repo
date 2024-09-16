using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Dominio.Entidades
{
    public class Persona
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("persona_id")]
        public int PersonaID { get; set; }

        [Column("cuil")]
        public string Cuil { get; set; }

        [Column("dni")]
        public string Dni { get; set; }

        [Column("fecha_nacimiento")]
        public DateTime FechaDeNacimiento { get; set; }

        [Column("email")]
        public string Email { get; set; }

        [Column("telefono")]
        public string Telefono { get; set; }

        [Column("nombre_apellido")]
        public string NombreApellido { get; set; }

        [ForeignKey("Direccion")]
        [Column("direccion_id")]
        public int DireccionID { get; set; }

        // Navigation property
        public virtual Direccion Direccion { get; set; }
    }
}
