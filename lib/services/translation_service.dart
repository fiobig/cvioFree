import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cv_data.dart';

class TranslationService {
  static const _baseUrl = 'https://api.mymemory.translated.net/get';
  static const _maxChunkLength = 450;
  // Adding developer email increases free quota 10x (helps with carrier NAT shared IPs)
  static const _devEmail = ''; // set your email here if needed

  // In-memory cache: "text|from|to" -> translated string
  final _cache = <String, String>{};

  // Deduplication: in-flight requests keyed by cache key
  final _pending = <String, Future<String>>{};

  // Per-field debounce timers
  final _debounceTimers = <String, Timer>{};

  // Max concurrent translation requests (avoid rate limiting)
  static const _maxConcurrent = 5;
  int _activeRequests = 0;
  final _requestQueue = <Future<void> Function()>[];

  Future<T> _throttled<T>(Future<T> Function() fn) async {
    if (_activeRequests < _maxConcurrent) {
      _activeRequests++;
      try {
        return await fn();
      } finally {
        _activeRequests--;
        if (_requestQueue.isNotEmpty) {
          _requestQueue.removeAt(0)();
        }
      }
    } else {
      final completer = Completer<T>();
      _requestQueue.add(() async {
        _activeRequests++;
        try {
          completer.complete(await fn());
        } catch (e) {
          completer.completeError(e);
        } finally {
          _activeRequests--;
          if (_requestQueue.isNotEmpty) {
            _requestQueue.removeAt(0)();
          }
        }
      });
      return completer.future;
    }
  }

  /// Splits long text into chunks on sentence boundaries
  List<String> splitIntoChunks(String text) {
    if (text.length <= _maxChunkLength) return [text];

    final chunks = <String>[];
    final sentences = text.split(RegExp(r'(?<=[.!?])\s+'));
    var current = '';

    for (final sentence in sentences) {
      if (current.isEmpty) {
        if (sentence.length > _maxChunkLength) {
          // Force-split very long sentences
          var start = 0;
          while (start < sentence.length) {
            final end =
                (start + _maxChunkLength).clamp(0, sentence.length).toInt();
            chunks.add(sentence.substring(start, end));
            start = end;
          }
        } else {
          current = sentence;
        }
      } else if ('$current $sentence'.length <= _maxChunkLength) {
        current += ' $sentence';
      } else {
        chunks.add(current);
        current = sentence;
      }
    }
    if (current.isNotEmpty) chunks.add(current);
    return chunks;
  }

  Future<String> _translateChunk(
    String text,
    String fromCode,
    String toCode,
  ) async {
    final cacheKey = '$text|$fromCode|$toCode';

    if (_cache.containsKey(cacheKey)) return _cache[cacheKey]!;

    if (_pending.containsKey(cacheKey)) return _pending[cacheKey]!;

    final future = _throttled(() async {
      try {
        final uri = Uri.parse(_baseUrl).replace(queryParameters: {
          'q': text,
          'langpair': '$fromCode|$toCode',
          if (_devEmail.isNotEmpty) 'de': _devEmail,
        });

        final response = await http.get(uri).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          final responseStatus = data['responseStatus'];
          if (responseStatus == 200 || responseStatus == '200') {
            final translated =
                (data['responseData'] as Map<String, dynamic>)['translatedText']
                    as String;
            _cache[cacheKey] = translated;
            return translated;
          }
        }
      } catch (_) {}
      // Fallback: return original text
      _cache[cacheKey] = text;
      return text;
    });

    _pending[cacheKey] = future;
    try {
      final result = await future;
      return result;
    } finally {
      _pending.remove(cacheKey);
    }
  }

  Future<String> translateText(
    String text,
    Language from,
    Language to,
  ) async {
    if (text.trim().isEmpty || from == to) return text;

    final chunks = splitIntoChunks(text);
    final results = await Future.wait(
      chunks.map((c) => _translateChunk(c, from.code, to.code)),
    );
    return results.join(' ');
  }

  /// Debounced translation triggered on field change.
  /// Calls [onTranslated] for each target language when the translation completes.
  void debouncedTranslate({
    required String fieldPath,
    required String text,
    required Language sourceLang,
    required List<Language> targetLangs,
    required void Function(Language lang, String translated) onTranslated,
    Duration delay = const Duration(milliseconds: 800),
  }) {
    _debounceTimers[fieldPath]?.cancel();
    _debounceTimers[fieldPath] = Timer(delay, () async {
      for (final lang in targetLangs) {
        if (lang == sourceLang || text.trim().isEmpty) continue;
        final translated = await translateText(text, sourceLang, lang);
        onTranslated(lang, translated);
      }
    });
  }

  void dispose() {
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
  }
}
