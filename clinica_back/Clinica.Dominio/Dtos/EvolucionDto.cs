using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clinica.Dominio.Dtos
{
    public class EvolucionDto
    {
        public int DiagnosticoId { get; set; }

        public string TextoLibre { get; set; }

    }
}
