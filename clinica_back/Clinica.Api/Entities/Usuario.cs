using System.ComponentModel.DataAnnotations;

namespace Clinica.Api.Entities
{
    public class Usuario
    {
        [Key]
        public int UsuarioId { get; set; }

        [Required]
        public string Clave { get; set; }

        [Required]
        public string Email { get; set; }

        // Foreign key to Persona (Medico or Recepcionista)
        public int? MedicoId { get; set; }  // Para relacionar con Medico
        public int? RecepcionistaId { get; set; }  // Para relacionar con Recepcionista
    }
}
