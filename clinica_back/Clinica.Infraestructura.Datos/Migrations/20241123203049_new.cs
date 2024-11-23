using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    /// <inheritdoc />
    public partial class @new : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_evoluciones_clinicas_medicos_medico_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropForeignKey(
                name: "FK_medicamentos_recetas_digitales_RecetaDigitalID",
                table: "medicamentos");

            migrationBuilder.DropForeignKey(
                name: "FK_recetas_digitales_medicos_medico_id",
                table: "recetas_digitales");

            migrationBuilder.RenameColumn(
                name: "medico_id",
                table: "recetas_digitales",
                newName: "MedicoID");

            migrationBuilder.RenameIndex(
                name: "IX_recetas_digitales_medico_id",
                table: "recetas_digitales",
                newName: "IX_recetas_digitales_MedicoID");

            migrationBuilder.RenameColumn(
                name: "RecetaDigitalID",
                table: "medicamentos",
                newName: "receta_digital_id");

            migrationBuilder.RenameIndex(
                name: "IX_medicamentos_RecetaDigitalID",
                table: "medicamentos",
                newName: "IX_medicamentos_receta_digital_id");

            migrationBuilder.AlterColumn<int>(
                name: "MedicoID",
                table: "recetas_digitales",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "receta_digital_id",
                table: "medicamentos",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "medico_id",
                table: "evoluciones_clinicas",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_evoluciones_clinicas_medicos_medico_id",
                table: "evoluciones_clinicas",
                column: "medico_id",
                principalTable: "medicos",
                principalColumn: "medico_id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_medicamentos_recetas_digitales_receta_digital_id",
                table: "medicamentos",
                column: "receta_digital_id",
                principalTable: "recetas_digitales",
                principalColumn: "receta_digital_id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_recetas_digitales_medicos_MedicoID",
                table: "recetas_digitales",
                column: "MedicoID",
                principalTable: "medicos",
                principalColumn: "medico_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_evoluciones_clinicas_medicos_medico_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropForeignKey(
                name: "FK_medicamentos_recetas_digitales_receta_digital_id",
                table: "medicamentos");

            migrationBuilder.DropForeignKey(
                name: "FK_recetas_digitales_medicos_MedicoID",
                table: "recetas_digitales");

            migrationBuilder.RenameColumn(
                name: "MedicoID",
                table: "recetas_digitales",
                newName: "medico_id");

            migrationBuilder.RenameIndex(
                name: "IX_recetas_digitales_MedicoID",
                table: "recetas_digitales",
                newName: "IX_recetas_digitales_medico_id");

            migrationBuilder.RenameColumn(
                name: "receta_digital_id",
                table: "medicamentos",
                newName: "RecetaDigitalID");

            migrationBuilder.RenameIndex(
                name: "IX_medicamentos_receta_digital_id",
                table: "medicamentos",
                newName: "IX_medicamentos_RecetaDigitalID");

            migrationBuilder.AlterColumn<int>(
                name: "medico_id",
                table: "recetas_digitales",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "RecetaDigitalID",
                table: "medicamentos",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "medico_id",
                table: "evoluciones_clinicas",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_evoluciones_clinicas_medicos_medico_id",
                table: "evoluciones_clinicas",
                column: "medico_id",
                principalTable: "medicos",
                principalColumn: "medico_id");

            migrationBuilder.AddForeignKey(
                name: "FK_medicamentos_recetas_digitales_RecetaDigitalID",
                table: "medicamentos",
                column: "RecetaDigitalID",
                principalTable: "recetas_digitales",
                principalColumn: "receta_digital_id");

            migrationBuilder.AddForeignKey(
                name: "FK_recetas_digitales_medicos_medico_id",
                table: "recetas_digitales",
                column: "medico_id",
                principalTable: "medicos",
                principalColumn: "medico_id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
