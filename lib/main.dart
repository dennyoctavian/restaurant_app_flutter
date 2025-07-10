import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/services/services.dart';
import 'package:restaurant_app/helpers/local_notification_service.dart';
import 'package:restaurant_app/presentation/provider/detail_restaurant_notifier.dart';
import 'package:restaurant_app/presentation/provider/favorite_restaurant_notifier.dart';
import 'package:restaurant_app/presentation/provider/local_notification_notifier.dart';
import 'package:restaurant_app/presentation/provider/reminder_notifier.dart';
import 'package:restaurant_app/presentation/provider/restaurant_list_notifier.dart';
import 'package:restaurant_app/presentation/provider/theme_notifier.dart';
import 'package:restaurant_app/presentation/routing/routing.dart';
import 'package:restaurant_app/presentation/theme/theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = SharedPreferencesHelper.getBool(
      SharedPreferenceKey.idDarkMode,
    );
    bool dialyReminder = SharedPreferencesHelper.getBool(
      SharedPreferenceKey.dialyReminder,
    );
    ApiRestaurant apiRestaurant = ApiRestaurant();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(isDarkMode: isDarkMode),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantListNotifier(apiRestaurant: apiRestaurant),
        ),
        ChangeNotifierProvider(create: (_) => DetailRestaurantNotifier()),
        ChangeNotifierProvider(create: (_) => FavoriteRestaurantNotifier()),
        ChangeNotifierProvider(
          create: (_) => ReminderNotifier(reminder: dialyReminder),
        ),
        Provider(create: (context) => LocalNotificationService()..init()),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          ),
        ),
      ],
      builder: (context, asyncSnapshot) {
        final themeProvider = Provider.of<ThemeNotifier>(context);
        return MaterialApp.router(
          themeMode: themeProvider.themeMode,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          routerConfig: router,
        );
      },
    );
  }
}
