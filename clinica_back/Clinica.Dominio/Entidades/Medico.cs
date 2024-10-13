using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Clinica.Dominio.Dtos;

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

        public Medico() { }
        public Medico(MedicoDto medicoDto)
        {
            Matricula = medicoDto.Matricula;
            Especialidad = medicoDto.Especialidad;

            PersonaDto personaDto = new PersonaDto
            {
                Cuil = medicoDto.Cuil,
                Dni = medicoDto.Dni,
                FechaNacimiento = medicoDto.FechaNacimiento,
                Email = medicoDto.Email,
                Telefono = medicoDto.Telefono,
                NombreApellido = medicoDto.NombreApellido,
                Provincia = medicoDto.Provincia,
                Localidad = medicoDto.Localidad,
                Cop = medicoDto.Cop,
                Calle = medicoDto.Calle,
                Altura = medicoDto.Altura,
                Piso = medicoDto.Piso,
                Departamento = medicoDto.Departamento
            };

            Persona nuevaPersona = new Persona(personaDto);

            Persona = nuevaPersona;
        }
    }
}
