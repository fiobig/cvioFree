import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:cv_mobile_app/app.dart';
import 'package:cv_mobile_app/models/cv_data.dart';
import 'package:cv_mobile_app/state/cv_provider.dart';

/// ─── Screenshot automation test ────────────────────────────────────────────
///
/// Navigates through all key screens and captures PNG screenshots.
///
/// Run on a specific simulator/emulator:
///
///   # iOS (iPhone 16 Pro Max — 6.7")
///   flutter test integration_test/screenshot_test.dart -d "iPhone 16 Pro Max"
///
///   # Android (Pixel 9 / S26 Ultra emulator)
///   flutter test integration_test/screenshot_test.dart -d emulator-5554
///
/// Screenshots are saved by the IntegrationTestWidgetsFlutterBinding and can
/// be collected from the device/simulator storage, or via `flutter drive`:
///
///   flutter drive --driver=test_driver/integration_test.dart \
///       --target=integration_test/screenshot_test.dart -d DEVICE_ID

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Store screenshots', () {
    setUpAll(() async {
      await Hive.initFlutter();
      await Future.wait([
        Hive.openBox('cv_store'),
        Hive.openBox('settings'),
      ]);
      // Mark onboarding + consent as done so we land on HomeScreen
      final settings = Hive.box('settings');
      await settings.put('onboarding_done', true);
      await settings.put('consent_done', true);
    });

    tearDownAll(() async {
      await Hive.box('settings').clear();
      await Hive.box('cv_store').clear();
    });

    testWidgets('01 — Preview screen (empty CV)', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CvBuilderApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('01_preview_empty');
    });

    testWidgets('02 — Preview screen (filled CV)', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CvBuilderApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Fill in demo data via the notifier
      final container = ProviderScope.containerOf(
        tester.element(find.byType(MaterialApp)),
      );
      final notifier = container.read(cvProvider.notifier);
      notifier
        ..updateFirstName('Marco')
        ..updateLastName('Rossi')
        ..updateEmail('marco.rossi@email.com')
        ..updatePhone('+39 333 1234567')
        ..updateAddress('Milano, Italia')
        ..updateProfile(
          'Senior software engineer con 8 anni di esperienza nello sviluppo '
          'di applicazioni mobile e web. Specializzato in Flutter, React e '
          'architetture cloud-native.',
        )
        ..updateExperiences([
          const Experience(
            id: 'exp-1',
            jobTitle: 'Senior Mobile Developer',
            company: 'TechCorp Italia',
            startDate: 'Gen 2021',
            endDate: 'Presente',
            current: true,
            description:
                'Sviluppo di applicazioni Flutter cross-platform per clienti enterprise. '
                'Gestione team di 4 sviluppatori.',
          ),
          const Experience(
            id: 'exp-2',
            jobTitle: 'Full Stack Developer',
            company: 'Digital Agency Srl',
            startDate: 'Mar 2018',
            endDate: 'Dic 2020',
            description:
                'Progettazione e sviluppo di web app con React e Node.js. '
                'Integrazione API REST e microservizi.',
          ),
        ])
        ..updateEducation([
          const Education(
            id: 'edu-1',
            degree: 'Laurea Magistrale in Informatica',
            institution: 'Politecnico di Milano',
            startDate: '2015',
            endDate: '2018',
            description: 'Votazione: 110/110 e lode',
          ),
        ])
        ..updateSkills([
          const Skill(id: 'sk-1', name: 'Flutter / Dart', level: 5),
          const Skill(id: 'sk-2', name: 'React / TypeScript', level: 4),
          const Skill(id: 'sk-3', name: 'Node.js', level: 4),
          const Skill(id: 'sk-4', name: 'AWS / Cloud', level: 3),
          const Skill(id: 'sk-5', name: 'UI/UX Design', level: 3),
        ])
        ..updateLanguages([
          const LanguageSkill(id: 'lang-1', language: 'Italiano', level: 'Madrelingua'),
          const LanguageSkill(id: 'lang-2', language: 'Inglese', level: 'C1'),
          const LanguageSkill(id: 'lang-3', language: 'Spagnolo', level: 'B2'),
        ]);

      await tester.pumpAndSettle(const Duration(seconds: 2));

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('02_preview_filled');
    });

    testWidgets('03 — Form editor (personal info)', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CvBuilderApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap the Edit tab via its icon
      final editIcon = find.byIcon(Icons.edit_outlined);
      if (editIcon.evaluate().isNotEmpty) {
        await tester.tap(editIcon.first);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      // Navigate to the second page (personal info) — first page is template selector
      // Swipe left to go to next step
      await tester.fling(find.byType(PageView), const Offset(-300, 0), 800);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('03_form_editor');
    });

    testWidgets('04 — Template selector', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CvBuilderApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap the Edit tab via its icon
      final editIcon = find.byIcon(Icons.edit_outlined);
      if (editIcon.evaluate().isNotEmpty) {
        await tester.tap(editIcon.first);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      // The form starts on template selector (page 0) by default
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('04_template_selector');
    });

    testWidgets('05 — Download bottom sheet', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CvBuilderApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // We're on the Preview tab — tap the FAB
      final fab = find.byType(FloatingActionButton);
      if (fab.evaluate().isNotEmpty) {
        await tester.tap(fab);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('05_download_sheet');
    });

    testWidgets('06 — Settings screen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CvBuilderApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap the settings icon in the AppBar
      final settingsIcon = find.byIcon(Icons.settings_outlined);
      if (settingsIcon.evaluate().isNotEmpty) {
        await tester.tap(settingsIcon);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('06_settings');
    });

    testWidgets('07 — Language selector', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CvBuilderApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap the language/translate button in AppBar
      final translateIcon = find.byIcon(Icons.translate);
      if (translateIcon.evaluate().isNotEmpty) {
        await tester.tap(translateIcon);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot('07_language_selector');
    });
  });
}
