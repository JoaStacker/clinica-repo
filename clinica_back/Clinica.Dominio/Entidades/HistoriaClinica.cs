using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Clinica.Dominio.Dtos;

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
        public virtual ICollection<Diagnostico> Diagnosticos { get; set; } = new HashSet<Diagnostico>();

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

        public List<EvolucionClinica> buscarEvoluciones()
        {
            return Diagnosticos.SelectMany(d => d.EvolucionesClinicas).ToList(); 
        } 
    }
}
