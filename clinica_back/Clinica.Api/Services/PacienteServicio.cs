using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;
using Clinica.Infraestructura.Datos;

namespace Clinica.Api.Services
{
    public class PacienteServicio: IPacienteServicio
    {
        Repositorio<Paciente> _repositorioPaciente;

        public PacienteServicio(ClinicaContext context)
        {
            _repositorioPaciente = new Repositorio<Paciente>(context);
        }
        public async Task<IEnumerable<Paciente>> GetAllPacientes()
        {
            IEnumerable<Paciente> pacientes = _repositorioPaciente.GetTodos();
            return await Task.FromResult<IEnumerable<Paciente>>(pacientes);
        }

        public async Task<ServiceResponse> crearPaciente(PacienteDto pacienteDto)
        {
            try
            {
                IEnumerable<Paciente> pacientes = _repositorioPaciente.GetTodos();

                if (pacientes.Any(p => p.Persona.Dni == pacienteDto.Dni))
                {
                    return new ServiceResponse(
                        false,
                        StatusCodes.Status409Conflict,
                        "El paciente ya existe"
                    );
                }

                Paciente NuevoPaciente = new Paciente(pacienteDto);
                
                _repositorioPaciente.Agregar(NuevoPaciente);
                _repositorioPaciente.ConfirmarCambios();
                _repositorioPaciente.Dispose();

                return new ServiceResponse(
                    true,
                    StatusCodes.Status200OK,
                    "Paciente creado con éxito"
                );
            }catch (Exception ex)
            {
                return new ServiceResponse(
                    false,
                    StatusCodes.Status500InternalServerError,
                    ex.Message
                );
            }
            
        }
    }
}
