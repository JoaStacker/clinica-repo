using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Enumeraciones;

namespace Clinica.Dominio.Entidades
{
    public class RecetaDigital: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("receta_digital_id")]
        public int RecetaDigitalID { get; set; }

        [Column("codigo_barras")]
        public string CodigoBarras { get; set; }

        [Column("codigo_qr")]
        public string CodigoQR { get; set; }

        [Column("dosis")]
        public string Indicaciones { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [Column("estado")] 
        public EstadoReceta Estado { get; set; } = EstadoReceta.ACTIVO;

        [ForeignKey("Medico")]
        [Column("medico_id")]
        public int MedicoID { get; set; }

        // [ForeignKey("EvolucionClinica")]
        // [Column("evolucion_clinica_id")]
        // public int EvolucionClinicaID { get; set; }

        // Navigation properties
        [JsonIgnore]// Navigation properties
        public virtual Medico Medico { get; set; }
        // [JsonIgnore]// Navigation properties
        // public virtual EvolucionClinica EvolucionClinica { get; set; }
        
        [JsonIgnore]
        public virtual ICollection<Medicamento> Medicamentos { get; set; } = new List<Medicamento>();

        public RecetaDigital() { }
        
        public RecetaDigital(List<MedicamentoDto> medicamentos, string indicaciones)
        {
            CodigoBarras = "7796569161254";
            CodigoQR = "-";
            Indicaciones = indicaciones;
            
            foreach (var medicamentoDto in medicamentos)
            {
                Medicamentos.Add(new Medicamento(medicamentoDto.Codigo, medicamentoDto.NombreComercial, medicamentoDto.Cantidad));
            }
        }
    }
}