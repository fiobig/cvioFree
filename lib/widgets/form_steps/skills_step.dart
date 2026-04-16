import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/cv_data.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';
import '_field_helpers.dart';

class SkillsStep extends ConsumerWidget {
  const SkillsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);
    void update(List<Skill> list) => notifier.updateSkills(list);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...cv.skills.asMap().entries.map((entry) {
            final i = entry.key;
            final skill = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TranslatedTextField(
                        fieldPath: 'skill.${skill.id}.name',
                        rawValue: skill.name,
                        currentLanguage: cv.currentLanguage,
                        translations: cv.translations,
                        onChanged: (v) => update(cv.skills.replaceAt(i, skill.copyWith(name: v))),
                        label: l.t('skillName'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 5-star level selector
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (starI) {
                        final starLevel = starI + 1;
                        return GestureDetector(
                          onTap: () => update(cv.skills.replaceAt(i, skill.copyWith(level: starLevel))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(
                              starLevel <= skill.level ? Icons.circle : Icons.circle_outlined,
                              size: 16,
                              color: starLevel <= skill.level ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
                            ),
                          ),
                        );
                      }),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                      onPressed: () => update([...cv.skills]..removeAt(i)),
                    ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: () => update([...cv.skills, Skill(id: const Uuid().v4())]),
            icon: const Icon(Icons.add),
            label: Text(l.t('addSkill')),
          ),
        ],
      ),
    );
  }
}
