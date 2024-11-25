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
        private readonly IUsuarioServicio _servicioUsuario;
        public LoginController(IUsuarioServicio servicio)
        {
            _servicioUsuario = servicio;
        }
        
        
       [HttpPost]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            var sesion = await _servicioUsuario.AuthenticateUser(loginDto);
            if (sesion == null) 
            { 
                return Unauthorized("Las credenciales son incorrectas"); 
            }

            return Ok(sesion);
        }

    }
}
