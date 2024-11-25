using Clinica.Dominio.Entidades;

namespace Clinica.Api.Utils
{
    public interface ISesionUtils
    {
        string EncriptarSHA256(string texto);
        string GenerarJWT(Usuario modelo);
    }
}
