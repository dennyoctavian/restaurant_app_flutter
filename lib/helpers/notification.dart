import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/services/services.dart';
import 'package:restaurant_app/helpers/local_notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static Future<void> scheduleDailyReminder() async {
    ApiRestaurant apiRestaurant = ApiRestaurant();
    final response = await apiRestaurant.fetchListRestaurant();
    final random = Random();

    final indexRandom = random.nextInt((response.restaurants ?? []).length);

    String nameRestaurant = "KFC";
    if (indexRandom > 0) {
      nameRestaurant = response.restaurants?[indexRandom].name ?? "KFC";
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Waktunya Makan Siang di $nameRestaurant!',
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
      scheduledDate = scheduledDate.add(const Duration(days: 0));
    }
    return scheduledDate;
  }

  static Future<void> cancelDailyReminder() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
