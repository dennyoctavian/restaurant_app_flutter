part of 'widgets.dart';

class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.light_mode),
        Switch(
          activeColor: context.colorScheme.primary,
          value: themeProvider.isDarkMode,
          onChanged: (_) => themeProvider.toggleTheme(),
        ),
        const Icon(Icons.dark_mode),
      ],
    );
  }
}
