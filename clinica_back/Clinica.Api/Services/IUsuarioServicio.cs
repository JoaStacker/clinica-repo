using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;

namespace Clinica.Api.Services
{
    public interface IUsuarioServicio
    {
        public Task<ServiceResponse> AuthenticateUser(LoginDto dto);
        public Task<ServiceResponse> CrearUsuario(SignUpDto dto);
    }
}
