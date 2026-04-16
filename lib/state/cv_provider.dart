import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../services/persistence_service.dart';
import 'cv_notifier.dart';

final persistenceServiceProvider = Provider<PersistenceService>(
  (_) => PersistenceService(),
);

final cvProvider = StateNotifierProvider<CVNotifier, CVData>(
  (ref) => CVNotifier(ref.read(persistenceServiceProvider)),
);

// ─── Convenience selectors ───────────────────────────────────────────────────

final currentLanguageProvider = Provider<Language>(
  (ref) => ref.watch(cvProvider).currentLanguage,
);

final templateProvider = Provider<TemplateName>(
  (ref) => ref.watch(cvProvider).template,
);

final modernModeProvider = Provider<bool>(
  (ref) => ref.watch(cvProvider).modernMode,
);

/// Returns sections visible in the form (filtered by modernMode)
final visibleSectionsProvider = Provider<List<CVSection>>(
  (ref) {
    final cv = ref.watch(cvProvider);
    return cv.sections
        .where((s) => s.enabled && (!s.isModern || cv.modernMode))
        .toList();
  },
);

/// Returns all sections for the section manager (including disabled)
final allSectionsProvider = Provider<List<CVSection>>(
  (ref) {
    final cv = ref.watch(cvProvider);
    return cv.sections
        .where((s) => !s.isModern || cv.modernMode)
        .toList();
  },
);
