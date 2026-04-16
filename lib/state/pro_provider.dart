import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'auth_provider.dart';
import '../services/auth_service.dart';

final proProvider = StateNotifierProvider<ProNotifier, bool>((ref) {
  final notifier = ProNotifier();

  // When auth state changes, sync Pro status with the server.
  ref.listen<AsyncValue<AuthUser?>>(authProvider, (_, next) {
    next.whenData((user) {
      if (user != null) {
        notifier._syncFromServer();
      } else {
        notifier._clearLocal();
      }
    });
  });

  return notifier;
});

class ProNotifier extends StateNotifier<bool> {
  static const _box = 'settings';
  static const _key = 'is_pro';

  ProNotifier() : super(_readLocal());

  static bool _readLocal() {
    return Hive.box(_box).get(_key, defaultValue: false) as bool;
  }

  /// Fetch Pro status from the server and persist locally.
  Future<void> _syncFromServer() async {
    final isPro = await AuthService.instance.getProStatus();
    await Hive.box(_box).put(_key, isPro);
    state = isPro;
  }

  /// Called from ProScreen "purchase" button.
  /// Calls the backend to grant Pro, then persists locally.
  Future<void> purchase() async {
    final isPro = await AuthService.instance.purchasePro();
    await Hive.box(_box).put(_key, isPro);
    state = isPro;
  }

  /// Clear Pro when user logs out.
  Future<void> _clearLocal() async {
    await Hive.box(_box).put(_key, false);
    state = false;
  }
}
