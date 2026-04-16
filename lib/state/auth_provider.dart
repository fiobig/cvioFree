import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

/// Exposes the currently authenticated user (null = not logged in).
/// Uses AsyncValue so callers can show loading/error states.
final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<AuthUser?>>((ref) {
  return AuthNotifier();
});

/// Convenience: the plain user value without async wrapper.
final currentUserProvider = Provider<AuthUser?>((ref) {
  return ref.watch(authProvider).valueOrNull;
});

class AuthNotifier extends StateNotifier<AsyncValue<AuthUser?>> {
  AuthNotifier() : super(const AsyncValue.loading()) {
    _restoreSession();
  }

  // Called on app start — try to restore an existing session from cookies.
  Future<void> _restoreSession() async {
    try {
      final user = await AuthService.instance.getSession();
      state = AsyncValue.data(user);
    } catch (_) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signInEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await AuthService.instance.signInEmail(email, password);
      state = AsyncValue.data(user);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUpEmail(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await AuthService.instance.signUpEmail(name, email, password);
      state = AsyncValue.data(user);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signInGoogle() async {
    state = const AsyncValue.loading();
    try {
      final user = await AuthService.instance.signInGoogle();
      state = AsyncValue.data(user);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    await AuthService.instance.signOut();
    await AuthService.instance.signOutGoogle();
    state = const AsyncValue.data(null);
  }

  /// Force-refresh user from server (e.g. after granting Pro).
  Future<void> refresh() async {
    final user = await AuthService.instance.getSession();
    state = AsyncValue.data(user);
  }
}
