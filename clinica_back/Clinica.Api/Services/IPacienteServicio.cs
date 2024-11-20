using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;

namespace Clinica.Api.Services
{
    public interface IPacienteServicio
    {
        public Task<ServiceResponse> GetAllPacientes();
        public Task<ServiceResponse> crearPaciente(PacienteDto nuevoPaciente);

        public Task<ServiceResponse> crearEvolucion(EvolucionDto evolucion);
        public Task<ServiceResponse> buscarEvoluciones(int idPaciente);
    }
}
