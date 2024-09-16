using Microsoft.EntityFrameworkCore;

namespace Dominio.Entidades
{
    public class ClinicaContext : DbContext
    {
        public ClinicaContext(DbContextOptions<ClinicaContext> options) : base(options)
        {

        }

        public DbSet<HistoriaClinica> HistoriasClinicas { get; set; }

        public DbSet<Diagnostico> Diagnosticos { get; set; }

        public DbSet<EvolucionClinica> EvolucionesClinicas { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<HistoriaClinica>().ToTable("historia_clinica");
            modelBuilder.Entity<Diagnostico>().ToTable("diagnostico");
            modelBuilder.Entity<EvolucionClinica>().ToTable("evolucion_clinica");
        }
    }
}
