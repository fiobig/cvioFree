import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../i18n/app_localizations.dart';
import 'home_screen.dart';

const _kSettingsBox = 'settings';
const _kConsentDone = 'consent_done';

Future<bool> isConsentComplete() async {
  final box = Hive.box(_kSettingsBox);
  return box.get(_kConsentDone, defaultValue: false) as bool;
}

Future<void> _markConsentComplete() async {
  final box = Hive.box(_kSettingsBox);
  await box.put(_kConsentDone, true);
}

// ─── Consent Screen ─────────────────────────────────────────────────────────

class ConsentScreen extends ConsumerStatefulWidget {
  const ConsentScreen({super.key});

  @override
  ConsumerState<ConsentScreen> createState() => _ConsentScreenState();
}

enum _ConsentStep { tos, loading, privacy }

class _ConsentScreenState extends ConsumerState<ConsentScreen> {
  _ConsentStep _step = _ConsentStep.tos;
  bool _scrolledToBottom = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrolledToBottom) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 20) {
      setState(() => _scrolledToBottom = true);
    }
  }

  void _acceptTos() {
    setState(() {
      _step = _ConsentStep.loading;
      _scrolledToBottom = false;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _step = _ConsentStep.privacy);
      // Reset scroll controller for new content
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    });
  }

  void _acceptPrivacyAndStart() async {
    await _markConsentComplete();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const HomeScreen(),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(appLocalizationsProvider);

    if (_step == _ConsentStep.loading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                l.t('privacyPolicy'),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final isTos = _step == _ConsentStep.tos;
    final title = isTos ? l.t('termsOfService') : l.t('privacyPolicy');
    final text = isTos ? l.t('tosBody') : l.t('privacyBody');
    final buttonLabel = isTos ? l.t('consentAccept') : l.t('consentAcceptAndStart');
    final onPressed = isTos ? _acceptTos : _acceptPrivacyAndStart;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Icon(
                    isTos ? Icons.description_outlined : Icons.privacy_tip_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            if (!_scrolledToBottom)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      l.t('consentScrollHint'),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            // ── Scrollable text ───────────────────────────────────────
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.6,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ── Bottom bar ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _scrolledToBottom ? onPressed : null,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(buttonLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
