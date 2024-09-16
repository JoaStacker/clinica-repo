using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Dominio.Enumeraciones;

namespace Dominio.Entidades
{
    public class Paciente : Persona
    {
        [Column("nro_afiliado")]
        public int NroAfiliado { get; set; }

        [Column("pasaporte")]
        public string Pasaporte { get; set; }

        [Column("fecha_defuncion")]
        public DateTime FechaDefuncion { get; set; }

        [Column("estado")]
        public EstadoPaciente Estado { get; set; }
    }
}
