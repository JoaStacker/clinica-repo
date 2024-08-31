
import 'package:clinica_front/ui/pages/login/login_view_model.dart';
import 'package:provider/provider.dart';

final routerViewModel = [
  ChangeNotifierProvider<LoginViewModel>(create: (context) => LoginViewModel()), 
];