﻿// <auto-generated />
using System;
using Clinica.Infraestructura.Datos;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    [DbContext(typeof(ClinicaContext))]
    [Migration("20240928015941_mig-002")]
    partial class mig002
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.8")
                .HasAnnotation("Proxies:ChangeTracking", false)
                .HasAnnotation("Proxies:CheckEquality", false)
                .HasAnnotation("Proxies:LazyLoading", true)
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("Clinica.Dominio.Entidades.Diagnostico", b =>
                {
                    b.Property<int>("DiagnosticoID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("diagnostico_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("DiagnosticoID"));

                    b.Property<string>("Enfermedad")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)")
                        .HasColumnName("enfermedad");

                    b.Property<DateTime>("FechaDeCreacion")
                        .HasColumnType("datetime2")
                        .HasColumnName("fecha_creacion");

                    b.Property<int>("HistoriaClinicaID")
                        .HasColumnType("int")
                        .HasColumnName("historia_clinica_id");

                    b.Property<string>("Observaciones")
                        .IsRequired()
                        .HasMaxLength(500)
                        .HasColumnType("nvarchar(500)")
                        .HasColumnName("observaciones");

                    b.HasKey("DiagnosticoID");

                    b.HasIndex("HistoriaClinicaID");

                    b.ToTable("diagnosticos", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Direccion", b =>
                {
                    b.Property<int>("DireccionID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("direccion_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("DireccionID"));

                    b.Property<string>("Altura")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("altura");

                    b.Property<string>("Calle")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("calle");

                    b.Property<string>("Cop")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("cop");

                    b.Property<string>("Departamento")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("departamento");

                    b.Property<string>("Localidad")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("localidad");

                    b.Property<string>("Piso")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("piso");

                    b.Property<string>("Provincia")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("provincia");

                    b.HasKey("DireccionID");

                    b.ToTable("direcciones", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.EvolucionClinica", b =>
                {
                    b.Property<int>("EvolucionClinicaID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("evolucion_clinica_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("EvolucionClinicaID"));

                    b.Property<int>("DiagnosticoID")
                        .HasColumnType("int")
                        .HasColumnName("diagnostico_id");

                    b.Property<DateTime>("FechaDeCreacion")
                        .HasColumnType("datetime2")
                        .HasColumnName("fecha_creacion");

                    b.Property<string>("TextoLibre")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("texto_libre");

                    b.HasKey("EvolucionClinicaID");

                    b.HasIndex("DiagnosticoID");

                    b.ToTable("evoluciones_clinicas", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.HistoriaClinica", b =>
                {
                    b.Property<int>("HistoriaClinicaID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("historia_clinica_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("HistoriaClinicaID"));

                    b.Property<DateTime>("FechaDeCreacion")
                        .HasColumnType("datetime2")
                        .HasColumnName("fecha_creacion");

                    b.HasKey("HistoriaClinicaID");

                    b.ToTable("historias_clinicas", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Medicamento", b =>
                {
                    b.Property<int>("MedicamentoID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("medicamento_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("MedicamentoID"));

                    b.Property<string>("Codigo")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("codigo");

                    b.Property<string>("NombreComercial")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("nombre_comercial");

                    b.Property<int?>("RecetaDigitalID")
                        .HasColumnType("int");

                    b.HasKey("MedicamentoID");

                    b.HasIndex("RecetaDigitalID");

                    b.ToTable("medicamentos", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Medico", b =>
                {
                    b.Property<int>("MedicoID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("medico_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("MedicoID"));

                    b.Property<string>("Especialidad")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("especialidad");

                    b.Property<int>("Matricula")
                        .HasColumnType("int")
                        .HasColumnName("matricula");

                    b.Property<int>("PersonaID")
                        .HasColumnType("int")
                        .HasColumnName("persona_id");

                    b.HasKey("MedicoID");

                    b.HasIndex("PersonaID");

                    b.ToTable("medicos", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Paciente", b =>
                {
                    b.Property<int>("PacienteID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("paciente_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PacienteID"));

                    b.Property<int>("Estado")
                        .HasColumnType("int")
                        .HasColumnName("estado");

                    b.Property<DateTime?>("FechaDefuncion")
                        .HasColumnType("datetime2")
                        .HasColumnName("fecha_defuncion");

                    b.Property<int?>("HistoriaClinicaID")
                        .HasColumnType("int")
                        .HasColumnName("historia_clinica_id");

                    b.Property<int>("NroAfiliado")
                        .HasColumnType("int")
                        .HasColumnName("nro_afiliado");

                    b.Property<string>("Pasaporte")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("pasaporte");

                    b.Property<int>("PersonaID")
                        .HasColumnType("int")
                        .HasColumnName("persona_id");

                    b.HasKey("PacienteID");

                    b.HasIndex("HistoriaClinicaID");

                    b.HasIndex("PersonaID");

                    b.ToTable("pacientes", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.PedidoLaboratorio", b =>
                {
                    b.Property<int>("PedidoLaboratorioID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("pedido_laboratorio_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PedidoLaboratorioID"));

                    b.Property<int>("EvolucionClinicaID")
                        .HasColumnType("int")
                        .HasColumnName("evolucion_clinica_id");

                    b.Property<DateTime>("FechaDeCreacion")
                        .HasColumnType("datetime2")
                        .HasColumnName("fecha_creacion");

                    b.Property<string>("TextoLibre")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("texto_libre");

                    b.HasKey("PedidoLaboratorioID");

                    b.HasIndex("EvolucionClinicaID");

                    b.ToTable("pedidos_laboratorio", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Persona", b =>
                {
                    b.Property<int>("PersonaID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("persona_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PersonaID"));

                    b.Property<string>("Cuil")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("cuil");

                    b.Property<int>("DireccionID")
                        .HasColumnType("int")
                        .HasColumnName("direccion_id");

                    b.Property<string>("Dni")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("dni");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("email");

                    b.Property<DateTime>("FechaDeNacimiento")
                        .HasColumnType("datetime2")
                        .HasColumnName("fecha_nacimiento");

                    b.Property<string>("NombreApellido")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("nombre_apellido");

                    b.Property<string>("Telefono")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("telefono");

                    b.HasKey("PersonaID");

                    b.HasIndex("DireccionID");

                    b.ToTable("personas", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Recepcionista", b =>
                {
                    b.Property<int>("RecepcionistaID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("recepcionista_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RecepcionistaID"));

                    b.Property<int>("PersonaID")
                        .HasColumnType("int")
                        .HasColumnName("persona_id");

                    b.HasKey("RecepcionistaID");

                    b.HasIndex("PersonaID");

                    b.ToTable("recepcionistas", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.RecetaDigital", b =>
                {
                    b.Property<int>("RecetaDigitalID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("receta_digital_id");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RecetaDigitalID"));

                    b.Property<int>("CodigoBarras")
                        .HasColumnType("int")
                        .HasColumnName("codigo_barras");

                    b.Property<string>("CodigoQR")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("codigo_qr");

                    b.Property<string>("Dosis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("dosis");

                    b.Property<int>("Estado")
                        .HasColumnType("int")
                        .HasColumnName("estado");

                    b.Property<int>("EvolucionClinicaID")
                        .HasColumnType("int")
                        .HasColumnName("evolucion_clinica_id");

                    b.Property<DateTime>("FechaDeCreacion")
                        .HasColumnType("datetime2")
                        .HasColumnName("fecha_creacion");

                    b.Property<int>("MedicoID")
                        .HasColumnType("int")
                        .HasColumnName("medico_id");

                    b.HasKey("RecetaDigitalID");

                    b.HasIndex("EvolucionClinicaID");

                    b.HasIndex("MedicoID");

                    b.ToTable("recetas_digitales", (string)null);
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Diagnostico", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.HistoriaClinica", "HistoriaClinica")
                        .WithMany("Diagnosticos")
                        .HasForeignKey("HistoriaClinicaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("HistoriaClinica");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.EvolucionClinica", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.Diagnostico", "Diagnostico")
                        .WithMany("EvolucionesClinicas")
                        .HasForeignKey("DiagnosticoID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Diagnostico");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Medicamento", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.RecetaDigital", null)
                        .WithMany("Medicamentos")
                        .HasForeignKey("RecetaDigitalID");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Medico", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.Persona", "Persona")
                        .WithMany()
                        .HasForeignKey("PersonaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Persona");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Paciente", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.HistoriaClinica", "HistoriaClinica")
                        .WithMany()
                        .HasForeignKey("HistoriaClinicaID");

                    b.HasOne("Clinica.Dominio.Entidades.Persona", "Persona")
                        .WithMany()
                        .HasForeignKey("PersonaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("HistoriaClinica");

                    b.Navigation("Persona");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.PedidoLaboratorio", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.EvolucionClinica", "EvolucionClinica")
                        .WithMany()
                        .HasForeignKey("EvolucionClinicaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("EvolucionClinica");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Persona", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.Direccion", "Direccion")
                        .WithMany()
                        .HasForeignKey("DireccionID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Direccion");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Recepcionista", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.Persona", "Persona")
                        .WithMany()
                        .HasForeignKey("PersonaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Persona");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.RecetaDigital", b =>
                {
                    b.HasOne("Clinica.Dominio.Entidades.EvolucionClinica", "EvolucionClinica")
                        .WithMany()
                        .HasForeignKey("EvolucionClinicaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Clinica.Dominio.Entidades.Medico", "Medico")
                        .WithMany()
                        .HasForeignKey("MedicoID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("EvolucionClinica");

                    b.Navigation("Medico");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.Diagnostico", b =>
                {
                    b.Navigation("EvolucionesClinicas");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.HistoriaClinica", b =>
                {
                    b.Navigation("Diagnosticos");
                });

            modelBuilder.Entity("Clinica.Dominio.Entidades.RecetaDigital", b =>
                {
                    b.Navigation("Medicamentos");
                });
#pragma warning restore 612, 618
        }
    }
}
