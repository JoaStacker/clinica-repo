import 'package:clinica_front/data/model/credential.dart';
import 'package:clinica_front/data/model/user_model.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:clinica_front/services/autentication.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier with NavegationServices{
  final _authService = locator<AuthenticationService>();
  final TextEditingController _userInput = TextEditingController();
  TextEditingController get userInput => _userInput;
  final TextEditingController _passwordInput = TextEditingController();
  TextEditingController get passwordInput => _passwordInput;
  final _formKey = GlobalKey<FormState>();
  GlobalKey get formKey => _formKey;
  String _failureMessage = '';
  String get failureMessage => _failureMessage;
  bool _passwordField = true;
  bool get passwordField => _passwordField;
  UserModel _user = UserModel.empty;
  UserModel get user => _user;
  String token = '';
  bool get isLoggedIn => token != '';

  void changePasswordField() {
    _passwordField = !_passwordField;
    notifyListeners();
  }

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final login = await _login(_userInput.text.trim(), passwordInput.text.trim());
      !login? _failureMessage = 'Usuario o contraseña incorrectos' : navigatorPush('/home');
      notifyListeners();
    }
  }

  Future<bool> _login(String email, String password) async {
    final credential = Credential(email, password);
    final user = await _authService.login(credential);
    if (user == UserModel.empty) return false;
    _user = user;
    notifyListeners();
    return true;
  }

}