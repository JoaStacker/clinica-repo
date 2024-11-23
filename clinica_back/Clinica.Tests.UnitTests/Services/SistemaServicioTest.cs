using System.Linq.Expressions;
using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Contratos;
using Clinica.Infraestructura.Datos;
using Clinica.Api.Services;
using Microsoft.EntityFrameworkCore;
using NSubstitute;

namespace Clinica.Api.Tests.Services
{
    public class SistemaServicioTest
    {
        private readonly IQueryable<Paciente> _dbSetMock;
        private readonly ClinicaContext _contextMock;
        private readonly IRepositorio<Paciente> _repositorioMock;
        private readonly SistemaServicio _sistemaServicio;

        public SistemaServicioTest()
        {
            var pacientesMock = new List<Paciente>
            {
                new Paciente { PacienteID = 1, Persona = new Persona { Dni = "12345678", NombreApellido = "Juan Perez" } },
                new Paciente { PacienteID = 2, Persona = new Persona { Dni = "87654321", NombreApellido = "Ana Lopez" } }
            };

            _dbSetMock = Substitute.For<DbSet<Paciente>, IQueryable<Paciente>>();
            _dbSetMock.Provider.Returns(pacientesMock.AsQueryable().Provider);
            _dbSetMock.Expression.Returns(pacientesMock.AsQueryable().Expression);
            _dbSetMock.ElementType.Returns(pacientesMock.AsQueryable().ElementType);
            _dbSetMock.GetEnumerator().Returns(pacientesMock.GetEnumerator());

            _contextMock = Substitute.For<ClinicaContext>(new DbContextOptions<ClinicaContext>());
            _contextMock.Pacientes.Returns(_dbSetMock); 
            
            _repositorioMock = Substitute.For<IRepositorio<Paciente>>();
            _sistemaServicio = new SistemaServicio(_contextMock);
        }

        [Fact]
        public async Task ListarPacientes_DeberiaRetornarExito()
        {
            // Preparar: Crear una lista de pacientes mockeada
            var pacientesMock = new List<Paciente>
            {
                new Paciente { PacienteID = 1, Persona = new Persona { Dni = "12345678", NombreApellido = "Juan Perez" } },
                new Paciente { PacienteID = 2, Persona = new Persona { Dni = "87654321", NombreApellido = "Ana Lopez" } }
            };

            _repositorioMock.GetTodos().Returns(pacientesMock); // Configuración con NSubstitute

            // Ejecutar: Llamar al método del servicio
            var response = await _sistemaServicio.listarPacientes();

            // Verificar: Verificar que la respuesta es exitosa y contiene los pacientes esperados
            Assert.Equal(ServiceStatus.OK, response.Status);
            var pacientes = (List<Paciente>)response.Content;
            Assert.NotNull(pacientes);
            Assert.Equal(2, pacientes.Count);
            Assert.Equal("Juan Perez", pacientes[0].Persona.NombreApellido);
        }

        [Fact]
        public async Task CrearPaciente_DeberiaCrearPacienteCorrectamente()
        {
            // Preparar
            var pacienteDto = new PacienteDto
            {
                Dni = "12345678",
                NombreApellido = "Juan Perez",
                FechaNacimiento = new DateTime(1980, 1, 1),
                Email = "juan.perez@example.com"
            };
            
            _repositorioMock.GetConFiltro(Arg.Any<Expression<Func<Paciente, bool>>>()).Returns(Enumerable.Empty<Paciente>()); // No existe un paciente con ese Dni

            // Ejecutar
            var response = await _sistemaServicio.crearPaciente(pacienteDto);

            // Verificar
            Assert.Equal(ServiceStatus.OK, response.Status);
            _repositorioMock.Received(1).Agregar(Arg.Any<Paciente>()); // Verificar que se llamó a Agregar
            _repositorioMock.Received(1).ConfirmarCambios(); // Verificar que se confirmó el cambio
        }

        [Fact]
        public async Task CrearPaciente_DeberiaRetornarErrorSiPacienteYaExiste()
        {
            // Preparar
            var pacienteDto = new PacienteDto { Dni = "12345678" };

            _repositorioMock.GetConFiltro(Arg.Any<System.Linq.Expressions.Expression<Func<Paciente,bool>>>()).Returns(new List<Paciente> { new Paciente() });

            // Ejecutar
            var response = await _sistemaServicio.crearPaciente(pacienteDto);

            // Verificar
            Assert.Equal(ServiceStatus.ERROR, response.Status);
            Assert.Equal("El paciente ya existe", response.Message);
        }

        [Fact]
        public async Task ObtenerHistoriaClinicaConEvoluciones_DeberiaRetornarHistoriaClinicaConEvoluciones()
        {
            // Preparar
            var paciente = new Paciente
            {
                PacienteID = 1,
                Persona = new Persona { Dni = "12345678", NombreApellido = "Juan Perez" },
                HistoriaClinica = new HistoriaClinica
                {
                    Diagnosticos = new List<Diagnostico>
                    {
                        new Diagnostico
                        {
                            DiagnosticoID = 1,
                            Enfermedad = "Conjuntivitis",
                            EvolucionesClinicas = new List<EvolucionClinica>
                            {
                                new EvolucionClinica
                                {
                                    Informe = "Informe de evolución",
                                    FechaDeCreacion = DateTime.Now,
                                }
                            }
                        }
                    }
                }
            };

            _repositorioMock.Get(1).Returns(paciente); 

            // Ejecutar
            var response = await _sistemaServicio.ObtenerHistoriaClinicaConEvoluciones(1);

            // Verificar
            Assert.Equal(ServiceStatus.OK, response.Status);
            var historia = ((dynamic)response.Content).historiaClinica;
            Assert.NotNull(historia);
            Assert.Equal("Conjuntivitis", historia.First().enfermedad);
            Assert.Equal("Análisis de sangre", historia.First().evoluciones.First().TextoPedido);
        }
    }
}
