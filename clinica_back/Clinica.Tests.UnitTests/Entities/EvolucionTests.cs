using Clinica.Dominio.Contratos;
using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;
using FluentAssertions;
using Moq;
using Xunit;

namespace Clinica.Api.Tests.Entities
{
    // Clase de prueba para Diagnostico
    public class EvolucionClinicaTest
    {
        private readonly Medico medico = new Medico();
        private readonly string informeEsperado = "El paciente presenta sintomas de conjuntivitis.";
        
        [Fact]
        public void TestEvolucionClinicaConstructor()
        {
            // Preparacion (Arrange)
            // * * *
            
            // Ejecutar (Act)
            EvolucionClinica nuevaEvolucion = new EvolucionClinica(informeEsperado, medico);

            // Verificar (Assert)
            nuevaEvolucion.Informe.Should().Be(informeEsperado);
            // Assert.Equal(nuevaEvolucion.Informe, informeEsperado);
        }

        [Fact]
        public void TestEvolucionClinicaConPedidoLaboratorio()
        {
            // Preparacion (Arrange)
            string textoPedidoLaboratorio = "Se solicita: Analisis de hemoglobina completo.";
            EvolucionClinica evolucion = new EvolucionClinica(informeEsperado, medico);

            // Ejecutar (Act)
            evolucion.ConPedidoLaboratorio(textoPedidoLaboratorio);
            
            // Verificar (Assert)
            evolucion.Informe.Should().Be(informeEsperado);
            evolucion.PedidoLaboratorio.TextoLibre.Should().Be(textoPedidoLaboratorio);

            // Assert.Equal(evolucion.Informe, informeEsperado);
            // Assert.Equal(evolucion.PedidoLaboratorio.TextoLibre, textoPedidoLaboratorio);
        }
        
        [Fact]
        public void TestEvolucionClinicaConRecetaDigital()
        {
            // Preparacion (Arrange)
            List<MedicamentoDto> listaMedicamentos = new List<MedicamentoDto>
            {
                new MedicamentoDto("123", "Ibuprofeno 400", 2)  // MedicamentoDto con codigo, nombre y cantidad
            };
            string indicaciones = "Tomar una capsula cada 8 horas.";
            EvolucionClinica evolucion = new EvolucionClinica(informeEsperado, medico);

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