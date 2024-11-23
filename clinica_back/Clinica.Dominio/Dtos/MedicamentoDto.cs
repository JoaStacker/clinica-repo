namespace Clinica.Dominio.Dtos;

public class MedicamentoDto
{
    public string Codigo { get; set; }  // Código del medicamento
    public string NombreComercial { get; set; }  // Nombre comercial del medicamento
    public double Cantidad { get; set; }   // Cantidad del medicamento

    public MedicamentoDto(string codigo, string nombreComercial, double cantidad)
    {
        Codigo = codigo;
        NombreComercial = nombreComercial;
        Cantidad = cantidad;
    }
}