import 'package:flutter/material.dart';
import 'package:restaurant_app/data/services/services.dart';
import 'package:restaurant_app/helpers/notification.dart';

class ReminderNotifier extends ChangeNotifier {
  bool reminder = false;

  ReminderNotifier({this.reminder = false});

  void setReminder() async {
    reminder = !reminder;
    notifyListeners();
    await SharedPreferencesHelper.setBool(
      SharedPreferenceKey.dialyReminder,
      reminder,
    );

    if (reminder) {
      await NotificationHelper.scheduleDailyReminder();
    } else {
      await NotificationHelper.cancelDailyReminder();
    }
  }
}
