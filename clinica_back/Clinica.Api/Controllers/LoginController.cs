using Clinica.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Clinica.Dominio;
using Clinica.Infraestructura.Datos;
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;
using Newtonsoft.Json.Linq;

namespace Clinica.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private Clinica.Api.Utils.Utils _utilidades;
        private readonly IUsuarioServicio _servicioUsuario;
        public LoginController(IUsuarioServicio servicio, Clinica.Api.Utils.Utils utilidades)
        {
            _servicioUsuario = servicio;
            _utilidades = utilidades;
        }
        
        
       [HttpPost]
        public async Task<IActionResult> Login([FromBody] LoginDto usuario)
        {
            var usuarioCredentials = await _servicioUsuario.AuthenticateUser(usuario);
            if (usuarioCredentials == null) 
            { 
                return Unauthorized("Las credenciales son incorrectas"); 
            }

            var tokens = _utilidades.generarJWT(usuarioCredentials);

            var user = new UsuarioLoginDto()
            {
                Email = usuarioCredentials.Email,
                Token = tokens
            };

            return Ok(user);
        }

    }
}
