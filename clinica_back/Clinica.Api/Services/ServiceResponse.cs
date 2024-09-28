using Azure;
using Clinica.Dominio.Contratos;
using Clinica.Dominio.Entidades;
using Microsoft.AspNetCore.Http;

namespace Clinica.Api.Services
{
    public class ServiceResponse
    {
        public ServiceStatus Status { get; set; }
        public int StatusCode { get; set; }
        public string Message { get; set; }

        public object? Content { get; set; } = null;

        public ServiceResponse(ServiceStatus status, int statusCode, string message, object? content=null)
        {
            Status = status;
            StatusCode = statusCode;
            Message = message;
            Content = content;
        }
    }
}
