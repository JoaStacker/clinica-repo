using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    /// <inheritdoc />
    public partial class evolucionConMedico : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "medico_id",
                table: "evoluciones_clinicas",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_evoluciones_clinicas_medico_id",
                table: "evoluciones_clinicas",
                column: "medico_id");

            migrationBuilder.AddForeignKey(
                name: "FK_evoluciones_clinicas_medicos_medico_id",
                table: "evoluciones_clinicas",
                column: "medico_id",
                principalTable: "medicos",
                principalColumn: "medico_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_evoluciones_clinicas_medicos_medico_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropIndex(
                name: "IX_evoluciones_clinicas_medico_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropColumn(
                name: "medico_id",
                table: "evoluciones_clinicas");
        }
    }
}
