using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;

namespace Clinica.Api.Services
{
    public interface IDiagnosticoServicio
    {
        public Task<ServiceResponse> GetAllDiagnosticos();

        public Task<ServiceResponse> CrearDiagnostico(DiagnosticoDto diagnosticoDto);

        public Task<ServiceResponse> ListarDiagnosticos(DiagnosticosHistoriaDto dhDto);
    }
}
