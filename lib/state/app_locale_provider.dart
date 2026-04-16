import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import 'cv_provider.dart';

/// UI display language – follows the CV language so the whole app translates together.
final appLocaleProvider = Provider<Language>(
  (ref) => ref.watch(currentLanguageProvider),
);
