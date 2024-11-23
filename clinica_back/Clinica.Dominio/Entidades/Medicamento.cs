using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Clinica.Dominio.Entidades
{
    public class Medicamento: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("medicamento_id")]
        public int MedicamentoID { get; set; }

        [Column("codigo")]
        [MaxLength(45)]
        public string Codigo { get; set; }

        [Column("nombre_comercial")]
        public string NombreComercial { get; set; }
        
        [Column("cantidad")]
        public double Cantidad { get; set; }

        [ForeignKey("RecetaDigital")]
        [Column("receta_digital_id")]
        public int RecetaDigitalID { get; set; }
        
        [JsonIgnore]
        public virtual RecetaDigital RecetaDigital { get; set; }
        
        public Medicamento() { }

        public Medicamento(string codigo, string nombreComercial, double cantidad)
        {
            Codigo = codigo;
            NombreComercial = nombreComercial;
            Cantidad = cantidad;
        }
    }
}
