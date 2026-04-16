import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/cv_data.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';
import '_field_helpers.dart';

class ExperienceStep extends ConsumerWidget {
  const ExperienceStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);

    void update(List<Experience> list) => notifier.updateExperiences(list);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cv.experiences.asMap().entries.map((entry) {
            final i = entry.key;
            final exp = entry.value;

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
                          onPressed: () {
                            final list = [...cv.experiences]..removeAt(i);
                            update(list);
                          },
                        ),
                      ],
                    ),
                    TranslatedTextField(
                      fieldPath: 'exp.${exp.id}.jobTitle',
                      rawValue: exp.jobTitle,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.experiences.replaceAt(i, exp.copyWith(jobTitle: v))),
                      label: l.t('jobTitle'),
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'exp.${exp.id}.company',
                      rawValue: exp.company,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.experiences.replaceAt(i, exp.copyWith(company: v))),
                      label: l.t('company'),
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'exp.${exp.id}.location',
                      rawValue: exp.location,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.experiences.replaceAt(i, exp.copyWith(location: v))),
                      label: l.t('location'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SimpleTextField(
                            label: l.t('startDate'),
                            value: exp.startDate,
                            onChanged: (v) => update(cv.experiences.replaceAt(i, exp.copyWith(startDate: v))),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SimpleTextField(
                            label: l.t('endDate'),
                            value: exp.current ? '' : exp.endDate,
                            enabled: !exp.current,
                            onChanged: (v) => update(cv.experiences.replaceAt(i, exp.copyWith(endDate: v))),
                          ),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l.t('current'), style: const TextStyle(fontSize: 13)),
                      value: exp.current,
                      onChanged: (v) => update(cv.experiences.replaceAt(i, exp.copyWith(current: v ?? false))),
                    ),
                    TranslatedTextField(
                      fieldPath: 'exp.${exp.id}.description',
                      rawValue: exp.description,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.experiences.replaceAt(i, exp.copyWith(description: v))),
                      label: l.t('description'),
                      multiline: true,
                    ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: () {
              final newExp = Experience(id: const Uuid().v4());
              update([...cv.experiences, newExp]);
            },
            icon: const Icon(Icons.add),
            label: Text(l.t('addExperience')),
          ),
        ],
      ),
    );
  }
}
