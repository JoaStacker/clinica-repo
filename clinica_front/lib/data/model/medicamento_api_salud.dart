// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MedicamentoApiSalud {
    int codigo;
    String descripcion;
    String formato;

    MedicamentoApiSalud({
        required this.codigo,
        required this.descripcion,
        required this.formato,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'descripcion': descripcion,
      'formato': formato,
    };
  }

  factory MedicamentoApiSalud.fromMap(Map<String, dynamic> map) {
    return MedicamentoApiSalud(
      codigo: map['codigo'] as int,
      descripcion: map['descripcion'] as String,
      formato: map['formato'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicamentoApiSalud.fromJson(String source) => MedicamentoApiSalud.fromMap(json.decode(source) as Map<String, dynamic>);
}
