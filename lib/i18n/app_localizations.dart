import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/app_locale_provider.dart';
import 'strings/it.dart';
import 'strings/en.dart';
import 'strings/es.dart';

class AppLocalizations {
  final Language locale;

  const AppLocalizations(this.locale);

  static const _strings = <Language, Map<String, String>>{
    Language.it: itStrings,
    Language.en: enStrings,
    Language.es: esStrings,
  };

  /// Look up a translation key. Falls back to the key itself if not found.
  String t(String key) => _strings[locale]?[key] ?? key;

  /// CEFR language level labels
  static const _levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  List<String> get cefrLevels => _levels;

  String levelLabel(String code) => t('langLevel_$code');
}

final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  final lang = ref.watch(appLocaleProvider);
  return AppLocalizations(lang);
});
