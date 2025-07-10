import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:restaurant_app/data/extensions/dio_extensions.dart';
import 'package:restaurant_app/data/extensions/restaurant_db.dart';
import 'package:restaurant_app/data/models/add_review_response.dart';
import 'package:restaurant_app/data/models/detail_restaurant_response.dart';
import 'package:restaurant_app/data/models/list_restaurant_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

part 'base_service.dart';
part 'api_restaurant.dart';
part 'local_favorite.dart';
part 'shared_preferences_helper.dart';

DioClient dioClient = DioClient();
