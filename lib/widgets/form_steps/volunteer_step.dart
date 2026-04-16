import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/cv_data.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';
import '_field_helpers.dart';

class VolunteerStep extends ConsumerWidget {
  const VolunteerStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);
    void update(List<Volunteer> list) => notifier.updateVolunteer(list);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cv.volunteer.asMap().entries.map((entry) {
            final i = entry.key;
            final v = entry.value;
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
                          onPressed: () => update([...cv.volunteer]..removeAt(i)),
                        ),
                      ],
                    ),
                    TranslatedTextField(
                      fieldPath: 'vol.${v.id}.role',
                      rawValue: v.role,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (val) => update(cv.volunteer.replaceAt(i, v.copyWith(role: val))),
                      label: l.t('volunteerRole'),
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'vol.${v.id}.organization',
                      rawValue: v.organization,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (val) => update(cv.volunteer.replaceAt(i, v.copyWith(organization: val))),
                      label: l.t('volunteerOrg'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SimpleTextField(
                            label: l.t('startDate'),
                            value: v.startDate,
                            onChanged: (val) => update(cv.volunteer.replaceAt(i, v.copyWith(startDate: val))),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SimpleTextField(
                            label: l.t('endDate'),
                            value: v.endDate,
                            onChanged: (val) => update(cv.volunteer.replaceAt(i, v.copyWith(endDate: val))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'vol.${v.id}.description',
                      rawValue: v.description,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (val) => update(cv.volunteer.replaceAt(i, v.copyWith(description: val))),
                      label: l.t('description'),
                      multiline: true,
                    ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: () => update([...cv.volunteer, Volunteer(id: const Uuid().v4())]),
            icon: const Icon(Icons.add),
            label: Text(l.t('addVolunteer')),
          ),
        ],
      ),
    );
  }
}
