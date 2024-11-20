using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;
using FluentAssertions;
using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;

namespace Clinica.Api.Tests
{
    // Clase de prueba para Diagnostico
    public class DiagnosticoTest
    {
        [Fact]
        public void TestDiagnosticoAgregarEvolucion()
        {
            // Preparación (Arrange)
            var diagnostico = new Diagnostico("Angina", "Ronchas en el cuerpo");
            var evolucionDto = new EvolucionDto { TextoLibre = "Se receta Paracetamol." };

            // Ejecutar (Act)
            diagnostico.agregarEvolucion(evolucionDto);

            // Verificar (Assert)
            diagnostico.EvolucionesClinicas.Should().HaveCount(1);
            diagnostico.EvolucionesClinicas.First().TextoLibre.Should().Be(evolucionDto.TextoLibre);
        }

        [Fact]
        public void TestDiagnosticoAgregarVariasEvoluciones()
        {
            // Preparación (Arrange)
            var diagnostico = new Diagnostico("Varicela", "Ronchas en el cuerpo");
            var evolucionDto1 = new EvolucionDto { TextoLibre = "Se receta Paracetamol." };
            var evolucionDto2 = new EvolucionDto { TextoLibre = "Se receta Ibuprofeno." };

            // Ejecutar (Act)
            diagnostico.agregarEvolucion(evolucionDto1);
            diagnostico.agregarEvolucion(evolucionDto2);

            // Verificar (Assert)
            diagnostico.EvolucionesClinicas.Should().HaveCount(2);
            diagnostico.EvolucionesClinicas.ElementAt(0).TextoLibre.Should().Be(evolucionDto1.TextoLibre);
            diagnostico.EvolucionesClinicas.ElementAt(1).TextoLibre.Should().Be(evolucionDto2.TextoLibre);
        }
    }
}