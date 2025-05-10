import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

showAlert(context, {required title, required message}) {
  showPlatformDialog(
    context: context,
    builder: (_) => PlatformAlertDialog(
      material: (_, __) => MaterialAlertDialogData(
        insetPadding: const EdgeInsets.all(10),
      ),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        PlatformDialogAction(
          child: PlatformText('Ok'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

showConfirmationAlert(context,
    {required title,
    required message,
    String confirmTitle = 'Confirm',
    String cancelTitle = 'Cancel',
    required VoidCallback onConfirmClick,
    required VoidCallback onCancelClick}) {
  Widget cancelButton = OutlinedButton(
    style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: const BorderSide(width: 1, color: Colors.red)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        cancelTitle,
        style: TextStyle(
            color: Colors.red, fontSize: Platform.isAndroid ? 14 : 30),
      ),
    ),
    onPressed: onCancelClick,
  );
  Widget continueButton = OutlinedButton(
    style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: const BorderSide(width: 1, color: Colors.blue)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        confirmTitle,
        style: TextStyle(
            color: Colors.blue, fontSize: Platform.isAndroid ? 14 : 30),
      ),
    ),
    onPressed: onConfirmClick,
  );

  showPlatformDialog(
    context: context,
    builder: (_) => PlatformAlertDialog(
      material: (_, __) => MaterialAlertDialogData(
        insetPadding: const EdgeInsets.all(10),
      ),

      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromRGBO(0x38, 0x7b, 0x96, 1.0),
          fontSize: 30,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.grey),
      ),
      actions: <Widget>[
        PlatformDialogAction(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cancelButton,
            const SizedBox(
              width: 20,
            ),
            continueButton,
          ],
        )),
      ],
    ),
  );
}

showSuccessAlert(context,
    {required title,
    required message,
    String confirmTitle = 'OK',
    required VoidCallback onConfirmClick}) {
  Widget confirmButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      primary: Colors.green,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
      child: Text(
        confirmTitle,
        style: TextStyle(
            color: Colors.white, fontSize: Platform.isAndroid ? 20 : 30),
      ),
    ),
    onPressed: onConfirmClick,
  );

  showPlatformDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PlatformAlertDialog(
      material: (_, __) => MaterialAlertDialogData(
        insetPadding: const EdgeInsets.all(10),
      ),

      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromRGBO(0x38, 0x7b, 0x96, 1.0),
          fontSize: 28,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[700], fontSize: 14),
      ),
      actions: <Widget>[
        PlatformDialogAction(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [confirmButton],
        )),
      ],
    ),
  );
}

showErrorAlert(context,
    {required title,
    required message,
    String confirmTitle = 'OK',
    required VoidCallback onConfirmClick}) {
  Widget confirmButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      primary: Colors.red[500],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
      child: Text(
        confirmTitle,
        style: TextStyle(
            color: Colors.white, fontSize: Platform.isAndroid ? 20 : 30),
      ),
    ),
    onPressed: onConfirmClick,
  );

  showPlatformDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PlatformAlertDialog(
      material: (_, __) => MaterialAlertDialogData(
        insetPadding: const EdgeInsets.all(10),
      ),

      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color.fromRGBO(0x38, 0x7b, 0x96, 1.0),
          fontSize: Platform.isAndroid ? 28 : 22,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[700], fontSize:  Platform.isAndroid ? 14 : 16),
      ),
      actions: <Widget>[
        PlatformDialogAction(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [confirmButton],
        )),
      ],
    ),
  );
}

showProgress(BuildContext context, {String title = 'Loading, please wait...'}) {
  showPlatformDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => PlatformAlertDialog(
      material: (_, __) => MaterialAlertDialogData(
        insetPadding: const EdgeInsets.all(10),
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              maxLines: 1,
              style:
              const TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    ),
  );

}

hideProgress(context) {
  Navigator.pop(context);
}
