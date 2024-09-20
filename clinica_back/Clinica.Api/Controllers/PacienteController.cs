using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Clinica.Dominio.Contratos;
using Clinica.Dominio.Entidades;
using Clinica.Api.Services;
using Clinica.Infraestructura.Datos;
using System.Text.Json;
using Newtonsoft.Json;

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
    }
}
