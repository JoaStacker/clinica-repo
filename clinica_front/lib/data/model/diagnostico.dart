// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Diagnostico {
    int diagnosticoId;
    String enfermedad;
    String observaciones;
    DateTime fechaDeCreacion;
    int historiaClinicaId;

    Diagnostico({
        required this.diagnosticoId,
        required this.enfermedad,
        required this.observaciones,
        required this.fechaDeCreacion,
        required this.historiaClinicaId,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'diagnosticoID': diagnosticoId,
      'enfermedad': enfermedad,
      'observaciones': observaciones,
      'fechaDeCreacion': fechaDeCreacion.millisecondsSinceEpoch,
      'historiaClinicaID': historiaClinicaId,
    };
  }

  factory Diagnostico.fromMap(Map<String, dynamic> map) {
    return Diagnostico(
      diagnosticoId: map['diagnosticoID'] as int,
      enfermedad: map['enfermedad'] as String,
      observaciones: map['observaciones'] as String,
      fechaDeCreacion: DateTime.parse(map['fechaDeCreacion'] as String),
      historiaClinicaId: map['historiaClinicaID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Diagnostico.fromJson(String source) => Diagnostico.fromMap(json.decode(source) as Map<String, dynamic>);
}
