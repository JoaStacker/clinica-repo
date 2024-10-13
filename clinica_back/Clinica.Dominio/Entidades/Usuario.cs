using Clinica.Dominio.Dtos;
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
        [ForeignKey("Medico")]
        [Column("medico_id")]
        public int MedicoId { get; set; }

        // Propiedad de navegación
        public virtual Medico Medico { get; set; }

        public Usuario() { }
        public Usuario(SignUpDto usuarioDto)
        {
            Email = usuarioDto.Email;
            Clave = usuarioDto.Clave;

            MedicoDto medicoDto = new MedicoDto
            {
                Matricula = usuarioDto.Matricula,
                Especialidad = usuarioDto.Especialidad,
                Cuil = usuarioDto.Cuil,
                Dni = usuarioDto.Dni,
                FechaNacimiento = usuarioDto.FechaDeNacimiento,
                Email = usuarioDto.Email,
                Telefono = usuarioDto.Telefono,
                NombreApellido = usuarioDto.NombreApellido,
                Provincia = usuarioDto.Provincia,
                Localidad = usuarioDto.Localidad,   
                Cop = usuarioDto.Cop,
                Calle = usuarioDto.Calle,
                Altura = usuarioDto.Altura,
                Piso = usuarioDto.Piso,
                Departamento = usuarioDto.Departamento
            };
            Medico nuevoMedico = new Medico(medicoDto);

            Medico = nuevoMedico;
        }
    }

}
