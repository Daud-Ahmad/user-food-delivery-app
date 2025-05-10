import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../../components/alerts.dart';
import '../../../../models/notifications.dart';
import '../../../../network/system_api_service.dart';
import '../../../../preferences.dart';

class NotificationsViewModel extends BaseViewModel {

  int pageIndex = 4;
  List<Notifications> notificationsList = [];

  gettingNotifications(BuildContext context) async {
    setBusy(true);
    final userId = await Preferences.getKey(Preferences.kUserId);
    final resp = await SystemApiService.notifications(userId!);
    if (resp.isSuccess) {
      notificationsList.clear();
      notificationsList.addAll(resp.data!);
      setBusy(false);
    } else {
      setBusy(false);
      showErrorAlert(context,
          title: 'Error',
          message: resp.message ?? resp.error ?? 'Error occurred while getting data ',
          onConfirmClick: () {
            Navigator.pop(context);
          });
    }
  }

}
