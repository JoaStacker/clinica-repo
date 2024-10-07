
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;
using Clinica.Infraestructura.Datos;
using Microsoft.EntityFrameworkCore;

namespace Clinica.Api.Services
{
    public class UsuarioServicio : IUsuarioServicio
    {
        Repositorio<Usuario> _repositorioUsuario;

        public UsuarioServicio(ClinicaContext context)
        {
            _repositorioUsuario = new Repositorio<Usuario>(context);
        }

        public async Task<Usuario?> AuthenticateUser(LoginDto dto)
        {            
            return _repositorioUsuario.GetTodos().SingleOrDefault(x => x.Email == dto.Email && x.Clave == dto.Clave);
        }
    }
}
