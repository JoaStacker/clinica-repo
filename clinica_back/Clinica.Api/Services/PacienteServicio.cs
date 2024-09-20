using Clinica.Dominio.Entidades;
using Clinica.Dominio.Contratos;
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
    }
}
