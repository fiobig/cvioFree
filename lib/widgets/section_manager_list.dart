import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../i18n/app_localizations.dart';

class SectionManagerList extends ConsumerWidget {
  const SectionManagerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final notifier = ref.read(cvProvider.notifier);

    // Show all sections filtered by modernMode
    final sections = cv.sections
        .where((s) => !s.isModern || cv.modernMode)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Modern mode toggle
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l.t('modernSections'), style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(l.t('modernSectionsDesc'), style: const TextStyle(fontSize: 12)),
          value: cv.modernMode,
          onChanged: notifier.setModernMode,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            l.t('reorderSections'),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorderItem: (oldIndex, newIndex) {
            // Work on a copy of all sections, only reorder within visible ones
            final allSections = List<CVSection>.from(cv.sections);
            final visibleIds = sections.map((s) => s.id).toList();

            // Map visible indices to all-sections indices
            final allOldIndex = allSections.indexWhere((s) => s.id == visibleIds[oldIndex]);
            var allNewIndex = allSections.indexWhere((s) => s.id == visibleIds[
                (newIndex >= sections.length ? sections.length - 1 : newIndex)
            ]);

            if (allOldIndex == allNewIndex) return;

            final item = allSections.removeAt(allOldIndex);
            allSections.insert(allNewIndex, item);
            notifier.reorderSections(allSections);
          },
          children: sections.map((section) {
            return ListTile(
              key: ValueKey(section.id),
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: const Icon(Icons.drag_handle, color: Colors.grey),
              title: Text(
                l.t(section.id.name),
                style: TextStyle(
                  fontSize: 13,
                  color: section.enabled ? Colors.black87 : Colors.grey,
                ),
              ),
              trailing: Switch(
                value: section.enabled,
                onChanged: section.id == SectionType.personalInfo
                    ? null // Personal info cannot be disabled
                    : (_) => notifier.toggleSection(section.id),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
