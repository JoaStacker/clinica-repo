using Microsoft.AspNetCore.Mvc;
using Clinica.Dominio.Dtos;
using Clinica.Api.Services;

namespace Clinica.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PacienteController : ControllerBase
    {
        private readonly IPacienteServicio _servicio;

        public PacienteController(IPacienteServicio servicio)
        {
            _servicio = servicio;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            ServiceResponse sr = await _servicio.GetAllPacientes();
            return Ok(sr.Content);
        }

        [HttpPost]
        public async Task<IActionResult> crearPaciente([FromBody] PacienteDto pacienteDto)
        {
            // Check for required fields
            if (pacienteDto.NroAfiliado <= 0 ||
                string.IsNullOrWhiteSpace(pacienteDto.Pasaporte) ||
                string.IsNullOrWhiteSpace(pacienteDto.Cuil) ||
                string.IsNullOrWhiteSpace(pacienteDto.Dni) ||
                pacienteDto.FechaNacimiento == default ||
                string.IsNullOrWhiteSpace(pacienteDto.Email) ||
                string.IsNullOrWhiteSpace(pacienteDto.Telefono) ||
                string.IsNullOrWhiteSpace(pacienteDto.NombreApellido) ||
                string.IsNullOrWhiteSpace(pacienteDto.Provincia) ||
                string.IsNullOrWhiteSpace(pacienteDto.Localidad) ||
                string.IsNullOrWhiteSpace(pacienteDto.Cop) ||
                string.IsNullOrWhiteSpace(pacienteDto.Calle) ||
                 string.IsNullOrWhiteSpace(pacienteDto.Altura))
            {
                return BadRequest("Missing required fields.");
            }

            ServiceResponse sr = await _servicio.crearPaciente(pacienteDto);

            if (sr.Status == ServiceStatus.OK)
            {
                return CreatedAtAction(nameof(crearPaciente), new { id = pacienteDto.Dni },
                        new { message = "Paciente creado con éxito.", id = pacienteDto.Dni });
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el paciente.", error = sr.Message });
            }
        }
    }
}
