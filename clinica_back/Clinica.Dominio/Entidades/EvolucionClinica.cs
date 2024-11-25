using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using Clinica.Dominio.Dtos;

namespace Clinica.Dominio.Entidades
{
    public class EvolucionClinica: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("evolucion_clinica_id")]
        public int EvolucionClinicaID { get; set; }

        [Column("informe")]
        public string Informe { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        [ForeignKey("Diagnostico")]
        [Column("diagnostico_id")]
        public int DiagnosticoID { get; set; }
        
        [ForeignKey("PedidoLaboratorio")]
        [Column("pedido_laboratorio_id")]
        public int? PedidoLaboratorioID { get; set; }

        [ForeignKey("RecetaDigital")]
        [Column("receta_digital_id")]
        public int? RecetaDigitalID { get; set; }
        
        [ForeignKey("Medico")]
        [Column("medico_id")]
        public int MedicoID { get; set; }
        
        // Navigation properties
        [JsonIgnore]// Navigation properties
        public virtual Diagnostico Diagnostico { get; set; }
        [JsonIgnore]// Navigation properties
        public virtual PedidoLaboratorio PedidoLaboratorio { get; set; }
        [JsonIgnore]// Navigation properties
        public virtual RecetaDigital RecetaDigital { get; set; }
        
        [JsonIgnore]// Navigation properties
        public virtual Medico Medico { get; set; }

        public EvolucionClinica() { }
        
        public EvolucionClinica(string informe, Medico medico)
        {
            Informe = informe;
            FechaDeCreacion = DateTime.Now;
            Medico = medico;
            MedicoID = medico.MedicoID;
        }

        public void ConPedidoLaboratorio(string textoPedidoLaboratorio)
        {
            PedidoLaboratorio = new PedidoLaboratorio(textoPedidoLaboratorio);
        }
        
        public void ConRecetaDigital(List<MedicamentoDto> medicamentos, string indicaciones)
        {
            RecetaDigital = new RecetaDigital(medicamentos, indicaciones);
        }
    }
}
