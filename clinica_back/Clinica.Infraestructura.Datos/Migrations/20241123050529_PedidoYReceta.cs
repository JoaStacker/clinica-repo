using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Clinica.Infraestructura.Datos.Migrations
{
    /// <inheritdoc />
    public partial class PedidoYReceta : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos");

            migrationBuilder.DropForeignKey(
                name: "FK_pedidos_laboratorio_evoluciones_clinicas_evolucion_clinica_id",
                table: "pedidos_laboratorio");

            migrationBuilder.DropForeignKey(
                name: "FK_recetas_digitales_evoluciones_clinicas_evolucion_clinica_id",
                table: "recetas_digitales");

            migrationBuilder.DropIndex(
                name: "IX_recetas_digitales_evolucion_clinica_id",
                table: "recetas_digitales");

            migrationBuilder.DropIndex(
                name: "IX_pedidos_laboratorio_evolucion_clinica_id",
                table: "pedidos_laboratorio");

            migrationBuilder.DropColumn(
                name: "evolucion_clinica_id",
                table: "recetas_digitales");

            migrationBuilder.DropColumn(
                name: "evolucion_clinica_id",
                table: "pedidos_laboratorio");

            migrationBuilder.RenameColumn(
                name: "texto_libre",
                table: "evoluciones_clinicas",
                newName: "informe");

            migrationBuilder.AlterColumn<string>(
                name: "codigo_barras",
                table: "recetas_digitales",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<double>(
                name: "cantidad",
                table: "medicamentos",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "pedido_laboratorio_id",
                table: "evoluciones_clinicas",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "receta_digital_id",
                table: "evoluciones_clinicas",
                type: "int",
                nullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "historia_clinica_id",
                table: "diagnosticos",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_evoluciones_clinicas_pedido_laboratorio_id",
                table: "evoluciones_clinicas",
                column: "pedido_laboratorio_id");

            migrationBuilder.CreateIndex(
                name: "IX_evoluciones_clinicas_receta_digital_id",
                table: "evoluciones_clinicas",
                column: "receta_digital_id");

            migrationBuilder.AddForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos",
                column: "historia_clinica_id",
                principalTable: "historias_clinicas",
                principalColumn: "historia_clinica_id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_evoluciones_clinicas_pedidos_laboratorio_pedido_laboratorio_id",
                table: "evoluciones_clinicas",
                column: "pedido_laboratorio_id",
                principalTable: "pedidos_laboratorio",
                principalColumn: "pedido_laboratorio_id");

            migrationBuilder.AddForeignKey(
                name: "FK_evoluciones_clinicas_recetas_digitales_receta_digital_id",
                table: "evoluciones_clinicas",
                column: "receta_digital_id",
                principalTable: "recetas_digitales",
                principalColumn: "receta_digital_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos");

            migrationBuilder.DropForeignKey(
                name: "FK_evoluciones_clinicas_pedidos_laboratorio_pedido_laboratorio_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropForeignKey(
                name: "FK_evoluciones_clinicas_recetas_digitales_receta_digital_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropIndex(
                name: "IX_evoluciones_clinicas_pedido_laboratorio_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropIndex(
                name: "IX_evoluciones_clinicas_receta_digital_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropColumn(
                name: "cantidad",
                table: "medicamentos");

            migrationBuilder.DropColumn(
                name: "pedido_laboratorio_id",
                table: "evoluciones_clinicas");

            migrationBuilder.DropColumn(
                name: "receta_digital_id",
                table: "evoluciones_clinicas");

            migrationBuilder.RenameColumn(
                name: "informe",
                table: "evoluciones_clinicas",
                newName: "texto_libre");

            migrationBuilder.AlterColumn<int>(
                name: "codigo_barras",
                table: "recetas_digitales",
                type: "int",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AddColumn<int>(
                name: "evolucion_clinica_id",
                table: "recetas_digitales",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "evolucion_clinica_id",
                table: "pedidos_laboratorio",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<int>(
                name: "historia_clinica_id",
                table: "diagnosticos",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.CreateIndex(
                name: "IX_recetas_digitales_evolucion_clinica_id",
                table: "recetas_digitales",
                column: "evolucion_clinica_id");

            migrationBuilder.CreateIndex(
                name: "IX_pedidos_laboratorio_evolucion_clinica_id",
                table: "pedidos_laboratorio",
                column: "evolucion_clinica_id");

            migrationBuilder.AddForeignKey(
                name: "FK_diagnosticos_historias_clinicas_historia_clinica_id",
                table: "diagnosticos",
                column: "historia_clinica_id",
                principalTable: "historias_clinicas",
                principalColumn: "historia_clinica_id");

            migrationBuilder.AddForeignKey(
                name: "FK_pedidos_laboratorio_evoluciones_clinicas_evolucion_clinica_id",
                table: "pedidos_laboratorio",
                column: "evolucion_clinica_id",
                principalTable: "evoluciones_clinicas",
                principalColumn: "evolucion_clinica_id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_recetas_digitales_evoluciones_clinicas_evolucion_clinica_id",
                table: "recetas_digitales",
                column: "evolucion_clinica_id",
                principalTable: "evoluciones_clinicas",
                principalColumn: "evolucion_clinica_id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
