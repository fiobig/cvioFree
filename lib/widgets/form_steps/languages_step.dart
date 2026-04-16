import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/cv_data.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '_field_helpers.dart';

class LanguagesStep extends ConsumerWidget {
  const LanguagesStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);
    void update(List<LanguageSkill> list) => notifier.updateLanguages(list);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cv.languages.asMap().entries.map((entry) {
            final i = entry.key;
            final lang = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: SimpleTextField(
                        label: l.t('language'),
                        value: lang.language,
                        onChanged: (v) => update(cv.languages.replaceAt(i, lang.copyWith(language: v))),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: lang.level,
                        decoration: InputDecoration(
                          labelText: l.t('level'),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          isDense: true,
                        ),
                        items: l.cefrLevels.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code, style: const TextStyle(fontSize: 13)),
                          );
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) update(cv.languages.replaceAt(i, lang.copyWith(level: v)));
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                      onPressed: () => update([...cv.languages]..removeAt(i)),
                    ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: () => update([...cv.languages, LanguageSkill(id: const Uuid().v4())]),
            icon: const Icon(Icons.add),
            label: Text(l.t('addLanguage')),
          ),
        ],
      ),
    );
  }
}
