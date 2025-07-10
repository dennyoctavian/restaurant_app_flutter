part of 'screens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> requestAlarmPermission() async {
    if (Platform.isAndroid) {
      final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      if (sdkInt >= 31) {
        final intent = AndroidIntent(
          action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    requestAlarmPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          Consumer<ReminderNotifier>(
            builder: (context, value, child) {
              return SwitchListTile(
                title: const Text('Restaurant Notification'),
                value: value.reminder,
                onChanged: (value) {
                  Provider.of<ReminderNotifier>(
                    context,
                    listen: false,
                  ).setReminder();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
