using Clinica.Dominio.Entidades;

namespace Clinica.Api.Services
{
    public interface IPacienteServicio
    {
        public Task<IEnumerable<Paciente>> GetAllPacientes();
    }
}
