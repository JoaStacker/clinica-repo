using Castle.Core.Configuration;
using Clinica.Api.Services;
using Clinica.Api.Utils;
using Clinica.Dominio.Contratos;
using Clinica.Dominio.Dtos;
using Clinica.Dominio.Entidades;
using NSubstitute;
using System;
using System.Linq.Expressions;


[Binding]
public sealed class LoginStepDefinitions
{
    private IRepositorio<Usuario> _repositorioUsuarioMock;
    private IRepositorio<Medico> _repositorioMedicoMock;
    private IRepositorio<Persona> _repositorioPersonaMock;
    private ISesionUtils _utilsMock;
    private UsuarioServicio _usuarioServicio;
    private LoginDto _loginDto;
    private ServiceResponse _respuesta;
    private Sesion? _sesionResultante;
    private List<Usuario> _usuariosPreCargados;

    public LoginStepDefinitions()
    {
        // Inicializar los objetos necesarios para la prueba
        _repositorioUsuarioMock = Substitute.For<IRepositorio<Usuario>>();
        _repositorioMedicoMock = Substitute.For<IRepositorio<Medico>>();
        _repositorioPersonaMock = Substitute.For<IRepositorio<Persona>>();
        _utilsMock = Substitute.For<ISesionUtils>();

        _usuarioServicio = new UsuarioServicio(_repositorioUsuarioMock, _repositorioMedicoMock, _repositorioPersonaMock, _utilsMock);
    }

    [Given("que existen los siguientes usuarios medicos:")]
    public void GivenQueExistenLosSiguientesUsuariosMedicos(DataTable dataTable)
    {
        // Crear usuarios mock.
        _usuariosPreCargados = dataTable.Rows.Select(row => new Usuario
        {
            Email = row["email"],
            Clave = BCrypt.Net.BCrypt.HashPassword(row["clave"])
        }).ToList();

        // Hacer que el repositorio retorne este usuario cuando se llame a GetConFiltro.
        _repositorioUsuarioMock.GetTodos().Returns(_usuariosPreCargados);
    }

    [When("el medico ingresa el email {string} y la clave {string} e inicia sesion")]
    public async Task WhenElMedicoIngresaElEmailYLaContrasenaEIniciaSesion(string email, string clave)
    {
        _loginDto = new LoginDto { Email = email, Clave = clave};

        // Mokear la creacion del hash y token
        _utilsMock.GenerarJWT(Arg.Any<Usuario>()).Returns("mocked-jwt");

        _respuesta = await _usuarioServicio.AuthenticateUser(_loginDto);
        Assert.NotNull(_respuesta);
    }

    [Then("se debe crear una sesion para el usuario con dicho email y generar un token.")]
    public void ThenDeberiaCrearseUnaSesionParaElUsuarioConDichoEmailYGenerarUnToken_()
    {
        Assert.Equal(ServiceStatus.OK, _respuesta.Status);
        Assert.NotNull(_respuesta.Content);

        _sesionResultante = _respuesta.Content as Sesion;
        Assert.NotNull(_sesionResultante);

        _repositorioUsuarioMock.Received(1).Modificar(Arg.Any<Usuario>());
        _repositorioUsuarioMock.Received(1).ConfirmarCambios();

        Assert.NotNull(_sesionResultante.Token);
        Assert.NotEmpty(_sesionResultante.Token);
        Assert.Equal(_loginDto.Email, _sesionResultante.Usuario.Email);
    }

    [Then("no se debe crear una nueva sesion y mostrar un mensaje {string}.")]
    public void ThenNoSeDebeCrearUnaNuevaSesionYMostrarUnMensaje_(string mensaje)
    {
        Assert.Equal(ServiceStatus.ERROR, _respuesta.Status);
        Assert.Equal(mensaje, _respuesta.Message);
    }
}