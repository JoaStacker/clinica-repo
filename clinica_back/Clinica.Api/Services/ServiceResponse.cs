using Microsoft.AspNetCore.Http;

namespace Clinica.Api.Services
{
    public class ServiceResponse
    {

        public bool Ok { get; set; }
        public int StatusCode { get; set; }
        public string Error { get; set; }
        public ServiceResponse(bool ok, int status_code, string error)
        {
            Ok = ok;
            StatusCode = status_code;
            Error = error;
        }
    }
}
