using Clinica.Api.Services;
using Clinica.Dominio.Dtos;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

namespace Clinica.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DiagnosticoController : ControllerBase
    {
        private readonly IDiagnosticoServicio _servicioDiagnostico;
        public DiagnosticoController(IDiagnosticoServicio servicio)
        {
            _servicioDiagnostico = servicio;
        }


        [HttpGet]
        public async Task<IActionResult> Get([FromBody] DiagnosticosHistoriaDto dhDto)
        {
            ServiceResponse sr = await _servicioDiagnostico.ListarDiagnosticos(dhDto);

            if (sr.Status == ServiceStatus.OK)
            {
                return Ok(sr.Content);
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al retornar diagnosticos.", error = sr.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> CrearDiagnostico([FromBody] DiagnosticoDto diagnosticoDto)
        {
            // Check for required fields
            if (string.IsNullOrWhiteSpace(diagnosticoDto.Enfermedad) ||
                string.IsNullOrWhiteSpace(diagnosticoDto.Observaciones) ||
                diagnosticoDto.FechaDeCreacion == default ||
                diagnosticoDto.HistoriaClinicaID <= 0)
            {
                return BadRequest("Missing required fields.");
            }

            ServiceResponse sr = await _servicioDiagnostico.CrearDiagnostico(diagnosticoDto);

            if (sr.Status == ServiceStatus.OK)
            {
                return CreatedAtAction(nameof(CrearDiagnostico), sr.Content,
                        new { message = "Diagnostico creado con éxito.", sr.Content });
            }
            else
            {
                return StatusCode(sr.StatusCode,
                    new { message = "Error al crear el diagnostico.", error = sr.Message });
            }
        }
    }
}
