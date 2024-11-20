using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Clinica.Dominio.Dtos;
using Microsoft.EntityFrameworkCore;

namespace Clinica.Dominio.Entidades
{
    public class HistoriaClinica: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("historia_clinica_id")]
        public int HistoriaClinicaID { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        // Navigation properties
        [JsonIgnore]
        public virtual ICollection<Diagnostico> Diagnosticos { get; set; } = new HashSet<Diagnostico>();

        public HistoriaClinica() {
            FechaDeCreacion = DateTime.Now;
        }

        public void agregarEvolucion(EvolucionDto evolucionDto)
        {
            var diagnostico = Diagnosticos.FirstOrDefault(d => d.DiagnosticoID == evolucionDto.DiagnosticoId);

            if (diagnostico != null)
            {
                diagnostico.agregarEvolucion(evolucionDto);
            }
            else
            {
                throw new Exception("Diagnóstico no encontrado.");
            }
        }

        public void agregarDiagnostico(DiagnosticoDto diagnosticoDto)
        {
            Diagnostico diagnostico = new Diagnostico
            (
                diagnosticoDto.Enfermedad,
                diagnosticoDto.Observaciones
            );
            Diagnosticos.Add(diagnostico);
        }

        public List<Diagnostico> buscarDiagnosticos()
        {
            return Diagnosticos.ToList();
        }
    }
}
