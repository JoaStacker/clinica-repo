import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class DetailPatientViewModel extends ChangeNotifier with NavegationServices {
    void goBack(){
      back();
      notifyListeners();
    }
}