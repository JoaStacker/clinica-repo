using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Clinica.Dominio.Dtos
{
    public class SignUpDto
    {
        public string Email { get; set; }
        public string Clave { get; set; }
        public int Matricula { get; set; }
        public string Especialidad { get; set; }
        public string Cuil { get; set; }
        public string Dni { get; set; }
        public DateTime FechaDeNacimiento { get; set; }
        public string Telefono { get; set; }
        public string NombreApellido { get; set; }
        public string Provincia { get; set; }
        public string Localidad { get; set; }
        public string Cop { get; set; }
        public string Calle { get; set; }
        public string Altura { get; set; }
        public string Piso { get; set; }
        public string Departamento { get; set; }
    }
}
