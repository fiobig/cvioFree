import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart' show ShareParams, SharePlus, XFile;
import 'package:path_provider/path_provider.dart';
import 'package:file_saver/file_saver.dart';
import 'dart:io';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../i18n/app_localizations.dart';
import '../services/pdf_service.dart';
import '../services/zip_service.dart';
import '../services/ensure_translations.dart';
import '../services/translation_service.dart';

class DownloadBottomSheet extends ConsumerStatefulWidget {
  const DownloadBottomSheet({super.key});

  @override
  ConsumerState<DownloadBottomSheet> createState() => _DownloadBottomSheetState();
}

class _DownloadBottomSheetState extends ConsumerState<DownloadBottomSheet>
    with TickerProviderStateMixin {
  bool _loading = false;
  bool _success = false;
  String _status = '';

  final _pdfService = PdfService();
  final _translationService = TranslationService();

  late final AnimationController _successController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _successController,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _successController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _successController.dispose();
    super.dispose();
  }

  void _showSuccess() {
    setState(() { _loading = false; _success = true; _status = ''; });
    _successController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) Navigator.pop(context);
      });
    });
  }

  void _showError(Object e) {
    if (!mounted) return;
    setState(() { _loading = false; _status = ''; });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }

  // ─── PDF ──────────────────────────────────────────────────────────────────

  Future<void> _sharePdf() async {
    final cv = ref.read(cvProvider);
    setState(() { _loading = true; _status = ''; });
    try {
      final bytes = await _pdfService.generatePdf(cv, cv.currentLanguage);
      final name = _cvName(cv);
      await Printing.sharePdf(bytes: bytes, filename: '${name}_CV.pdf');
      _showSuccess();
    } catch (e) { _showError(e); }
  }

  Future<void> _savePdfToDownloads() async {
    final cv = ref.read(cvProvider);
    final l = ref.read(appLocalizationsProvider);
    setState(() { _loading = true; _status = l.t('saving'); });
    try {
      final bytes = await _pdfService.generatePdf(cv, cv.currentLanguage);
      final name = _cvName(cv);
      await FileSaver.instance.saveAs(
        name: '${name}_CV',
        bytes: bytes,
        fileExtension: 'pdf',
        mimeType: MimeType.pdf,
      );
      _showSuccess();
    } catch (e) { _showError(e); }
  }

  // ─── ZIP ──────────────────────────────────────────────────────────────────

  Future<void> _shareZip() async {
    final l = ref.read(appLocalizationsProvider);
    setState(() { _loading = true; _status = l.t('downloading'); });
    try {
      final cv = ref.read(cvProvider);
      final translatedCv = await ensureAllTranslations(cv, _translationService);
      ref.read(cvProvider.notifier).setTranslations(translatedCv.translations);

      final zipService = ZipService(_pdfService);
      final name = _cvName(translatedCv);
      final zipBytes = await zipService.generateZip(translatedCv, name);

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${name}_CV.zip');
      await file.writeAsBytes(zipBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'application/zip')],
          subject: '${name}_CV',
        ),
      );
      _showSuccess();
    } catch (e) { _showError(e); }
  }

  Future<void> _saveZipToDownloads() async {
    final l = ref.read(appLocalizationsProvider);
    setState(() { _loading = true; _status = l.t('downloading'); });
    try {
      final cv = ref.read(cvProvider);
      final translatedCv = await ensureAllTranslations(cv, _translationService);
      ref.read(cvProvider.notifier).setTranslations(translatedCv.translations);

      final zipService = ZipService(_pdfService);
      final name = _cvName(translatedCv);
      final zipBytes = await zipService.generateZip(translatedCv, name);

      await FileSaver.instance.saveAs(
        name: '${name}_CV',
        bytes: zipBytes,
        fileExtension: 'zip',
        mimeType: MimeType.other,
      );
      _showSuccess();
    } catch (e) { _showError(e); }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  String _cvName(CVData cv) {
    final first = cv.personalInfo.firstName;
    final last = cv.personalInfo.lastName;
    if (first.isEmpty && last.isEmpty) return 'CV';
    return _sanitize('${first}_$last');
  }

  static String _sanitize(String input) {
    const diacritics =
        'àáâãäåæçèéêëìíîïðñòóôõöùúûüýÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖÙÚÛÜÝ';
    const replacements =
        'aaaaaaaceeeeiiiidnooooouuuuyAAAAAAACEEEEIIIIDNOOOOOUUUUY';
    var result = input;
    for (var i = 0; i < diacritics.length; i++) {
      result = result.replaceAll(diacritics[i], replacements[i]);
    }
    return result
        .replaceAll(RegExp(r'[^\x20-\x7E]'), '')
        .trim()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'_+'), '_');
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(appLocalizationsProvider);
    final isAndroid = Platform.isAndroid;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_success) ...[
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 56,
                          color: Colors.green.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l.t('done'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ] else ...[
              Text(
                l.t('downloadTitle'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (_loading) ...[
                const Center(child: CircularProgressIndicator()),
                if (_status.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(_status, textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ] else ...[
                // ── PDF ──────────────────────────────────────────────────
                if (isAndroid) ...[
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _sharePdf,
                          icon: const Icon(Icons.share_outlined, size: 18),
                          label: Text(l.t('share')),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _savePdfToDownloads,
                          icon: const Icon(Icons.download_outlined, size: 18),
                          label: Text(l.t('saveLocal')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l.t('downloadSingleLabel'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ] else ...[
                  FilledButton.icon(
                    onPressed: _sharePdf,
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    label: Text(l.t('downloadSingle')),
                  ),
                ],

                const SizedBox(height: 14),

                // ── ZIP ──────────────────────────────────────────────────
                if (isAndroid) ...[
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _shareZip,
                          icon: const Icon(Icons.share_outlined, size: 18),
                          label: Text(l.t('share')),
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.green.shade700),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _saveZipToDownloads,
                          icon: const Icon(Icons.download_outlined, size: 18),
                          label: Text(l.t('saveLocal')),
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.green.shade700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l.t('downloadZipLabel'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ] else ...[
                  FilledButton.icon(
                    onPressed: _shareZip,
                    icon: const Icon(Icons.folder_zip_outlined),
                    label: Text(l.t('downloadZip')),
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.green.shade700),
                  ),
                ],

                const SizedBox(height: 14),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l.t('cancel')),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
