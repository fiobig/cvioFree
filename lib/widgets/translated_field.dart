import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../services/translation_service.dart';

final _translationServiceProvider = Provider<TranslationService>((_) => TranslationService());

/// A text field that auto-translates its value to the other 2 languages
/// using the MyMemory API (debounced, cached).
///
/// Watches [currentLanguageProvider] directly so it always reacts to
/// language switches – even when `didUpdateWidget` is not triggered.
class TranslatedTextField extends ConsumerStatefulWidget {
  const TranslatedTextField({
    super.key,
    required this.fieldPath,
    required this.rawValue,
    required this.currentLanguage,
    required this.translations,
    required this.onChanged,
    this.label,
    this.hint,
    this.multiline = false,
    this.maxLines,
  });

  final String fieldPath;
  final String rawValue;
  final Language currentLanguage;
  final Map<String, TranslatedField> translations;
  final ValueChanged<String> onChanged;
  final String? label;
  final String? hint;
  final bool multiline;
  final int? maxLines;

  @override
  ConsumerState<TranslatedTextField> createState() => _TranslatedTextFieldState();
}

class _TranslatedTextFieldState extends ConsumerState<TranslatedTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _displayValue(widget.currentLanguage));
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(TranslatedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle translation arriving (provider updated translations map)
    // or any other parameter change while field is not focused.
    if (!_focusNode.hasFocus) {
      _syncController(widget.currentLanguage);
    }
  }

  /// Determine what text to show for the given [lang].
  String _displayValue(Language lang) {
    final cached = widget.translations[widget.fieldPath]?.forLanguage(lang);
    if (cached != null && cached.isNotEmpty) return cached;
    return widget.rawValue;
  }

  /// Update the controller text if it differs from the expected display value.
  void _syncController(Language lang) {
    final expected = _displayValue(lang);
    if (_controller.text != expected) {
      _controller.text = expected;
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _triggerTranslation(_controller.text);
    }
  }

  /// Called when the user switches language via the provider.
  void _onLanguageChanged(Language? previous, Language next) {
    if (previous == null || previous == next) return;

    // 1) Immediately show the translated text (or raw fallback)
    _syncController(next);

    // 2) If no translation exists for the new language, request one now
    final translated = widget.translations[widget.fieldPath]?.forLanguage(next);
    if ((translated == null || translated.isEmpty) && widget.rawValue.trim().isNotEmpty) {
      final service = ref.read(_translationServiceProvider);
      final notifier = ref.read(cvProvider.notifier);
      // Find the best source text
      final sourceText = widget.translations[widget.fieldPath]?.forLanguage(previous);
      final text = (sourceText != null && sourceText.isNotEmpty) ? sourceText : widget.rawValue;
      if (text.trim().isNotEmpty) {
        service.translateText(text, previous, next).then((result) {
          if (mounted) {
            notifier.updateTranslation(widget.fieldPath, next, result);
          }
        });
      }
    }

  }

  void _triggerTranslation(String value) {
    if (value.trim().isEmpty) return;
    final service = ref.read(_translationServiceProvider);
    final notifier = ref.read(cvProvider.notifier);
    final otherLangs = Language.values.where((l) => l != widget.currentLanguage).toList();

    service.debouncedTranslate(
      fieldPath: widget.fieldPath,
      text: value,
      sourceLang: widget.currentLanguage,
      targetLangs: otherLangs,
      onTranslated: (lang, translated) {
        notifier.updateTranslation(widget.fieldPath, lang, translated);
      },
    );

    notifier.updateTranslation(widget.fieldPath, widget.currentLanguage, value);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to language changes directly from the provider.
    // ref.listen fires the callback as a side-effect (not during build),
    // so it's safe to update the controller here.
    ref.listen<Language>(currentLanguageProvider, _onLanguageChanged);

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      maxLines: widget.multiline ? (widget.maxLines ?? 5) : 1,
      minLines: widget.multiline ? 3 : 1,
      keyboardType: widget.multiline ? TextInputType.multiline : TextInputType.text,
      textInputAction: widget.multiline ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        isDense: true,
      ),
      style: const TextStyle(fontSize: 14),
      onChanged: (value) {
        widget.onChanged(value);
        _triggerTranslation(value);
      },
    );
  }
}
