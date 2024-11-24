using System.Linq.Expressions;
using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Contratos;
using Clinica.Infraestructura.Datos;
using Clinica.Api.Services;
using Microsoft.EntityFrameworkCore;
using NSubstitute;
using Newtonsoft.Json.Linq;

namespace Clinica.Api.Tests.Services
{
    public class SistemaServicioTest
    {
        private readonly IRepositorio<Paciente> _repositorioPacienteMock;
        private readonly IRepositorio<Medico> _repositorioMedicoMock;
        private readonly SistemaServicio _sistemaServicio;

        public SistemaServicioTest()
        {
            _repositorioPacienteMock = Substitute.For<IRepositorio<Paciente>>();
            _repositorioMedicoMock = Substitute.For<IRepositorio<Medico>>();
            _sistemaServicio = new SistemaServicio(_repositorioPacienteMock, _repositorioMedicoMock);
        }

        [Fact]
        public async Task TestCrearEvolucionConTextoSimple_DeberiaCrearEvolucionCorrectamente()
        {
            // Preparar

            // Ejecutar

            // Verificar
        }

        [Fact]
        public async Task TestCrearEvolucionConTextoSimple_DeberiaRetornarErrorSiElTextoEstaVacio()
        {
            // Preparar

            // Ejecutar

            // Verificar
        }

        [Fact]
        public async Task TestCrearEvolucionConPedidoLaboratorio_DeberiaCrearEvolucionCorrectamente()
        {
            // Preparar

            // Ejecutar

            // Verificar
        }

        [Fact]
        public async Task TestCrearEvolucionConPedidoLaboratorio_DeberiaRetornarErrorSiElTextoEstaVacio()
        {
            // Preparar

            // Ejecutar

            // Verificar
        }

        [Fact]
        public async Task TestCrearEvolucionRecetaDigital_DeberiaCrearEvolucionCorrectamente()
        {
            // Preparar

            // Ejecutar

            // Verificar
        }

        [Fact]
        public async Task TestCrearEvolucionRecetaDigital_DeberiaRetornarErrorSiNoTieneMedicamentosOIndicaciones()
        {
            // Preparar

            // Ejecutar

            // Verificar
        }
    }
}
