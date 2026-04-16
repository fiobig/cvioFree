import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/cv_provider.dart';
import '../state/pro_provider.dart';
import '../state/auth_provider.dart';
import '../i18n/app_localizations.dart';
import '../widgets/section_manager_list.dart';
import 'pro_screen.dart';
import 'auth_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(appLocalizationsProvider);
    final isPro = ref.watch(proProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.t('settings'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Account card ──────────────────────────────────────────────
            _AccountCard(user: user, l: l),
            const SizedBox(height: 12),
            // ── Pro card ──────────────────────────────────────────────────
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProScreen()),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: isPro
                      ? LinearGradient(colors: [Colors.green.shade700, Colors.green.shade600])
                      : const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFF97316)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPro ? Icons.check_circle : Icons.workspace_premium,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isPro ? l.t('proActive') : 'Cvío Pro',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            isPro ? l.t('proActiveDesc') : l.t('proSubtitle'),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isPro)
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // ── Section manager ───────────────────────────────────────────
            const SectionManagerList(),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _confirmClear(context, ref, l),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: Text(l.t('clearData'), style: const TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmClear(BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l.t('clearData')),
        content: Text(l.t('clearDataConfirm')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.t('clearDataNo')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l.t('clearDataYes')),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(cvProvider.notifier).clearData();
      if (context.mounted) Navigator.pop(context);
    }
  }
}

// ── Account card widget ───────────────────────────────────────────────────────

class _AccountCard extends ConsumerWidget {
  const _AccountCard({required this.user, required this.l});
  final dynamic user; // AuthUser?
  final AppLocalizations l;

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l.t('authLogout')),
        content: const Text('Vuoi davvero uscire dal tuo account?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annulla')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l.t('authLogout')),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(authProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (user == null) {
      return OutlinedButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        ),
        icon: const Icon(Icons.login),
        label: Text(l.t('authLogin')),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          _Avatar(imageUrl: user.image as String?),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name as String,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                Text(user.email as String,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            tooltip: l.t('authLogout'),
            onPressed: () => _confirmLogout(context, ref),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CircleAvatar(
        radius: 22,
        backgroundImage: NetworkImage(imageUrl!),
      );
    }
    return CircleAvatar(
      radius: 22,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimaryContainer),
    );
  }
}
