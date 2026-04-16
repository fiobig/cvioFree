import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../state/pro_provider.dart';
import '../i18n/app_localizations.dart';

class TemplateSelector extends ConsumerWidget {
  const TemplateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(templateProvider);
    final isPro = ref.watch(proProvider);
    final l = ref.watch(appLocalizationsProvider);

    final templates = [
      (TemplateName.european, 'european', 'europeanDesc', Icons.article_outlined, const Color(0xFF2563EB)),
      (TemplateName.modern, 'modern', 'modernDesc', Icons.dashboard_outlined, const Color(0xFF1E293B)),
      (TemplateName.classic, 'classic', 'classicDesc', Icons.menu_book_outlined, const Color(0xFF065F46)),
      (TemplateName.minimal, 'minimal', 'minimalDesc', Icons.text_fields_outlined, const Color(0xFF6366F1)),
      (TemplateName.sidebar, 'sidebar', 'sidebarDesc', Icons.view_sidebar_outlined, const Color(0xFF1E1B4B)),
      (TemplateName.executive, 'executive', 'executiveDesc', Icons.workspace_premium_outlined, const Color(0xFFF59E0B)),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      children: templates.map((t) {
        final (name, key, descKey, icon, color) = t;
        final selected = current == name;
        final premium = name.isPremium;
        final locked = premium && !isPro;

        return GestureDetector(
          onTap: () => ref.read(cvProvider.notifier).setTemplate(name),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: selected ? color.withAlpha(20) : Colors.white,
              border: Border.all(
                color: selected ? color : Colors.grey.shade300,
                width: selected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selected ? color : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: selected ? Colors.white : Colors.grey.shade600, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              l.t(key),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selected ? color : Colors.black87,
                              ),
                            ),
                          ),
                          if (locked) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'PRO',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l.t(descKey),
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                if (selected)
                  Icon(Icons.check_circle, color: color, size: 20),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
