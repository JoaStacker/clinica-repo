
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;
using Clinica.Dominio.Contratos;
using Clinica.Api.Utils;

namespace Clinica.Api.Services
{
    public class UsuarioServicio : IUsuarioServicio
    {
        ISesionUtils _utils;
        IRepositorio<Usuario> _repositorioUsuario;
        IRepositorio<Medico> _repositorioMedico;
        IRepositorio<Persona> _repositorioPersona;

        public UsuarioServicio(
            IRepositorio<Usuario> repositorioUsuario,
            IRepositorio<Medico> repositorioMedico,
            IRepositorio<Persona> repositorioPersona,
            ISesionUtils utils
)
        {
            _repositorioUsuario = repositorioUsuario;
            _repositorioMedico = repositorioMedico;
            _repositorioPersona = repositorioPersona;
            _utils = utils;
        }

        public async Task<ServiceResponse> AuthenticateUser(LoginDto dto)
        {
            try
            {
                Usuario? usuario = _repositorioUsuario.GetTodos().SingleOrDefault(x => x.Email == dto.Email && x.Clave == dto.Clave);

                if (usuario == null)
                {
                    return new ServiceResponse(
                           ServiceStatus.ERROR,
                           StatusCodes.Status409Conflict,
                           "Credenciales incorrectas"
                       );
                }


                string token = _utils.GenerarJWT(usuario);
                Sesion sesion = usuario.IniciarSesion(token);

                _repositorioUsuario.Modificar(usuario);
                _repositorioUsuario.ConfirmarCambios();

                return new ServiceResponse(
                        ServiceStatus.OK,
                        StatusCodes.Status200OK,
                        "Sesion creada con exito",
                        sesion
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
