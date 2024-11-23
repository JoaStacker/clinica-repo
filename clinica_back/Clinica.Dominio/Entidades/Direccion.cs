using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Clinica.Dominio.Entidades
{
    public class Direccion: EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("direccion_id")]
        public int DireccionID { get; set; }  // Made private to prevent external modification

        [Column("provincia")]
        public string Provincia { get; set; }

        [Column("localidad")]
        public string Localidad { get; set; }

        [Column("cop")]
        public string Cop { get; set; }

        [Column("calle")]
        public string Calle { get; set; }

        [Column("altura")]
        public string Altura { get; set; }

        [Column("piso")]
        public string Piso { get; set; }

        [Column("departamento")]
        public string Departamento { get; set; }
        
        public Direccion() { }
    }
}
