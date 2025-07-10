import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/main.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static Future<void> scheduleDailyReminder() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Waktunya Makan Siang!',
      'Yuk makan yang sehat hari ini 🍱',
      _nextInstanceOf11AM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel_id',
          'Daily Reminder',
          channelDescription: 'Pengingat harian untuk makan siang',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOf11AM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> cancelDailyReminder() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
