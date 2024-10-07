using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Clinica.Dominio.Dtos;

namespace Clinica.Dominio.Entidades
{
    public class Persona: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("persona_id")]
        public int PersonaID { get; set; }  // Made private to prevent external modification

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

        public Persona() { }
        public Persona(PersonaDto personaDto)
        {
            Cuil = personaDto.Cuil;
            Dni = personaDto.Dni;
            Email = personaDto.Email;
            Telefono = personaDto.Telefono;
            NombreApellido = personaDto.NombreApellido;

            Direccion nuevaDireccion = new Direccion
            {
                Provincia = personaDto.Provincia,
                Localidad = personaDto.Localidad,
                Cop = personaDto.Cop,
                Calle = personaDto.Calle,
                Altura = personaDto.Altura,
                Piso = personaDto.Piso,
                Departamento = personaDto.Departamento
            };

            Direccion = nuevaDireccion;
        }
    }
}
