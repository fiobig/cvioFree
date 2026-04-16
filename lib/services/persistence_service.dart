import 'dart:convert';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/cv_data.dart';

class PersistenceService {
  static const _boxName = 'cv_store';
  static const _key = 'cv_data';

  Future<CVData?> load() async {
    final box = Hive.box(_boxName);
    final json = box.get(_key) as String?;
    if (json == null) return null;
    try {
      return CVData.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> save(CVData data) async {
    final box = Hive.box(_boxName);
    await box.put(_key, jsonEncode(data.toJson()));
  }

  Future<void> clear() async {
    final box = Hive.box(_boxName);
    await box.delete(_key);
  }
}
