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
    public class EvolucionClinicaTest
    {
        [Fact]
        public void TestEvolucionClinicaConstructor()
        {
            // Preparacion (Arrange)
            var informeEsperado = "El paciente presenta sintomas de conjuntivitis.";

            // Ejecutar (Act)
            EvolucionClinica nuevaEvolucion = new EvolucionClinica(informeEsperado);

            // Verificar (Assert)
            nuevaEvolucion.Informe.Should().Be(informeEsperado);
        }

        [Fact]
        public void TestEvolucionClinicaConPedidoLaboratorio()
        {
            // Preparacion (Arrange)
            var informeEsperado = "El paciente presenta fiebre y tos leve.";
            var textoPedidoLaboratorio = "Se solicita: Analisis de hemoglobina completo.";
            EvolucionClinica evolucion = new EvolucionClinica(informeEsperado);

            // Ejecutar (Act)
            evolucion.ConPedidoLaboratorio(textoPedidoLaboratorio);
            
            // Verificar (Assert)
            evolucion.Informe.Should().Be(informeEsperado);
            evolucion.PedidoLaboratorio.TextoLibre.Should().Be(textoPedidoLaboratorio);
        }
        
        [Fact]
        public void TestEvolucionClinicaConRecetaDigital()
        {
            // Preparacion (Arrange)
            var informeEsperado = "El paciente presenta fiebre y tos leve.";
            var listaMedicamentos = new List<MedicamentoDto>
            {
                new MedicamentoDto("123", "Ibuprofeno 400", 2)  // MedicamentoDto con codigo, nombre y cantidad
            };
            var indicaciones = "Tomar una capsula cada 8 horas.";
            EvolucionClinica evolucion = new EvolucionClinica(informeEsperado);

            // Ejecutar (Act)
            evolucion.ConRecetaDigital(listaMedicamentos, indicaciones);
            
            // Verificar (Assert)
            evolucion.Informe.Should().Be(informeEsperado);
            evolucion.RecetaDigital.Indicaciones.Should().Be(indicaciones);
            evolucion.RecetaDigital.Medicamentos.Should().HaveCount(listaMedicamentos.Count);
            
            // Verificar que cada medicamento en RecetaDigital tiene los mismos valores que el MedicamentoDto correspondiente
            for (int i = 0; i < listaMedicamentos.Count; i++)
            {
                var medicamentoDto = listaMedicamentos[i];
                var medicamento = evolucion.RecetaDigital.Medicamentos.ElementAt(i);

                medicamento.Codigo.Should().Be(medicamentoDto.Codigo);
                medicamento.NombreComercial.Should().Be(medicamentoDto.NombreComercial);
                medicamento.Cantidad.Should().Be(medicamentoDto.Cantidad);
            }
        }
    }
}