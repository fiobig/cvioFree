import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../templates/european_template.dart';
import '../templates/modern_template.dart';
import '../templates/classic_template.dart';
import '../templates/minimal_template.dart';
import '../templates/sidebar_template.dart';
import '../templates/executive_template.dart';
import '../widgets/download_bottom_sheet.dart';
import 'home_screen.dart' show kFloatingTabBarHeight;

class PreviewScreen extends ConsumerWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              child: _buildTemplate(cv),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kFloatingTabBarHeight),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const DownloadBottomSheet(),
            );
          },
          icon: const Icon(Icons.download_outlined),
          label: const Text('Download'),
        ),
      ),
    );
  }

  Widget _buildTemplate(CVData cv) {
    switch (cv.template) {
      case TemplateName.european:
        return EuropeanTemplate(data: cv, lang: cv.currentLanguage);
      case TemplateName.modern:
        return ModernTemplate(data: cv, lang: cv.currentLanguage);
      case TemplateName.classic:
        return ClassicTemplate(data: cv, lang: cv.currentLanguage);
      case TemplateName.minimal:
        return MinimalTemplate(data: cv, lang: cv.currentLanguage);
      case TemplateName.sidebar:
        return SidebarTemplate(data: cv, lang: cv.currentLanguage);
      case TemplateName.executive:
        return ExecutiveTemplate(data: cv, lang: cv.currentLanguage);
    }
  }
}
