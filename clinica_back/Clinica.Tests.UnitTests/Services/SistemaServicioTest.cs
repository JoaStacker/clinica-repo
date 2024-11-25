using System.Linq.Expressions;
using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Contratos;
using Clinica.Infraestructura.Datos;
using Clinica.Api.Services;
using Microsoft.EntityFrameworkCore;
using NSubstitute;
using Newtonsoft.Json.Linq;
using Microsoft.AspNetCore.Http;
using Azure;

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
            var paciente = new Paciente(new PacienteDto { Dni = "12345678", NombreApellido = "Juan Perez" });
            Diagnostico diagnostico = new Diagnostico("Angina", "Enfermedad gripal");
            diagnostico.DiagnosticoID = 1;
            paciente.HistoriaClinica.Diagnosticos.Add(diagnostico);
            var medico = new Medico(new MedicoDto { Matricula = 1234, NombreApellido = "Dr. Perez" });
            medico.MedicoID = 1;
            var evolucionDto = new EvolucionDto
            {
                MedicoId = 1,
                DiagnosticoId = 1,
                Informe = "Informe de evolución",
            };

            _repositorioPacienteMock.Get(1).Returns(paciente);
            _repositorioMedicoMock.Get(1).Returns(medico);

            // Ejecutar
            var response = await _sistemaServicio.crearEvolucion(1, evolucionDto);

            // Verificar
            Assert.Equal(StatusCodes.Status200OK, response.StatusCode);
            Assert.Equal("Evolucion creada con éxito", response.Message);

            Assert.Single(paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas);
            EvolucionClinica evolucion = paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas.First();

            Assert.Equal(evolucionDto.Informe, evolucion.Informe);
            Assert.Equal(evolucionDto.MedicoId, evolucion.MedicoID);
            Assert.Null(evolucion.PedidoLaboratorio);
            Assert.Null(evolucion.RecetaDigital);
        }

        [Fact]
        public async Task TestCrearEvolucionConTextoSimple_DeberiaRetornarErrorSiElTextoEstaVacio()
        {
            // Preparar
            var paciente = new Paciente(new PacienteDto { Dni = "12345678", NombreApellido = "Juan Perez" });
            Diagnostico diagnostico = new Diagnostico("Angina", "Enfermedad gripal");
            diagnostico.DiagnosticoID = 1;
            paciente.HistoriaClinica.Diagnosticos.Add(diagnostico);
            var medico = new Medico(new MedicoDto { Matricula = 1234, NombreApellido = "Dr. Perez" });
            var evolucionDto = new EvolucionDto
            {
                MedicoId = 1,
                DiagnosticoId = 1,
                Informe = "",
            };

            _repositorioPacienteMock.Get(1).Returns(paciente);
            _repositorioMedicoMock.Get(1).Returns(medico);

            // Ejecutar
            var response = await _sistemaServicio.crearEvolucion(1, evolucionDto);

            // Verificar
            Assert.Equal(StatusCodes.Status500InternalServerError, response.StatusCode);
            Assert.Equal("El texto de la evolucion no debe estar vacio.", response.Message);

            Assert.Empty(paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas);
        }

        [Fact]
        public async Task TestCrearEvolucionConPedidoLaboratorio_DeberiaCrearEvolucionCorrectamente()
        {
            // Preparar
            var paciente = new Paciente(new PacienteDto { Dni = "12345678", NombreApellido = "Juan Perez" });
            paciente.PacienteID = 1;
            Diagnostico diagnostico = new Diagnostico("Angina", "Enfermedad gripal");
            diagnostico.DiagnosticoID = 1;
            paciente.HistoriaClinica.Diagnosticos.Add(diagnostico);
            var medico = new Medico(new MedicoDto { Matricula = 1234, NombreApellido = "Dr. Perez" });
            medico.MedicoID = 1;
            var evolucionDto = new EvolucionDto
            {
                MedicoId = 1,
                DiagnosticoId = 1,
                Informe = "Informe de evolución",
                TextoPedido = "Examen de sangre"
            };

            _repositorioPacienteMock.Get(1).Returns(paciente);
            _repositorioMedicoMock.Get(1).Returns(medico);

            // Ejecutar
            var response = await _sistemaServicio.crearEvolucion(1, evolucionDto);

            // Verificar
            Assert.Equal(StatusCodes.Status200OK, response.StatusCode);
            Assert.Equal("Evolucion creada con éxito", response.Message);

            Assert.Single(paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas);

            EvolucionClinica evolucion = paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas.First();

            Assert.Equal(evolucionDto.Informe, evolucion.Informe);
            Assert.Equal(evolucionDto.MedicoId, evolucion.MedicoID);

            Assert.NotNull(evolucion.PedidoLaboratorio);
            Assert.Equal(evolucionDto.TextoPedido, evolucion.PedidoLaboratorio.TextoLibre);

            Assert.Null(evolucion.RecetaDigital);
        }

        [Fact]
        public async Task TestCrearEvolucionConPedidoLaboratorio_DeberiaRetornarErrorSiElTextoEstaVacio()
        {
            // Preparar
            var paciente = new Paciente(new PacienteDto { Dni = "12345678", NombreApellido = "Juan Perez" });
            paciente.PacienteID = 1;
            Diagnostico diagnostico = new Diagnostico("Angina", "Enfermedad gripal");
            diagnostico.DiagnosticoID = 1;
            paciente.HistoriaClinica.Diagnosticos.Add(diagnostico);
            var medico = new Medico(new MedicoDto { Matricula = 1234, NombreApellido = "Dr. Perez" });
            medico.MedicoID = 1;
            var evolucionDto = new EvolucionDto
            {
                MedicoId = 1,
                DiagnosticoId = 1,
                Informe = "Informe de evolución",
                TextoPedido = ""
            };

            _repositorioPacienteMock.Get(1).Returns(paciente);
            _repositorioMedicoMock.Get(1).Returns(medico);

            // Ejecutar
            var response = await _sistemaServicio.crearEvolucion(1, evolucionDto);

            // Verificar
            Assert.Equal(StatusCodes.Status500InternalServerError, response.StatusCode);
            Assert.Equal("El texto del pedido de laboratorio no debe estar vacio.", response.Message);

            Assert.Empty(paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas);
        }

        [Fact]
        public async Task TestCrearEvolucionRecetaDigital_DeberiaCrearEvolucionCorrectamente()
        {
            // Preparar
            var paciente = new Paciente(new PacienteDto { Dni = "12345678", NombreApellido = "Juan Perez" });
            paciente.PacienteID = 1;
            Diagnostico diagnostico = new Diagnostico("Angina", "Enfermedad gripal");
            diagnostico.DiagnosticoID = 1;
            paciente.HistoriaClinica.Diagnosticos.Add(diagnostico);
            var medico = new Medico(new MedicoDto { Matricula = 1234, NombreApellido = "Dr. Perez" });
            medico.MedicoID = 1;
            var evolucionDto = new EvolucionDto
            {
                MedicoId = 1,
                DiagnosticoId = 1,
                Informe = "Informe de evolución",
                Medicamentos = new List<MedicamentoDto> {
                    { new MedicamentoDto("123","Ibuprofeno", 1) }
                },
                Indicaciones = "Indicaciones"
            };

            _repositorioPacienteMock.Get(1).Returns(paciente);
            _repositorioMedicoMock.Get(1).Returns(medico);

            // Ejecutar
            var response = await _sistemaServicio.crearEvolucion(1, evolucionDto);

            // Verificar
            Assert.Equal(StatusCodes.Status200OK, response.StatusCode);
            Assert.Equal("Evolucion creada con éxito", response.Message);

            Assert.Single(paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas);

            EvolucionClinica evolucion = paciente.HistoriaClinica.Diagnosticos.First().EvolucionesClinicas.First();

            Assert.Equal(evolucionDto.Informe, evolucion.Informe);
            Assert.Equal(evolucionDto.MedicoId, evolucion.MedicoID);

            Assert.NotNull(evolucion.RecetaDigital);
            Assert.Equal(evolucionDto.Medicamentos.Count, evolucion.RecetaDigital.Medicamentos.Count);

            var medicamentosReceta = evolucion.RecetaDigital.Medicamentos.ToList();
            for (int i = 0; i < medicamentosReceta.Count; i++)
            {
                var medicamentoReceta = medicamentosReceta[i];
                var medicamentoDto = evolucionDto.Medicamentos[i];

                Assert.Equal(medicamentoDto.Codigo, medicamentoReceta.Codigo);
                Assert.Equal(medicamentoDto.NombreComercial, medicamentoReceta.NombreComercial);
                Assert.Equal(medicamentoDto.Cantidad, medicamentoReceta.Cantidad);
            }
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
