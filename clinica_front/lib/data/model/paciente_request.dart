// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PacienteRequest {
    String cuil;
    String dni;
    String email;
    String telefono;
    String nombreApellido;
    String provincia;
    String localidad;
    String cop;
    String calle;
    String altura;
    String piso;
    String departamento;
    String pasaporte;
    String fechaDeNaciento;
    int nroAfiliado;

    PacienteRequest({
        required this.cuil,
        required this.dni,
        required this.email,
        required this.telefono,
        required this.nombreApellido,
        required this.provincia,
        required this.localidad,
        required this.cop,
        required this.calle,
        required this.altura,
        required this.piso,
        required this.departamento,
        required this.pasaporte,
        required this.fechaDeNaciento,
        required this.nroAfiliado
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cuil': cuil,
      'dni': dni,
      'email': email,
      'telefono': telefono,
      'nombre_apellido': nombreApellido,
      'provincia': provincia,
      'localidad': localidad,
      'cop': cop,
      'calle': calle,
      'altura': altura,
      'piso': piso,
      'departamento': departamento,
      'pasaporte': pasaporte,
      'nro_afiliado': nroAfiliado,
      'fecha_nacimiento': fechaDeNaciento
    };
  }

  String toJson() => json.encode(toMap());
}
