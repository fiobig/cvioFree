import 'dart:typed_data';
import 'package:archive/archive.dart';
import '../models/cv_data.dart';
import 'pdf_service.dart';

const _langFileName = {
  Language.it: 'Italiano',
  Language.en: 'English',
  Language.es: 'Espanol',
};

class ZipService {
  final PdfService _pdfService;

  ZipService(this._pdfService);

  /// Generates a ZIP containing one PDF per language.
  /// [fullyTranslatedData] must already have all translations filled in
  /// (call ensureAllTranslations first).
  /// Does NOT touch the live store state.
  Future<Uint8List> generateZip(CVData fullyTranslatedData, String baseName) async {
    final archive = Archive();

    for (final lang in Language.values) {
      final pdfBytes = await _pdfService.generatePdf(fullyTranslatedData, lang);
      final langLabel = _langFileName[lang] ?? lang.code;
      final fileName = '${baseName}_$langLabel.pdf';
      archive.addFile(ArchiveFile(fileName, pdfBytes.length, pdfBytes));
    }

    final zipBytes = ZipEncoder().encode(archive);
    return Uint8List.fromList(zipBytes ?? []);
  }
}
