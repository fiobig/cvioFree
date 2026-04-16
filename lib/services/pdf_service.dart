import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/cv_data.dart';
import '../templates/european_template.dart';
import '../templates/modern_template.dart';
import '../templates/classic_template.dart';
import '../templates/minimal_template.dart';
import '../templates/sidebar_template.dart';
import '../templates/executive_template.dart';

class PdfService {
  // Cached fonts — loaded once, reused for all PDF generations
  pw.Font? _regular;
  pw.Font? _bold;
  pw.Font? _italic;

  Future<void> _loadFonts() async {
    if (_regular != null) return;
    final regularData = await rootBundle.load('assets/fonts/NotoSans-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf');
    final italicData = await rootBundle.load('assets/fonts/NotoSans-Italic.ttf');
    _regular = pw.Font.ttf(regularData);
    _bold = pw.Font.ttf(boldData);
    _italic = pw.Font.ttf(italicData);
  }

  Future<Uint8List> generatePdf(CVData data, Language lang) async {
    await _loadFonts();

    final regular = _regular!;
    final bold = _bold!;
    final italic = _italic!;

    // Build the pw.Widget list for the selected template
    final List<pw.Widget> contentWidgets;
    switch (data.template) {
      case TemplateName.european:
        contentWidgets = await buildEuropeanPdfWidgets(data, lang, regular, bold, italic);
      case TemplateName.modern:
        contentWidgets = await buildModernPdfWidgets(data, lang, regular, bold, italic);
      case TemplateName.classic:
        contentWidgets = await buildClassicPdfWidgets(data, lang, regular, bold, italic);
      case TemplateName.minimal:
        contentWidgets = await buildMinimalPdfWidgets(data, lang, regular, bold, italic);
      case TemplateName.sidebar:
        contentWidgets = await buildSidebarPdfWidgets(data, lang, regular, bold, italic);
      case TemplateName.executive:
        contentWidgets = await buildExecutivePdfWidgets(data, lang, regular, bold, italic);
    }

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(
        base: regular,
        bold: bold,
        italic: italic,
      ),
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 28),
        build: (context) => contentWidgets,
      ),
    );

    return doc.save();
  }
}
