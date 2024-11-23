// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: file_names

class HistorialPaciente {
    int pacienteId;
    String dni;
    String nombreApellido;
    List<HistoriaClinica> historiaClinica;

    HistorialPaciente({
        required this.pacienteId,
        required this.dni,
        required this.nombreApellido,
        required this.historiaClinica,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pacienteID': pacienteId,
      'dni': dni,
      'nombreApellido': nombreApellido,
      'historiaClinica': historiaClinica.map((x) => x.toMap()).toList(),
    };
  }

  factory HistorialPaciente.fromMap(Map<String, dynamic> map) {
    return HistorialPaciente(
      pacienteId: map['pacienteID'] as int,
      dni: map['dni'] as String,
      nombreApellido: map['nombreApellido'] as String,
      historiaClinica: List<HistoriaClinica>.from((map['historiaClinica'] as List<dynamic>).map<HistoriaClinica>((x) => HistoriaClinica.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistorialPaciente.fromJson(String source) => HistorialPaciente.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HistoriaClinica {
    int diagnosticoId;
    String enfermedad;
    String observaciones;
    List<Evoluciones> evoluciones;

    HistoriaClinica({
        required this.diagnosticoId,
        required this.enfermedad,
        required this.observaciones,
        required this.evoluciones,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'diagnosticoID': diagnosticoId,
      'enfermedad': enfermedad,
      'observaciones': observaciones,
      'evoluciones': evoluciones.map((x) => x.toMap()).toList(),
    };
  }

  factory HistoriaClinica.fromMap(Map<String, dynamic> map) {
    return HistoriaClinica(
      diagnosticoId: map['diagnosticoID'] as int,
      enfermedad: map['enfermedad'] as String,
      observaciones: map['observaciones'] as String,
      evoluciones: List<Evoluciones>.from((map['evoluciones'] as List<dynamic>).map<Evoluciones>((x) => Evoluciones.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoriaClinica.fromJson(String source) => HistoriaClinica.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Evoluciones {
    String medico;
    String informe;
    DateTime fechaCreacion;
    dynamic textoPedido;
    dynamic indicacionesReceta;

    Evoluciones({
        required this.medico,
        required this.informe,
        required this.fechaCreacion,
        required this.textoPedido,
        required this.indicacionesReceta,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'medico': medico,
      'informe': informe,
      'fechaCreacion': fechaCreacion.millisecondsSinceEpoch,
      'textoPedido': textoPedido,
      'indicacionesReceta': indicacionesReceta,
    };
  }

  factory Evoluciones.fromMap(Map<String, dynamic> map) {
    return Evoluciones(
      medico: map['medico'] as String,
      informe: map['informe'] as String,
      fechaCreacion: DateTime.parse(map['fechaCreacion'] as String),
      textoPedido: map['textoPedido'] as dynamic,
      indicacionesReceta: map['indicacionesReceta'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory Evoluciones.fromJson(String source) => Evoluciones.fromMap(json.decode(source) as Map<String, dynamic>);
}
