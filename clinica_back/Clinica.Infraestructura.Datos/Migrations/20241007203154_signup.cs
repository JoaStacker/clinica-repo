using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    /// <inheritdoc />
    public partial class signup : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_usuarios_personas_persona_id",
                table: "usuarios");

            migrationBuilder.RenameColumn(
                name: "persona_id",
                table: "usuarios",
                newName: "medico_id");

            migrationBuilder.RenameIndex(
                name: "IX_usuarios_persona_id",
                table: "usuarios",
                newName: "IX_usuarios_medico_id");

            migrationBuilder.AddForeignKey(
                name: "FK_usuarios_medicos_medico_id",
                table: "usuarios",
                column: "medico_id",
                principalTable: "medicos",
                principalColumn: "medico_id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_usuarios_medicos_medico_id",
                table: "usuarios");

            migrationBuilder.RenameColumn(
                name: "medico_id",
                table: "usuarios",
                newName: "persona_id");

            migrationBuilder.RenameIndex(
                name: "IX_usuarios_medico_id",
                table: "usuarios",
                newName: "IX_usuarios_persona_id");

            migrationBuilder.AddForeignKey(
                name: "FK_usuarios_personas_persona_id",
                table: "usuarios",
                column: "persona_id",
                principalTable: "personas",
                principalColumn: "persona_id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
