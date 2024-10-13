using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;

namespace Clinica.Api.Services
{
    public interface IPacienteServicio
    {
        public Task<ServiceResponse> GetAllPacientes();
        public Task<ServiceResponse> crearPaciente(PacienteDto nuevoPaciente);
    }
}
