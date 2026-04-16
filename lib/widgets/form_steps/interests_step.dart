import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';

class InterestsStep extends ConsumerWidget {
  const InterestsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TranslatedTextField(
        fieldPath: 'interests',
        rawValue: cv.interests,
        currentLanguage: cv.currentLanguage,
        translations: cv.translations,
        onChanged: ref.read(cvProvider.notifier).updateInterests,
        label: l.t('interests'),
        hint: l.t('interestsPlaceholder'),
        multiline: true,
        maxLines: 6,
      ),
    );
  }
}
