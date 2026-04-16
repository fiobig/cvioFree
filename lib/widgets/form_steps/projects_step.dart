import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/cv_data.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';
import '_field_helpers.dart';

class ProjectsStep extends ConsumerWidget {
  const ProjectsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);
    void update(List<Project> list) => notifier.updateProjects(list);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cv.projects.asMap().entries.map((entry) {
            final i = entry.key;
            final p = entry.value;
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
                          onPressed: () => update([...cv.projects]..removeAt(i)),
                        ),
                      ],
                    ),
                    TranslatedTextField(
                      fieldPath: 'proj.${p.id}.name',
                      rawValue: p.name,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.projects.replaceAt(i, p.copyWith(name: v))),
                      label: l.t('projectName'),
                    ),
                    const SizedBox(height: 10),
                    SimpleTextField(
                      label: l.t('url'),
                      value: p.url,
                      onChanged: (v) => update(cv.projects.replaceAt(i, p.copyWith(url: v))),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 10),
                    TranslatedTextField(
                      fieldPath: 'proj.${p.id}.description',
                      rawValue: p.description,
                      currentLanguage: cv.currentLanguage,
                      translations: cv.translations,
                      onChanged: (v) => update(cv.projects.replaceAt(i, p.copyWith(description: v))),
                      label: l.t('description'),
                      multiline: true,
                    ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: () => update([...cv.projects, Project(id: const Uuid().v4())]),
            icon: const Icon(Icons.add),
            label: Text(l.t('addProject')),
          ),
        ],
      ),
    );
  }
}
