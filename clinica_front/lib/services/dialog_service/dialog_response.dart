import 'package:clinica_front/services/dialog_service/dialog_confirm_enum.dart';

class DialogResponse{

  final String? fieldOne;
  final String? fieldTwo;
  final DialogConfirmEnum confirmed;

  DialogResponse({this.fieldOne, this.fieldTwo, required this.confirmed});
}