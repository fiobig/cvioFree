import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'app.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('cv_store'),
    Hive.openBox('settings'),
    AuthService.instance.init(),
  ]);
  runApp(
    const ProviderScope(
      child: CvBuilderApp(),
    ),
  );
}
