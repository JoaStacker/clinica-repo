using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;

namespace Clinica.Api.Services
{
    public interface IPacienteServicio
    {
        public Task<ServiceResponse> listarPacientes();
        public Task<ServiceResponse> crearPaciente(PacienteDto nuevoPaciente);
        public Task<ServiceResponse> ObtenerHistoriaClinicaConEvoluciones(int idPaciente);

        public Task<ServiceResponse> crearEvolucion(int idPaciente, EvolucionDto evolucion);
        public Task<ServiceResponse> agregarDiagnosticoAHistoriaClinica(int idPaciente, DiagnosticoDto diagnosticoDto);

        public Task<ServiceResponse> buscarDiagnosticosPrevios(int idPaciente);
    }
}
