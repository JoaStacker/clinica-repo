using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Clinica.Dominio.Entidades
{
    public class Medicamento: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("medicamento_id")]
        public int MedicamentoID { get; set; }

        [Column("codigo")]
        public string Codigo { get; set; }

        [Column("nombre_comercial")]
        public string NombreComercial { get; set; }
    }
}
