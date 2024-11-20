using Microsoft.AspNetCore.Mvc;
using Clinica.Dominio.Dtos;
using Clinica.Api.Services;

namespace Clinica.Api.Controllers
{
    [Route("api")]
    [ApiController]
    public class SistemaController : ControllerBase
    {
        private readonly ISistemaServicio _servicio;

        public SistemaController(ISistemaServicio servicio)
        {
            _servicio = servicio;
        }

        [HttpGet]
        [Route("/pacientes")]
        public async Task<IActionResult> listarPacientes()
        {
            ServiceResponse sr = await _servicio.listarPacientes();
            return Ok(sr.Content);
        }

        [HttpPost]
        [Route("/pacientes")]
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
                return CreatedAtAction(nameof(crearPaciente), sr.Content,
                        new { message = "Paciente creado con éxito.", sr.Content });
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el paciente.", error = sr.Message });
            }
        }

        [HttpGet]
        [Route("/{id}/historia-clinica")]
        public async Task<IActionResult> ObtenerHistoriaClinicaConEvoluciones(int idPaciente)
        {
            ServiceResponse sr = await _servicio.ObtenerHistoriaClinicaConEvoluciones(idPaciente);

            if (sr.Status == ServiceStatus.OK)
            {
                return Ok(sr.Content);
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el paciente.", error = sr.Message });
            }
        }

        [HttpPost]
        [Route("/{id}/evoluciones")]
        public async Task<IActionResult> agregarEvolucion(int idPaciente, [FromBody] EvolucionDto evolucionDto)
        {
            ServiceResponse sr = await _servicio.crearEvolucion(idPaciente, evolucionDto);

            if (sr.Status == ServiceStatus.OK)
            {
                return CreatedAtAction(nameof(crearPaciente), sr.Content,
                        new { message = "Evolucion creada con éxito.", sr.Content });
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el evolucion.", error = sr.Message });
            }
        }

        [HttpPost]
        [Route("/{id}/diagnosticos")]
        public async Task<IActionResult> agregarDiagnosticoAHistoriaClinica(int idPaciente, [FromBody] DiagnosticoDto diagnosticoDto)
        {
            ServiceResponse sr = await _servicio.agregarDiagnosticoAHistoriaClinica(idPaciente, diagnosticoDto);

            if (sr.Status == ServiceStatus.OK)
            {
                return Ok(sr.Content);
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el paciente.", error = sr.Message });
            }
        }

        [HttpGet]
        [Route("/{id}/diagnosticos")]
        public async Task<IActionResult> listarDiagnosticosPrevios(int idPaciente)
        {
            ServiceResponse sr = await _servicio.buscarDiagnosticosPrevios(idPaciente);

            if (sr.Status == ServiceStatus.OK)
            {
                return Ok(sr.Content);
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el paciente.", error = sr.Message });
            }
        }
    }
}
