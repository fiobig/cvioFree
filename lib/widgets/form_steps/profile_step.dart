import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/cv_provider.dart';
import '../../i18n/app_localizations.dart';
import '../translated_field.dart';

class ProfileStep extends ConsumerWidget {
  const ProfileStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TranslatedTextField(
        fieldPath: 'profile',
        rawValue: cv.profile,
        currentLanguage: cv.currentLanguage,
        translations: cv.translations,
        onChanged: ref.read(cvProvider.notifier).updateProfile,
        label: l.t('profile'),
        hint: l.t('profilePlaceholder'),
        multiline: true,
        maxLines: 8,
      ),
    );
  }
}
