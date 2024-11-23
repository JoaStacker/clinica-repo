using FluentAssertions;
using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;

namespace Clinica.Api.Tests.Entities
{
    // Clase de prueba para Diagnostico
    public class DiagnosticoTest
    {
        private readonly Medico medico = new Medico();
        
        [Fact]
        public void TestDiagnosticoAgregarEvolucion()
        {
            // Preparacion (Arrange)
            var diagnostico = new Diagnostico("Angina", "Ronchas en el cuerpo");
            var evolucionDto = new EvolucionDto { Informe = "Se receta Paracetamol." };

            // Ejecutar (Act)
            diagnostico.agregarEvolucion(evolucionDto, medico);

            // Verificar (Assert)
            diagnostico.EvolucionesClinicas.Should().HaveCount(1);
            diagnostico.EvolucionesClinicas.First().Informe.Should().Be(evolucionDto.Informe);
        }

        [Fact]
        public void TestDiagnosticoAgregarVariasEvoluciones()
        {
            // Preparacion (Arrange)
            var diagnostico = new Diagnostico("Varicela", "Ronchas en el cuerpo");
            var evolucionDto1 = new EvolucionDto { Informe = "Se receta Paracetamol." };
            var evolucionDto2 = new EvolucionDto { Informe = "Se receta Ibuprofeno." };

            // Ejecutar (Act)
            diagnostico.agregarEvolucion(evolucionDto1, medico);
            diagnostico.agregarEvolucion(evolucionDto2, medico);

            // Verificar (Assert)
            diagnostico.EvolucionesClinicas.Should().HaveCount(2);
            diagnostico.EvolucionesClinicas.ElementAt(0).Informe.Should().Be(evolucionDto1.Informe);
            diagnostico.EvolucionesClinicas.ElementAt(1).Informe.Should().Be(evolucionDto2.Informe);
        }
    }
}