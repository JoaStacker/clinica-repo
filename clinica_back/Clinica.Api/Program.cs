using Clinica.Infraestructura.Datos;
using Clinica.Dominio.Entidades;
using Microsoft.EntityFrameworkCore;
using Clinica.Dominio.Contratos;
using Clinica.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Por si necesitamos un puerto especifico.
//builder.WebHost.UseUrls("http://*:80"); // Bind to port 8080

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


// Database Context Dependency Injection con variables de entorno.
//var dbHost = Environment.GetEnvironmentVariable("DB_HOST");
//var dbName = Environment.GetEnvironmentVariable("DB_NAME");
//var dbPassword = Environment.GetEnvironmentVariable("DB_SA_PASSWORD");
var dbHost = "localhost,8002";
var dbName = "dbclinica";
var dbPassword = "password@12345#";
var connectionString = $"Data Source={dbHost};Initial Catalog={dbName};User ID=sa;Password={dbPassword};TrustServerCertificate=True;MultipleActiveResultSets=true";
builder.Services.AddDbContext<ClinicaContext>(opt => { 
    opt.UseSqlServer(connectionString); 
    opt.UseLazyLoadingProxies(); 
});

// Database Context Dependency Injection con connection string directo.
//builder.Services.AddDbContext<ClinicaContext>(opt => opt.UseSqlServer(builder.Configuration.GetConnectionString("ClinicaConnection")));

// Agregar repositorio de datos.
builder.Services.AddScoped<IRepositorio<EntidadBase>, Repositorio<EntidadBase>>();

// Agregar sevicios.
builder.Services.AddScoped<IPacienteServicio, PacienteServicio>();

// Agregar controladores a los servicios.
builder.Services.AddControllers();

var app = builder.Build();

// Al momento de iniciar el proyecto se ejecuta la migracion por si tengo nuevos cambios.
//using (var scope = app.Services.CreateScope())
//{
//    var context = scope.ServiceProvider.GetRequiredService<ClinicaContext>();
//    context.Database.Migrate();
//}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseDeveloperExceptionPage();
}

app.UseRouting();
app.UseHttpsRedirection();
app.MapControllers(); // Important for attribute routing
app.Run();
