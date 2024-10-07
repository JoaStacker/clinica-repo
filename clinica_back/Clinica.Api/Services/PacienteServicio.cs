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
        public async Task<ServiceResponse> GetAllPacientes()
        {
            try
            {
                IEnumerable<Paciente> pacientes = _repositorioPaciente.GetTodos();
                IEnumerable<Paciente> result = await Task.FromResult<IEnumerable<Paciente>>(pacientes);
                return new ServiceResponse(
                   ServiceStatus.OK,
                   StatusCodes.Status200OK,
                   "Pacientes obtenidos con exito.",
                   pacientes
               );
            }
            catch (Exception ex)
            {
                return new ServiceResponse(
                    ServiceStatus.ERROR,
                    StatusCodes.Status500InternalServerError,
                    ex.Message
                );
            }
        }

        public async Task<ServiceResponse> crearPaciente(PacienteDto pacienteDto)
        {
            try
            {
                IEnumerable<Paciente> pacientes = _repositorioPaciente.GetConFiltro(p => p.Persona.Dni == pacienteDto.Dni);

                if (pacientes.Any())
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "El paciente ya existe"
                    );
                }

                Paciente NuevoPaciente = new Paciente(pacienteDto);
                
                _repositorioPaciente.Agregar(NuevoPaciente);
                _repositorioPaciente.ConfirmarCambios();
                _repositorioPaciente.Dispose();

                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Paciente creado con éxito",
                    NuevoPaciente
                );
            }catch (Exception ex)
            {
                return new ServiceResponse(
                    ServiceStatus.ERROR,
                    StatusCodes.Status500InternalServerError,
                    ex.Message
                );
            }
            
        }
    }
}
