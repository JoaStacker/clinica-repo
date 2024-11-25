using Clinica.Dominio.Entidades;
using Clinica.Dominio.Dtos;

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
            Assert.Equal(informeEsperado, nuevaEvolucion.Informe);
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
            Assert.Equal(informeEsperado, evolucion.Informe);
            Assert.NotNull(evolucion.PedidoLaboratorio);
            Assert.Equal(textoPedidoLaboratorio, evolucion.PedidoLaboratorio.TextoLibre);
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
            Assert.Equal(informeEsperado, evolucion.Informe);
            Assert.NotNull(evolucion.RecetaDigital);
            Assert.Equal(indicaciones, evolucion.RecetaDigital.Indicaciones);
            Assert.Equal(listaMedicamentos.Count, evolucion.RecetaDigital.Medicamentos.Count);

            // Verificar que cada medicamento en RecetaDigital tiene los mismos valores que el MedicamentoDto correspondiente
            for (int i = 0; i < listaMedicamentos.Count; i++)
            {
                var medicamentoDto = listaMedicamentos[i];
                var medicamento = evolucion.RecetaDigital.Medicamentos.ElementAt(i);

                Assert.Equal(medicamentoDto.Codigo, medicamento.Codigo);
                Assert.Equal(medicamentoDto.NombreComercial, medicamento.NombreComercial);
                Assert.Equal(medicamentoDto.Cantidad, medicamento.Cantidad);
            }
        }
    }
}