import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/cv_data.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';
import '_field_helpers.dart';

class CertificationsStep extends ConsumerWidget {
  const CertificationsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);
    void update(List<Certification> list) => notifier.updateCertifications(list);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cv.certifications.asMap().entries.map((entry) {
            final i = entry.key;
            final c = entry.value;
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
                          onPressed: () => update([...cv.certifications]..removeAt(i)),
                        ),
                      ],
                    ),
                    TranslatedTextField(
                      fieldPath: 'cert.${c.id}.name',
                      rawValue: c.name,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.certifications.replaceAt(i, c.copyWith(name: v))),
                      label: l.t('certName'),
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'cert.${c.id}.issuer',
                      rawValue: c.issuer,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.certifications.replaceAt(i, c.copyWith(issuer: v))),
                      label: l.t('certIssuer'),
                    ),
                    const SizedBox(height: 10),
                    SimpleTextField(
                      label: l.t('certDate'),
                      value: c.date,
                      onChanged: (v) => update(cv.certifications.replaceAt(i, c.copyWith(date: v))),
                    ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: () => update([...cv.certifications, Certification(id: const Uuid().v4())]),
            icon: const Icon(Icons.add),
            label: Text(l.t('addCertification')),
          ),
        ],
      ),
    );
  }
}
