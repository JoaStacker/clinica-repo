using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clinica.Dominio.Dtos
{
    public class UsuarioLoginDto
    {
        public string Email { get; set; }
        public string Token { get; set; }
    }
}
