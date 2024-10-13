using Microsoft.EntityFrameworkCore;
using Clinica.Dominio.Entidades;

namespace Clinica.Infraestructura.Datos
{
    public class ClinicaContext : DbContext
    {
        public ClinicaContext(DbContextOptions<ClinicaContext> options) : base(options)
        {
        }
        
         
        public DbSet<HistoriaClinica> HistoriasClinicas { get; set; }

        public DbSet<Diagnostico> Diagnosticos { get; set; }

        public DbSet<EvolucionClinica> EvolucionesClinicas { get; set; }

        public DbSet<PedidoLaboratorio> PedidosLaboratorio { get; set; }

        public DbSet<RecetaDigital> RecetasDigitales { get; set; }

        public DbSet<Medicamento> Medicamentos { get; set; }

        public DbSet<Medico> Medicos { get; set; }

        public DbSet<Paciente> Pacientes { get; set; }

        public DbSet<Recepcionista> Recepcionistas { get; set; }

        public DbSet<Persona> Personas { get; set; }

        public DbSet<Direccion> Direcciones { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<HistoriaClinica>().ToTable("historias_clinicas");
            modelBuilder.Entity<Diagnostico>().ToTable("diagnosticos");
            modelBuilder.Entity<EvolucionClinica>().ToTable("evoluciones_clinicas");
            modelBuilder.Entity<PedidoLaboratorio>().ToTable("pedidos_laboratorio");
            modelBuilder.Entity<RecetaDigital>().ToTable("recetas_digitales");
            modelBuilder.Entity<Medicamento>().ToTable("medicamentos");
            modelBuilder.Entity<Medico>().ToTable("medicos");
            modelBuilder.Entity<Paciente>().ToTable("pacientes");
            modelBuilder.Entity<Recepcionista>().ToTable("recepcionistas");
            modelBuilder.Entity<Persona>().ToTable("personas");
            modelBuilder.Entity<Direccion>().ToTable("direcciones");
            modelBuilder.Entity<Usuario>().ToTable("usuarios");

            // Si necesito evitar propiedades.
            //modelBuilder.Entity<Class>().Ignore(p => p.Prop);
        }
    }
}
