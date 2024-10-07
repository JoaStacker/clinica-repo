
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;
using Clinica.Infraestructura.Datos;
using Microsoft.EntityFrameworkCore;

namespace Clinica.Api.Services
{
    public class DiagnosticoServicio : IDiagnosticoServicio
    {
        Repositorio<Diagnostico> _repositorioDiagnostico;
        Repositorio<HistoriaClinica> _repositorioHistoriaClinica;

        public DiagnosticoServicio(ClinicaContext context)
        {
            _repositorioDiagnostico = new Repositorio<Diagnostico>(context);
            _repositorioHistoriaClinica = new Repositorio<HistoriaClinica>(context);
        }

        public async Task<ServiceResponse> GetAllDiagnosticos()
        {
            try
            {
                IEnumerable<Diagnostico> diagnosticos = _repositorioDiagnostico.GetTodos();
                return new ServiceResponse(
                   ServiceStatus.OK,
                   StatusCodes.Status200OK,
                   "Diagnosticos obtenidos con exito.",
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

        public async Task<ServiceResponse> CrearDiagnostico(DiagnosticoDto diagnosticoDto)
        {
            try
            {
                HistoriaClinica historiaClinica = _repositorioHistoriaClinica.Get(diagnosticoDto.HistoriaClinicaID);

                if (historiaClinica == null)
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "La historia clinica no existe"
                    );
                }

                Diagnostico NuevoDiagnostico = new Diagnostico(diagnosticoDto, historiaClinica);
                
                _repositorioDiagnostico.Agregar(NuevoDiagnostico);
                _repositorioDiagnostico.ConfirmarCambios();

                _repositorioDiagnostico.Dispose();
                _repositorioHistoriaClinica.Dispose();

                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Diagnostico asociado a la historia clinica con éxito",
                    NuevoDiagnostico
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

        public async Task<ServiceResponse> ListarDiagnosticos(DiagnosticosHistoriaDto dhDto)
        {
            try
            {
                HistoriaClinica historiaClinica = _repositorioHistoriaClinica.Get(dhDto.HistoriaClinicaID);

                if (historiaClinica == null)
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "La historia clinica no existe"
                    );
                }

                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Diagnostico asociado a la historia clinica con éxito",
                    historiaClinica
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
