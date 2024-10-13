import 'dart:async';

import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/services/dialog_service/dialog_confirm_enum.dart';
import 'package:clinica_front/services/dialog_service/dialog_request.dart';
import 'package:clinica_front/services/dialog_service/dialog_response.dart';
import 'package:clinica_front/services/navegation_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogService {

  DialogResponse? response;

  bool _isDialogVisible = false;

  bool get isDialogVisible  => _isDialogVisible;

  
  Future<DialogResponse?> showConfirmationDialog({String? title, required String description, required String positiveLabel, required negativeLabel, String? cancelLabel}) async {
    _isDialogVisible = true;
    var dialogRequest = DialogRequest(title: title, description: description, positiveLabel: positiveLabel, negativeLabel: negativeLabel, cancelLabel: cancelLabel);
    final response = await _showAlertDialog(dialogRequest);
    _isDialogVisible = false;
    return response;
  }

  Future<DialogResponse?> _showAlertDialog(DialogRequest dialogRequest) async {
    final context = NavigatorKey().key.currentContext!;
    await showDialog(context: context, builder: _alertDialogBuilder(dialogRequest), barrierDismissible: false, useRootNavigator: false);
    return response;
  }


  Widget Function(BuildContext) _alertDialogBuilder(DialogRequest dialogRequest){
    List<Widget> actions = [
      _addAction(dialogRequest.positiveLabel, DialogConfirmEnum.positive),
      if (dialogRequest.negativeLabel?.isNotEmpty ?? false) _addAction(dialogRequest.negativeLabel, DialogConfirmEnum.negative),
      if (dialogRequest.cancelLabel?.isNotEmpty ?? false) _addAction(dialogRequest.cancelLabel, DialogConfirmEnum.cancel)
    ];

    return (context) => AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: dialogRequest.title != null ? Text('${dialogRequest.title}') : null,
      content: Text('${dialogRequest.description}'),
      actions: actions,
      
    );
  }

  Widget _addAction(String? text, DialogConfirmEnum dialogConfirmEnum){
    return TextButton(onPressed: () => _dialogCompleteWithResponse(dialogConfirmEnum), child: Text('$text', style:  textStyle14));
  }

  void _dialogCompleteWithResponse(DialogConfirmEnum dialogConfirmEnum){
    response = DialogResponse(confirmed: dialogConfirmEnum);
    (NavigatorKey().key.currentContext!).pop();
  }
}