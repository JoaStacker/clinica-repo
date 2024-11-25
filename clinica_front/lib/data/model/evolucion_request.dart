// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EvolutionRequest {
    int medicoId;
    int diagnosticoId;
    String informe;
    String? textoPedido;
    List<Medicamento>? medicamentos;
    String? indicaciones;

    EvolutionRequest({
        required this.medicoId,
        required this.diagnosticoId,
        required this.informe,
        required this.textoPedido,
        required this.medicamentos,
        required this.indicaciones,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'medicoId': medicoId,
      'diagnosticoId': diagnosticoId,
      'informe': informe,
      'textoPedido': textoPedido,
      'medicamentos': medicamentos?.map((x) => x.toMap()).toList(),
      'indicaciones': indicaciones,
    };
  }

  String toJson() => json.encode(toMap());
}

class Medicamento {
    String codigo;
    String nombreComercial;
    int cantidad;

    Medicamento({
        required this.codigo,
        required this.nombreComercial,
        required this.cantidad,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'nombreComercial': nombreComercial,
      'cantidad': cantidad,
    };
  }

  String toJson() => json.encode(toMap());
}
