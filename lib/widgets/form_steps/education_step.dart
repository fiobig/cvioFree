import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/cv_data.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';
import '_field_helpers.dart';

class EducationStep extends ConsumerWidget {
  const EducationStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);
    void update(List<Education> list) => notifier.updateEducation(list);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cv.education.asMap().entries.map((entry) {
            final i = entry.key;
            final edu = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('#${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                          onPressed: () => update([...cv.education]..removeAt(i)),
                        ),
                      ],
                    ),
                    TranslatedTextField(
                      fieldPath: 'edu.${edu.id}.degree',
                      rawValue: edu.degree,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.education.replaceAt(i, edu.copyWith(degree: v))),
                      label: l.t('degree'),
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'edu.${edu.id}.institution',
                      rawValue: edu.institution,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.education.replaceAt(i, edu.copyWith(institution: v))),
                      label: l.t('institution'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SimpleTextField(
                            label: l.t('startDate'),
                            value: edu.startDate,
                            onChanged: (v) => update(cv.education.replaceAt(i, edu.copyWith(startDate: v))),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SimpleTextField(
                            label: l.t('endDate'),
                            value: edu.endDate,
                            onChanged: (v) => update(cv.education.replaceAt(i, edu.copyWith(endDate: v))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'edu.${edu.id}.description',
                      rawValue: edu.description,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.education.replaceAt(i, edu.copyWith(description: v))),
                      label: l.t('description'),
                      multiline: true,
                    ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: () => update([...cv.education, Education(id: const Uuid().v4())]),
            icon: const Icon(Icons.add),
            label: Text(l.t('addEducation')),
          ),
        ],
      ),
    );
  }
}
