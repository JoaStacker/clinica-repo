using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;

namespace Clinica.Api.Services
{
    public interface IUsuarioServicio
    {
        public Task<Usuario?> AuthenticateUser(LoginDto dto);
    }
}
