import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/services/services.dart';
import 'package:restaurant_app/presentation/extensions/extensions.dart';
import 'package:restaurant_app/presentation/provider/detail_restaurant_notifier.dart';
import 'package:restaurant_app/presentation/provider/favorite_restaurant_notifier.dart';
import 'package:restaurant_app/presentation/provider/local_notification_notifier.dart';
import 'package:restaurant_app/presentation/provider/reminder_notifier.dart';
import 'package:restaurant_app/presentation/provider/restaurant_list_notifier.dart';
import 'package:restaurant_app/presentation/widgets/widgets.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

part 'home_screen.dart';
part 'detail_screen.dart';
part 'favorite_screen.dart';
part 'settings_screen.dart';
