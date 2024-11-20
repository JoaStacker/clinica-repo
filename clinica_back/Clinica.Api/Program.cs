using Clinica.Infraestructura.Datos;
using Clinica.Dominio.Entidades;
using Microsoft.EntityFrameworkCore;
using Clinica.Dominio.Contratos;
using Clinica.Api.Services;
using DotNetEnv;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Clinica.Api.Utils;
using Microsoft.EntityFrameworkCore.Diagnostics;

// Load environment variables from .env file
Env.Load();

var builder = WebApplication.CreateBuilder(args);

// Configure CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins",
        builder => builder.AllowAnyOrigin() // Allow any origin
                          .AllowAnyMethod() // Allow any method
                          .AllowAnyHeader()); // Allow any header
});

// Por si necesitamos un puerto especifico.
builder.WebHost.UseUrls("http://*:5146"); // Bind to port 5146

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


// Database Context Dependency Injection con variables de entorno.
//var dbHost = "localhost";/*Environment.GetEnvironmentVariable("DB_HOST")*/
//var dbPort = "8002"/*Environment.GetEnvironmentVariable("DB_PORT")*/;
//var dbName = "dbclinica"/*Environment.GetEnvironmentVariable("DB_NAME")*/;
//var dbUser = "sa"/*Environment.GetEnvironmentVariable("DB_USER")*/;
//var dbPassword = "password@12345#";
// Database Context Dependency Injection con variables de entorno.
var dbHost = Environment.GetEnvironmentVariable("DB_HOST");
var dbPort = Environment.GetEnvironmentVariable("DB_PORT");
var dbName = Environment.GetEnvironmentVariable("DB_NAME");
var dbUser = Environment.GetEnvironmentVariable("DB_USER");
var dbPassword = Environment.GetEnvironmentVariable("DB_SA_PASSWORD");
var jwtKey = Environment.GetEnvironmentVariable("JWT_KEY");

if (string.IsNullOrEmpty(dbHost) || string.IsNullOrEmpty(dbName) || string.IsNullOrEmpty(dbPassword) || string.IsNullOrEmpty(dbPort))
{
    throw new InvalidOperationException("Required environment variables are missing: DB_HOST, DB_NAME, DB_SA_PASSWORD, DB_PORT.");
}

var dbSource = $"{dbHost},{dbPort}";
var connectionString = $"Data Source={dbSource};Initial Catalog={dbName};User ID={dbUser};Password={dbPassword};TrustServerCertificate=True;MultipleActiveResultSets=true";
builder.Services.AddDbContext<ClinicaContext>(opt => { 
    opt.UseSqlServer(connectionString);
    opt.UseLazyLoadingProxies();
});

builder.Services.AddSingleton<Utils>();

builder.Services.AddAuthentication(config =>{
    config.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    config.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(config =>
{
    config.RequireHttpsMetadata = false;
    config.SaveToken = true;
    if (string.IsNullOrEmpty(jwtKey))
    {
        throw new Exception("JWT key is not configured properly.");
    }

    config.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        ValidateIssuer = false,
        ValidateAudience = false,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.Zero,
    IssuerSigningKey = new SymmetricSecurityKey
        (Encoding.UTF8.GetBytes(jwtKey))
    };
});

// Database Context Dependency Injection con connection string directo.
//builder.Services.AddDbContext<ClinicaContext>(opt => opt.UseSqlServer(builder.Configuration.GetConnectionString("ClinicaConnection")));

// Agregar repositorio de datos.
builder.Services.AddScoped<IRepositorio<EntidadBase>, Repositorio<EntidadBase>>();

// Agregar sevicios.
builder.Services.AddScoped<ISistemaServicio, SistemaServicio>();
builder.Services.AddScoped<IUsuarioServicio, UsuarioServicio>();

// Agregar controladores a los servicios.
builder.Services.AddControllers();

var app = builder.Build();

// Al momento de iniciar el proyecto se ejecuta la migracion por si tengo nuevos cambios.
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<ClinicaContext>();
    context.Database.Migrate();
}

// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
app.UseSwagger();
app.UseSwaggerUI();
app.UseDeveloperExceptionPage();
//}

app.UseRouting();
// Use CORS policy
app.UseCors("AllowAllOrigins");
// Other middleware
// descomentar esto cuando se use autenticacion.
//app.UseAuthorization();
app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers(); // Important for attribute routing
app.Run();


// Migration commands
//Enable-Migrations
//Add-Migration <Name>
//Update-Database