namespace Clinica.Api.Entities
{
    public class Paciente : Persona
    {
        public int NroAfiliado { get; set; }
        public int NroPasaporte { get; set; }
        public DateTime FechaDefunsion { get; set; }
        public bool Estado { get; set; }
    }
}
