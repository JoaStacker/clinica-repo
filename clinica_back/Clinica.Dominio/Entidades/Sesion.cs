using Clinica.Dominio.Dtos;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Clinica.Dominio.Entidades
{
    public class Sesion : EntidadBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("paciente_id")]
        public int SesionID { get; set; }

        [Column("token")]
        public string Token { get; set; }

        [ForeignKey("Usuario")]
        [Column("usuario_id")]
        public int UsuarioID { get; set; }

        // Propiedad de navegació
        [JsonIgnore]
        public virtual Usuario Usuario { get; set; }

        public Sesion() { }
        
        public Sesion(string token)
        {
            Token = token;
        }
    }

}
