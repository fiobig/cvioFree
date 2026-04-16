import 'dart:io' show Platform;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../state/pro_provider.dart';
import '../templates/european_template.dart';
import '../templates/modern_template.dart';
import '../templates/classic_template.dart';
import '../templates/minimal_template.dart';
import '../templates/sidebar_template.dart';
import '../templates/executive_template.dart';
import '../widgets/download_bottom_sheet.dart';
import '../services/screen_security_service.dart';
import '../i18n/app_localizations.dart';
import 'home_screen.dart' show kFloatingTabBarHeight;
import 'pro_screen.dart';

class PreviewScreen extends ConsumerStatefulWidget {
  const PreviewScreen({super.key});

  @override
  ConsumerState<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewScreen> {
  bool _isSecure = false;

  @override
  void initState() {
    super.initState();
    // Screenshot detection only on Android (FLAG_SECURE handles it natively)
    if (!Platform.isIOS) {
      ScreenSecurityService.onScreenshotDetected = _onScreenshotDetected;
    }
  }

  void _onScreenshotDetected() {
    if (!mounted) return;
    final l = ref.read(appLocalizationsProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(l.t('screenshotWarning'))),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _updateScreenSecurity(bool isPremiumSelected, bool isPro) {
    final shouldSecure = isPremiumSelected && !isPro;
    if (shouldSecure != _isSecure) {
      _isSecure = shouldSecure;
      if (shouldSecure) {
        ScreenSecurityService.enableSecure();
      } else {
        ScreenSecurityService.disableSecure();
      }
    }
  }

  @override
  void dispose() {
    ScreenSecurityService.onScreenshotDetected = null;
    if (_isSecure) {
      ScreenSecurityService.disableSecure();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cv = ref.watch(cvProvider);
    final isPro = ref.watch(proProvider);
    final isPremium = cv.template.isPremium;
    final showWatermark = isPremium && !isPro;
    final l = ref.watch(appLocalizationsProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScreenSecurity(isPremium, isPro);
    });

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                if (showWatermark) ...[
                  _ProBanner(
                    onUpgrade: () => _openProScreen(context),
                    title: l.t('proRequired'),
                    subtitle: l.t('proRequiredDesc'),
                  ),
                  const SizedBox(height: 12),
                ],
                Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      _buildTemplate(cv),
                      if (showWatermark) const _WatermarkOverlay(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kFloatingTabBarHeight),
        child: FloatingActionButton.extended(
          onPressed: () {
            if (showWatermark) {
              _openProScreen(context);
            } else {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const DownloadBottomSheet(),
              );
            }
          },
          icon: Icon(showWatermark ? Icons.lock_outlined : Icons.download_outlined),
          label: Text(showWatermark ? 'Pro' : 'Download'),
          backgroundColor: showWatermark ? const Color(0xFFF59E0B) : null,
          foregroundColor: showWatermark ? const Color(0xFF0F172A) : null,
        ),
      ),
    );
  }

  void _openProScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProScreen()),
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

// ─── Watermark overlay ───────────────────────────────────────────────────────

class _WatermarkOverlay extends StatelessWidget {
  const _WatermarkOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final rows = (constraints.maxHeight / 120).ceil();
            final cols = (constraints.maxWidth / 160).ceil();

            return Stack(
              children: [
                Container(color: Colors.white.withAlpha(20)),
                for (int r = 0; r < rows; r++)
                  for (int c = 0; c < cols; c++)
                    Positioned(
                      left: c * 160.0 - 20,
                      top: r * 120.0 + 10,
                      child: Transform.rotate(
                        angle: -math.pi / 6,
                        child: Text(
                          'PREVIEW',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.withAlpha(60),
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─── Pro upgrade banner ──────────────────────────────────────────────────────

class _ProBanner extends StatelessWidget {
  const _ProBanner({
    required this.onUpgrade,
    required this.title,
    required this.subtitle,
  });
  final VoidCallback onUpgrade;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpgrade,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF59E0B).withAlpha(60),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.workspace_premium, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.white.withAlpha(200)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }
}
