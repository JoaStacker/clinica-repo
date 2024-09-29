// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Paciente {
    int pacienteId;
    int nroAfiliado;
    String pasaporte;
    String? fechaDefuncion;
    int estado;
    int personaId;
    int historiaClinicaId;
    Persona persona;
    HistoriaClinica historiaClinica;

    Paciente({
        required this.pacienteId,
        required this.nroAfiliado,
        required this.pasaporte,
        required this.fechaDefuncion,
        required this.estado,
        required this.personaId,
        required this.historiaClinicaId,
        required this.persona,
        required this.historiaClinica,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pacienteID': pacienteId,
      'nroAfiliado': nroAfiliado,
      'pasaporte': pasaporte,
      'fechaDefuncion': fechaDefuncion,
      'estado': estado,
      'personaId': personaId,
      'historiaClinicaID': historiaClinicaId,
      'persona': persona.toMap(),
      'historiaClinica': historiaClinica.toMap(),
    };
  }

  factory Paciente.fromMap(Map<String, dynamic> map) {
    return Paciente(
      pacienteId: map['pacienteID'] as int,
      nroAfiliado: map['nroAfiliado'] as int,
      pasaporte: map['pasaporte'] as String,
      fechaDefuncion: map['fechaDefuncion'] as String?,
      estado: map['estado'] as int,
      personaId: map['personaID'] as int,
      historiaClinicaId: map['historiaClinicaID'] as int,
      persona: Persona.fromMap(map['persona'] as Map<String,dynamic>),
      historiaClinica: HistoriaClinica.fromMap(map['historiaClinica'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Paciente.fromJson(String source) => Paciente.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HistoriaClinica {
    int historiaClinicaId;
    String fechaDeCreacion;
    List<dynamic> diagnosticos;

    HistoriaClinica({
        required this.historiaClinicaId,
        required this.fechaDeCreacion,
        required this.diagnosticos,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'historiaClinicaID': historiaClinicaId,
      'fechaDeCreacion': fechaDeCreacion,
      'diagnosticos': diagnosticos,
    };
  }

  factory HistoriaClinica.fromMap(Map<String, dynamic> map) {
    return HistoriaClinica(
      historiaClinicaId: map['historiaClinicaID'] as int,
      fechaDeCreacion: map['fechaDeCreacion'],
      diagnosticos: List<dynamic>.from((map['diagnosticos'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory HistoriaClinica.fromJson(String source) => HistoriaClinica.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Persona {
    int personaId;
    String cuil;
    String dni;
    String fechaDeNacimiento;
    String email;
    String telefono;
    String nombreApellido;
    int direccionId;
    Direccion direccion;

    Persona({
        required this.personaId,
        required this.cuil,
        required this.dni,
        required this.fechaDeNacimiento,
        required this.email,
        required this.telefono,
        required this.nombreApellido,
        required this.direccionId,
        required this.direccion,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'personaID': personaId,
      'cuil': cuil,
      'dni': dni,
      'fechaDeNacimiento': fechaDeNacimiento,
      'email': email,
      'telefono': telefono,
      'nombreApellido': nombreApellido,
      'direccionID': direccionId,
      'direccion': direccion.toMap(),
    };
  }

  factory Persona.fromMap(Map<String, dynamic> map) {
    return Persona(
      personaId: map['personaID'] as int,
      cuil: map['cuil'] as String,
      dni: map['dni'] as String,
      fechaDeNacimiento: map['fechaDeNacimiento'],
      email: map['email'] as String,
      telefono: map['telefono'] as String,
      nombreApellido: map['nombreApellido'] as String,
      direccionId: map['direccionID'] as int,
      direccion: Direccion.fromMap(map['direccion'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Persona.fromJson(String source) => Persona.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Direccion {
    int direccionId;
    String provincia;
    String localidad;
    String cop;
    String calle;
    String altura;
    String piso;
    String departamento;

    Direccion({
        required this.direccionId,
        required this.provincia,
        required this.localidad,
        required this.cop,
        required this.calle,
        required this.altura,
        required this.piso,
        required this.departamento,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'direccionID': direccionId,
      'provincia': provincia,
      'localidad': localidad,
      'cop': cop,
      'calle': calle,
      'altura': altura,
      'piso': piso,
      'departamento': departamento,
    };
  }

  factory Direccion.fromMap(Map<String, dynamic> map) {
    return Direccion(
      direccionId: map['direccionID'] as int,
      provincia: map['provincia'] as String,
      localidad: map['localidad'] as String,
      cop: map['cop'] as String,
      calle: map['calle'] as String,
      altura: map['altura'] as String,
      piso: map['piso'] as String,
      departamento: map['departamento'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Direccion.fromJson(String source) => Direccion.fromMap(json.decode(source) as Map<String, dynamic>);
}
