using System.Text.Json.Serialization;

namespace Clinica.Dominio.Dtos
{
    public class PacienteDto
    {
        [JsonPropertyName("nro_afiliado")]
        public int NroAfiliado { get; set; }

        [JsonPropertyName("pasaporte")]
        public string Pasaporte { get; set; }

        [JsonPropertyName("cuil")]
        public string Cuil { get; set; }

        [JsonPropertyName("dni")]
        public string Dni { get; set; }

        [JsonPropertyName("fecha_nacimiento")]
        public DateTime FechaNacimiento { get; set; }

        [JsonPropertyName("email")]
        public string Email { get; set; }

        [JsonPropertyName("telefono")]
        public string Telefono { get; set; }

        [JsonPropertyName("nombre_apellido")]
        public string NombreApellido { get; set; }

        [JsonPropertyName("provincia")]
        public string Provincia { get; set; }

        [JsonPropertyName("localidad")]
        public string Localidad { get; set; }

        [JsonPropertyName("cop")]
        public string Cop { get; set; }

        [JsonPropertyName("calle")]
        public string Calle { get; set; }

        [JsonPropertyName("altura")]
        public string Altura { get; set; }

        [JsonPropertyName("fecha_defuncion")]
        public DateTime? FechaDefuncion { get; set; }

        [JsonPropertyName("piso")]
        public string Piso { get; set; }

        [JsonPropertyName("departamento")]
        public string Departamento { get; set; }
    }
}
