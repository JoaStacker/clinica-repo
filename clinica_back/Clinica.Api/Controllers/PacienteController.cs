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
            Console.WriteLine("Get pacientes");
            var pacientes = await _servicio.GetAllPacientes();
            return Ok(pacientes);
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

            ServiceResponse serviceResponse = await _servicio.crearPaciente(pacienteDto);

            if (serviceResponse.Ok)
            {
                return CreatedAtAction(nameof(Get), new { id = pacienteDto.Dni }, null);
            }
            else
            {
                return StatusCode(serviceResponse.StatusCode);
            }
        }
    }
}
