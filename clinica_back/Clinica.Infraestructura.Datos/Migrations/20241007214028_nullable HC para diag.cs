using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    /// <inheritdoc />
    public partial class nullableHCparadiag : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos");

            migrationBuilder.AlterColumn<int>(
                name: "historia_clinica_id",
                table: "diagnosticos",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos",
                column: "historia_clinica_id",
                principalTable: "historias_clinicas",
                principalColumn: "historia_clinica_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos");

            migrationBuilder.AlterColumn<int>(
                name: "historia_clinica_id",
                table: "diagnosticos",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos",
                column: "historia_clinica_id",
                principalTable: "historias_clinicas",
                principalColumn: "historia_clinica_id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
