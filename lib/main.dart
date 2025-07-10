import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/presentation/provider/detail_restaurant_notifier.dart';
import 'package:restaurant_app/presentation/provider/favorite_restaurant_notifier.dart';
import 'package:restaurant_app/presentation/provider/restaurant_list_notifier.dart';
import 'package:restaurant_app/presentation/provider/theme_notifier.dart';
import 'package:restaurant_app/presentation/routing/routing.dart';
import 'package:restaurant_app/presentation/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => RestaurantListNotifier()),
        ChangeNotifierProvider(create: (_) => DetailRestaurantNotifier()),
        ChangeNotifierProvider(create: (_) => FavoriteRestaurantNotifier()),
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
