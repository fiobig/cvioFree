import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/pro_provider.dart';
import '../i18n/app_localizations.dart';

class ProScreen extends ConsumerStatefulWidget {
  const ProScreen({super.key});

  @override
  ConsumerState<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends ConsumerState<ProScreen> {
  bool _purchasing = false;

  Future<void> _handlePurchase() async {
    setState(() => _purchasing = true);

    try {
      await ref.read(proProvider.notifier).purchase();
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ref.read(appLocalizationsProvider).t('proActivated')),
          backgroundColor: Colors.green.shade700,
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } finally {
      if (mounted) setState(() => _purchasing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(appLocalizationsProvider);
    final isPro = ref.watch(proProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // ── Close button ──────────────────────────────────────────
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white54),
                  ),
                ),
                const SizedBox(height: 8),

                // ── Icon ──────────────────────────────────────────────────
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF59E0B).withAlpha(80),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.workspace_premium, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 20),

                // ── Title ─────────────────────────────────────────────────
                Text(
                  'Cvío Pro',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.t('proSubtitle'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.white60, height: 1.5),
                ),
                const SizedBox(height: 32),

                // ── Features ──────────────────────────────────────────────
                _FeatureCard(
                  icon: Icons.palette_outlined,
                  title: l.t('proFeatureTemplates'),
                  subtitle: l.t('proFeatureTemplatesDesc'),
                ),
                _FeatureCard(
                  icon: Icons.all_inclusive,
                  title: l.t('proFeatureLifetime'),
                  subtitle: l.t('proFeatureLifetimeDesc'),
                ),
                _FeatureCard(
                  icon: Icons.update,
                  title: l.t('proFeatureUpdates'),
                  subtitle: l.t('proFeatureUpdatesDesc'),
                ),
                const SizedBox(height: 32),

                // ── Price ─────────────────────────────────────────────────
                if (!isPro) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(10),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withAlpha(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l.t('proPrice'),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF59E0B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l.t('proPriceOnce'),
                          style: const TextStyle(fontSize: 13, color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Buy button ──────────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _purchasing ? null : _handlePurchase,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFF59E0B),
                        foregroundColor: const Color(0xFF0F172A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: _purchasing
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF0F172A)),
                            )
                          : Text(l.t('proUnlock')),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Restore ─────────────────────────────────────────────
                  TextButton(
                    onPressed: () {
                      // TODO: implement IAP restore
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l.t('proRestoreHint'))),
                      );
                    },
                    child: Text(
                      l.t('proRestore'),
                      style: const TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                  ),
                ] else ...[
                  // Already Pro
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade900.withAlpha(100),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade700.withAlpha(80)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.greenAccent, size: 22),
                        const SizedBox(width: 10),
                        Text(
                          l.t('proActive'),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withAlpha(10)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withAlpha(25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFFF59E0B), size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.white54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
