using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    /// <inheritdoc />
    public partial class mig001 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "direcciones",
                columns: table => new
                {
                    direccion_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    provincia = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    localidad = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    cop = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    calle = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    altura = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    piso = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    departamento = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_direcciones", x => x.direccion_id);
                });

            migrationBuilder.CreateTable(
                name: "historias_clinicas",
                columns: table => new
                {
                    historia_clinica_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    fecha_creacion = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_historias_clinicas", x => x.historia_clinica_id);
                });

            migrationBuilder.CreateTable(
                name: "personas",
                columns: table => new
                {
                    persona_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    cuil = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    dni = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    fecha_nacimiento = table.Column<DateTime>(type: "datetime2", nullable: false),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    telefono = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    nombre_apellido = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    direccion_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_personas", x => x.persona_id);
                    table.ForeignKey(
                        name: "FK_personas_direcciones_direccion_id",
                        column: x => x.direccion_id,
                        principalTable: "direcciones",
                        principalColumn: "direccion_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "diagnosticos",
                columns: table => new
                {
                    diagnostico_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    enfermedad = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    observaciones = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    fecha_creacion = table.Column<DateTime>(type: "datetime2", nullable: false),
                    historia_clinica_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_diagnosticos", x => x.diagnostico_id);
                    table.ForeignKey(
                        name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                        column: x => x.historia_clinica_id,
                        principalTable: "historias_clinicas",
                        principalColumn: "historia_clinica_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "medicos",
                columns: table => new
                {
                    medico_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    matricula = table.Column<int>(type: "int", nullable: false),
                    especialidad = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    persona_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_medicos", x => x.medico_id);
                    table.ForeignKey(
                        name: "FK_medicos_personas_persona_id",
                        column: x => x.persona_id,
                        principalTable: "personas",
                        principalColumn: "persona_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "pacientes",
                columns: table => new
                {
                    paciente_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    nro_afiliado = table.Column<int>(type: "int", nullable: false),
                    pasaporte = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    fecha_defuncion = table.Column<DateTime>(type: "datetime2", nullable: true),
                    estado = table.Column<int>(type: "int", nullable: false),
                    persona_id = table.Column<int>(type: "int", nullable: false),
                    historia_clinica_id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_pacientes", x => x.paciente_id);
                    table.ForeignKey(
                        name: "FK_pacientes_historias_clinicas_historia_clinica_id",
                        column: x => x.historia_clinica_id,
                        principalTable: "historias_clinicas",
                        principalColumn: "historia_clinica_id");
                    table.ForeignKey(
                        name: "FK_pacientes_personas_persona_id",
                        column: x => x.persona_id,
                        principalTable: "personas",
                        principalColumn: "persona_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "recepcionistas",
                columns: table => new
                {
                    recepcionista_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    persona_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_recepcionistas", x => x.recepcionista_id);
                    table.ForeignKey(
                        name: "FK_recepcionistas_personas_persona_id",
                        column: x => x.persona_id,
                        principalTable: "personas",
                        principalColumn: "persona_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "evoluciones_clinicas",
                columns: table => new
                {
                    evolucion_clinica_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    texto_libre = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    fecha_creacion = table.Column<DateTime>(type: "datetime2", nullable: false),
                    diagnostico_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_evoluciones_clinicas", x => x.evolucion_clinica_id);
                    table.ForeignKey(
                        name: "FK_evoluciones_clinicas_diagnosticos_diagnostico_id",
                        column: x => x.diagnostico_id,
                        principalTable: "diagnosticos",
                        principalColumn: "diagnostico_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "pedidos_laboratorio",
                columns: table => new
                {
                    pedido_laboratorio_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    texto_libre = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    fecha_creacion = table.Column<DateTime>(type: "datetime2", nullable: false),
                    evolucion_clinica_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_pedidos_laboratorio", x => x.pedido_laboratorio_id);
                    table.ForeignKey(
                        name: "FK_pedidos_laboratorio_evoluciones_clinicas_evolucion_clinica_id",
                        column: x => x.evolucion_clinica_id,
                        principalTable: "evoluciones_clinicas",
                        principalColumn: "evolucion_clinica_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "recetas_digitales",
                columns: table => new
                {
                    receta_digital_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    codigo_barras = table.Column<int>(type: "int", nullable: false),
                    codigo_qr = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    dosis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    fecha_creacion = table.Column<DateTime>(type: "datetime2", nullable: false),
                    estado = table.Column<int>(type: "int", nullable: false),
                    medico_id = table.Column<int>(type: "int", nullable: false),
                    evolucion_clinica_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_recetas_digitales", x => x.receta_digital_id);
                    table.ForeignKey(
                        name: "FK_recetas_digitales_evoluciones_clinicas_evolucion_clinica_id",
                        column: x => x.evolucion_clinica_id,
                        principalTable: "evoluciones_clinicas",
                        principalColumn: "evolucion_clinica_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_recetas_digitales_medicos_medico_id",
                        column: x => x.medico_id,
                        principalTable: "medicos",
                        principalColumn: "medico_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "medicamentos",
                columns: table => new
                {
                    medicamento_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    codigo = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    nombre_comercial = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RecetaDigitalID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_medicamentos", x => x.medicamento_id);
                    table.ForeignKey(
                        name: "FK_medicamentos_recetas_digitales_RecetaDigitalID",
                        column: x => x.RecetaDigitalID,
                        principalTable: "recetas_digitales",
                        principalColumn: "receta_digital_id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_diagnosticos_historia_clinica_id",
                table: "diagnosticos",
                column: "historia_clinica_id");

            migrationBuilder.CreateIndex(
                name: "IX_evoluciones_clinicas_diagnostico_id",
                table: "evoluciones_clinicas",
                column: "diagnostico_id");

            migrationBuilder.CreateIndex(
                name: "IX_medicamentos_RecetaDigitalID",
                table: "medicamentos",
                column: "RecetaDigitalID");

            migrationBuilder.CreateIndex(
                name: "IX_medicos_persona_id",
                table: "medicos",
                column: "persona_id");

            migrationBuilder.CreateIndex(
                name: "IX_pacientes_historia_clinica_id",
                table: "pacientes",
                column: "historia_clinica_id");

            migrationBuilder.CreateIndex(
                name: "IX_pacientes_persona_id",
                table: "pacientes",
                column: "persona_id");

            migrationBuilder.CreateIndex(
                name: "IX_pedidos_laboratorio_evolucion_clinica_id",
                table: "pedidos_laboratorio",
                column: "evolucion_clinica_id");

            migrationBuilder.CreateIndex(
                name: "IX_personas_direccion_id",
                table: "personas",
                column: "direccion_id");

            migrationBuilder.CreateIndex(
                name: "IX_recepcionistas_persona_id",
                table: "recepcionistas",
                column: "persona_id");

            migrationBuilder.CreateIndex(
                name: "IX_recetas_digitales_evolucion_clinica_id",
                table: "recetas_digitales",
                column: "evolucion_clinica_id");

            migrationBuilder.CreateIndex(
                name: "IX_recetas_digitales_medico_id",
                table: "recetas_digitales",
                column: "medico_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "medicamentos");

            migrationBuilder.DropTable(
                name: "pacientes");

            migrationBuilder.DropTable(
                name: "pedidos_laboratorio");

            migrationBuilder.DropTable(
                name: "recepcionistas");

            migrationBuilder.DropTable(
                name: "recetas_digitales");

            migrationBuilder.DropTable(
                name: "evoluciones_clinicas");

            migrationBuilder.DropTable(
                name: "medicos");

            migrationBuilder.DropTable(
                name: "diagnosticos");

            migrationBuilder.DropTable(
                name: "personas");

            migrationBuilder.DropTable(
                name: "historias_clinicas");

            migrationBuilder.DropTable(
                name: "direcciones");
        }
    }
}
