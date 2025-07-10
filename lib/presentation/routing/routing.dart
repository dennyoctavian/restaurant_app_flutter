import 'package:go_router/go_router.dart';
import 'package:restaurant_app/presentation/screens/screens.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          name: 'detail',
          path: '/detail/:id',
          builder: (context, state) =>
              DetailScreen(id: state.pathParameters['id']!),
        ),
        GoRoute(
          name: 'favorite',
          path: '/favorite',
          builder: (context, state) => FavoriteScreen(),
        ),
        GoRoute(
          name: 'settings',
          path: '/settings',
          builder: (context, state) => SettingsScreen(),
        ),
      ],
    ),
  ],
);
