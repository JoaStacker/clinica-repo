using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Clinica.Dominio.Enumeraciones;
using Clinica.Dominio.Dtos;
using System.Text.Json.Serialization;

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

        [ForeignKey("HistoriaClinica")]
        [Column("historia_clinica_id")]
        public int? HistoriaClinicaID { get; set; } = null;

        // Navigation properties
        public virtual Persona Persona { get; set; }
        
        [JsonIgnore]
        public virtual HistoriaClinica HistoriaClinica { get; set; }

        // Constructor default
        public Paciente()
        {

        }

        public Paciente(PacienteDto pacienteDto)
        {
            NroAfiliado = pacienteDto.NroAfiliado;
            Pasaporte = pacienteDto.Pasaporte;
            FechaDefuncion = null;
            Estado = EstadoPaciente.ACTIVO;

            PersonaDto personaDto = new PersonaDto
            {
                Cuil = pacienteDto.Cuil,
                Dni = pacienteDto.Dni,
                FechaNacimiento = pacienteDto.FechaNacimiento,
                Email = pacienteDto.Email,
                Telefono = pacienteDto.Telefono,
                NombreApellido = pacienteDto.NombreApellido,
                Provincia = pacienteDto.Provincia,
                Localidad = pacienteDto.Localidad,
                Cop = pacienteDto.Cop,
                Calle = pacienteDto.Calle,
                Altura = pacienteDto.Altura,
                Piso = pacienteDto.Piso,
                Departamento = pacienteDto.Departamento
            };

            Persona nuevaPersona = new Persona(personaDto);

            HistoriaClinica nuevaHistoriaClinica= new HistoriaClinica
            {
                FechaDeCreacion = DateTime.Now
            };  

            Persona = nuevaPersona;
            HistoriaClinica = nuevaHistoriaClinica;
        }

        public void agregarEvolucion(EvolucionDto evolucionDto)
        {
            HistoriaClinica.agregarEvolucion(evolucionDto);
        }

        public List<EvolucionClinica> buscarEvoluciones()
        {
            return HistoriaClinica.buscarEvoluciones();
        }
    }
}
