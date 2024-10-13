
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;
using Clinica.Infraestructura.Datos;
using Microsoft.EntityFrameworkCore;

namespace Clinica.Api.Services
{
    public class UsuarioServicio : IUsuarioServicio
    {
        Repositorio<Usuario> _repositorioUsuario;
        Repositorio<Medico> _repositorioMedico;
        Repositorio<Persona> _repositorioPersona;

        public UsuarioServicio(ClinicaContext context)
        {
            _repositorioUsuario = new Repositorio<Usuario>(context);
            _repositorioMedico = new Repositorio<Medico>(context);
            _repositorioPersona = new Repositorio<Persona>(context);
        }

        public async Task<Usuario?> AuthenticateUser(LoginDto dto)
        {            
            return _repositorioUsuario.GetTodos().SingleOrDefault(x => x.Email == dto.Email && x.Clave == dto.Clave);
        }

        public async Task<ServiceResponse> CrearUsuario(SignUpDto dto)
        {
            try
            {
                IEnumerable<Usuario> usuarios = _repositorioUsuario.GetConFiltro(p => p.Email == dto.Email);
                IEnumerable<Medico> medicos = _repositorioMedico.GetConFiltro(p => p.Matricula == dto.Matricula);
                IEnumerable<Persona> personas = _repositorioPersona.GetConFiltro(p => p.Dni == dto.Dni);

                if (usuarios.Any())
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "El usuario con ese 'email' ya existe."
                    );
                }
                if (medicos.Any())
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "La matricula le pertenece a otro medico en el sistema."
                    );
                }
                if (personas.Any())
                {
                    return new ServiceResponse(
                        ServiceStatus.ERROR,
                        StatusCodes.Status409Conflict,
                        "El DNI le pertenece a otro medico en el sistema."
                    );
                }

                Usuario NuevoUsuario = new Usuario(dto);

                _repositorioUsuario.Agregar(NuevoUsuario);
                _repositorioUsuario.ConfirmarCambios();
                _repositorioUsuario.Dispose();

                return new ServiceResponse(
                    ServiceStatus.OK,
                    StatusCodes.Status200OK,
                    "Usuario creado con éxito"
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
