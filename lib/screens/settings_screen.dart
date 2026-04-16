import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../state/cv_provider.dart';
import '../i18n/app_localizations.dart';
import '../widgets/section_manager_list.dart';

// TODO: Replace with your actual URLs before publishing.
const _privacyPolicyUrl = 'https://cv-builder-api.fiorenzo9845.workers.dev/privacy';
const _termsOfServiceUrl = 'https://cv-builder-api.fiorenzo9845.workers.dev/terms';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(appLocalizationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.t('settings'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section manager ───────────────────────────────────────────
            const SectionManagerList(),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            // ── Legal ─────────────────────────────────────────────────────
            Text(
              l.t('legalSection'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            _LegalTile(
              icon: Icons.privacy_tip_outlined,
              label: l.t('privacyPolicy'),
              url: _privacyPolicyUrl,
            ),
            _LegalTile(
              icon: Icons.description_outlined,
              label: l.t('termsOfService'),
              url: _termsOfServiceUrl,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            // ── Clear data ────────────────────────────────────────────────
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

// ── Legal tile ────────────────────────────────────────────────────────────────

class _LegalTile extends StatelessWidget {
  const _LegalTile({required this.icon, required this.label, required this.url});
  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 20, color: Colors.grey.shade700),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      trailing: Icon(Icons.open_in_new, size: 16, color: Colors.grey.shade400),
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
    );
  }
}
