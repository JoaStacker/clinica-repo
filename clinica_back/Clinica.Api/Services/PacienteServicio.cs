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
        public async Task<ServiceResponse> listarPacientes()
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

        public async Task<ServiceResponse> ObtenerHistoriaClinicaConEvoluciones(int idPaciente)
        {
            try
            {
                Paciente paciente = _repositorioPaciente.Get(idPaciente);

                if (paciente == null)
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "El paciente no existe"
                    );
                }

                HistoriaClinica historiaClinica = paciente.ObtenerHistoriaClinica();
                var historiaClinicaCompleta = historiaClinica.Diagnosticos
                    .ToList()
                    .Select(diagnostico => new 
                    {
                        diagnosticoID = diagnostico.DiagnosticoID,
                        enfermedad = diagnostico.Enfermedad,
                        observaciones = diagnostico.Observaciones,
                        evoluciones = diagnostico.EvolucionesClinicas.Select(evolucion => new
                        {
                            TextoLibre = evolucion.TextoLibre,
                            FechaCreacion = evolucion.FechaDeCreacion
                        }).ToList()
                    }).ToList();

                var resultado = new
                {
                    pacienteID = paciente.PacienteID,
                    dni = paciente.Persona.Dni,
                    nombreApellido = paciente.Persona.NombreApellido,
                    historiaClinica=historiaClinicaCompleta
                };
                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Historia clinica devuelta con exito",
                    resultado
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

        public async Task<ServiceResponse> crearEvolucion(int idPaciente, EvolucionDto evolucionDto)
        {
            try
            {
                Paciente paciente = _repositorioPaciente.Get(idPaciente);

                if (paciente == null)
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "El paciente no existe"
                    );
                }

                paciente.agregarEvolucion(evolucionDto);

                _repositorioPaciente.Modificar(paciente);
                _repositorioPaciente.ConfirmarCambios();
                _repositorioPaciente.Dispose();

                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Evolucion creada con éxito"
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

        public async Task<ServiceResponse> agregarDiagnosticoAHistoriaClinica(int idPaciente, DiagnosticoDto diagnosticoDto)
        {
            try
            {
                Paciente paciente = _repositorioPaciente.Get(idPaciente);

                if (paciente == null)
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "El paciente no existe"
                    );
                }

                paciente.agregarDiagnosticoAHistoriaClinica(diagnosticoDto);

                _repositorioPaciente.Modificar(paciente);
                _repositorioPaciente.ConfirmarCambios();
                _repositorioPaciente.Dispose();

                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Evolucion creada con éxito"
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

        public async Task<ServiceResponse> buscarDiagnosticosPrevios(int idPaciente)
        {
            try
            {
                Paciente paciente = _repositorioPaciente.Get(idPaciente);

                if (paciente == null)
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "El paciente no existe"
                    );
                }

                List<Diagnostico> diagnosticos = paciente.buscarDiagnosticos();

                _repositorioPaciente.Dispose();

                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Diagnosticos listados con exito",
                    diagnosticos
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
    }
}
