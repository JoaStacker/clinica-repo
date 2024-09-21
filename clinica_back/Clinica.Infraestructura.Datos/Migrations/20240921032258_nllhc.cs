using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    /// <inheritdoc />
    public partial class nllhc : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "historia_clinica_id",
                table: "pacientes",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_pacientes_historia_clinica_id",
                table: "pacientes",
                column: "historia_clinica_id");

            migrationBuilder.AddForeignKey(
                name: "FK_pacientes_historias_clinicas_historia_clinica_id",
                table: "pacientes",
                column: "historia_clinica_id",
                principalTable: "historias_clinicas",
                principalColumn: "historia_clinica_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_pacientes_historias_clinicas_historia_clinica_id",
                table: "pacientes");

            migrationBuilder.DropIndex(
                name: "IX_pacientes_historia_clinica_id",
                table: "pacientes");

            migrationBuilder.DropColumn(
                name: "historia_clinica_id",
                table: "pacientes");
        }
    }
}
