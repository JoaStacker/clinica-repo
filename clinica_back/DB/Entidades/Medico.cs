using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Dominio.Entidades
{
    public class Medico : Persona
    {
        [Column("matricula")]
        public int Matricula { get; set; }

        [Column("especialidad")]
        public string Especialidad { get; set; }
    }
}
