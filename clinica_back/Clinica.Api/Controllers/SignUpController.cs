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
    public class SignUpController : ControllerBase
    {
        private readonly IUsuarioServicio _servicioUsuario;
        public SignUpController(IUsuarioServicio servicio)
        {
            _servicioUsuario = servicio;
        }
        
        [HttpPost]
        public async Task<IActionResult> SignUp([FromBody] SignUpDto usuario)
        {
            // Check for required fields
            if (usuario.Matricula <= 0 ||
                string.IsNullOrWhiteSpace(usuario.Especialidad) ||
                string.IsNullOrWhiteSpace(usuario.Cuil) ||
                string.IsNullOrWhiteSpace(usuario.Dni) ||
                usuario.FechaDeNacimiento == default ||
                string.IsNullOrWhiteSpace(usuario.Email) ||
                string.IsNullOrWhiteSpace(usuario.Telefono) ||
                string.IsNullOrWhiteSpace(usuario.NombreApellido) ||
                string.IsNullOrWhiteSpace(usuario.Provincia) ||
                string.IsNullOrWhiteSpace(usuario.Localidad) ||
                string.IsNullOrWhiteSpace(usuario.Cop) ||
                string.IsNullOrWhiteSpace(usuario.Calle) ||
                 string.IsNullOrWhiteSpace(usuario.Altura))
            {
                return BadRequest("Missing required fields.");
            }

            ServiceResponse sr = await _servicioUsuario.CrearUsuario(usuario);

            if (sr.Status == ServiceStatus.OK)
            {
                return CreatedAtAction(nameof(SignUp), new { id = usuario.Email },
                        new { message = "Usuario creado con éxito.", id = usuario.Email});
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el usuario.", error = sr.Message });
            }
        }

    }
}
