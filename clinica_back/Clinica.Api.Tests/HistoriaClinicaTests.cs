using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;
using FluentAssertions;

namespace Clinica.Api.Tests
{
    public class HistoriaClinicaTests
    {
        [Fact]
        public void TestAgregarDiagnostico()
        {
            // Preparación (Arrange)
            var historiaClinica = new HistoriaClinica();
            var diagnosticoDto = new DiagnosticoDto
            {
                Enfermedad = "Angina",
                Observaciones = "Ronchas en el cuerpo"
            };

            // Ejecutar (Act)
            historiaClinica.agregarDiagnostico(diagnosticoDto);

            // Verificar (Assert)
            historiaClinica.Diagnosticos.Should().HaveCount(1);
            historiaClinica.Diagnosticos.First().Enfermedad.Should().Be("Angina");
        }

        [Fact]
        public void TestAgregarEvolucionAUnDiagnosticoExistente()
        {
            // Preparación (Arrange)
            var historiaClinica = new HistoriaClinica();
            var diagnosticoDto = new DiagnosticoDto
            {
                Enfermedad = "Angina",
                Observaciones = "Ronchas en el cuerpo"
            };
            historiaClinica.agregarDiagnostico(diagnosticoDto);

            var evolucionDto = new EvolucionDto
            {
                DiagnosticoId = historiaClinica.Diagnosticos.First().DiagnosticoID,
                TextoLibre = "Se receta Paracetamol."
            };

            // Ejecutar (Act)
            historiaClinica.agregarEvolucion(evolucionDto);

            // Verificar (Assert)
            var diagnostico = historiaClinica.Diagnosticos.First();
            diagnostico.EvolucionesClinicas.Should().HaveCount(1);
            diagnostico.EvolucionesClinicas.First().TextoLibre.Should().Be("Se receta Paracetamol.");
        }

        [Fact]
        public void TestBuscarDiagnosticos()
        {
            // Preparación (Arrange)
            var historiaClinica = new HistoriaClinica();
            var diagnosticoDto1 = new DiagnosticoDto
            {
                Enfermedad = "Angina",
                Observaciones = "Ronchas en el cuerpo"
            };
            var diagnosticoDto2 = new DiagnosticoDto
            {
                Enfermedad = "Varicela",
                Observaciones = "Fiebre y erupciones"
            };
            historiaClinica.agregarDiagnostico(diagnosticoDto1);
            historiaClinica.agregarDiagnostico(diagnosticoDto2);

            // Ejecutar (Act)
            var diagnosticos = historiaClinica.buscarDiagnosticos();

            // Verificar (Assert)
            diagnosticos.Should().HaveCount(2);
            diagnosticos[0].Enfermedad.Should().Be("Angina");
            diagnosticos[1].Enfermedad.Should().Be("Varicela");
        }
    }
}