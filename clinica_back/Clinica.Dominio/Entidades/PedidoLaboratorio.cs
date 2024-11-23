using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Clinica.Dominio.Entidades
{
    public class PedidoLaboratorio
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("pedido_laboratorio_id")]
        public int PedidoLaboratorioID { get; set; }

        [Column("texto_libre")]
        public string TextoLibre { get; set; }

        [Column("fecha_creacion")]
        public DateTime FechaDeCreacion { get; set; }

        public PedidoLaboratorio() { }

        public PedidoLaboratorio(string textoLibre)
        {
            TextoLibre = textoLibre;
            FechaDeCreacion = DateTime.Now;
        }
    }
}