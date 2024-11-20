using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clinica.Dominio.Dtos
{
    public class DiagnosticoDto
    {
        public string Enfermedad { get; set; }
        public string Observaciones { get; set; }
    }
}
