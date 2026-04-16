import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/cv_data.dart';

const _labels = {
  'profile': {Language.it: 'Su di me', Language.en: 'About Me', Language.es: 'Sobre Mí'},
  'experience': {Language.it: 'Esperienza', Language.en: 'Experience', Language.es: 'Experiencia'},
  'education': {Language.it: 'Istruzione', Language.en: 'Education', Language.es: 'Educación'},
  'skills': {Language.it: 'Competenze', Language.en: 'Skills', Language.es: 'Competencias'},
  'languages': {Language.it: 'Lingue', Language.en: 'Languages', Language.es: 'Idiomas'},
  'projects': {Language.it: 'Progetti', Language.en: 'Projects', Language.es: 'Proyectos'},
  'certifications': {Language.it: 'Certificazioni', Language.en: 'Certifications', Language.es: 'Certificaciones'},
  'volunteer': {Language.it: 'Volontariato', Language.en: 'Volunteering', Language.es: 'Voluntariado'},
  'interests': {Language.it: 'Interessi', Language.en: 'Interests', Language.es: 'Intereses'},
};

const _present = {Language.it: 'Presente', Language.en: 'Present', Language.es: 'Presente'};
String _label(String key, Language lang) => _labels[key]?[lang] ?? key;
String _pres(Language lang) => _present[lang] ?? 'Present';

const _slate800 = Color(0xFF1E293B);
const _slate700 = Color(0xFF334155);
const _slate600 = Color(0xFF475569);
const _slate400 = Color(0xFF94A3B8);
const _slate200 = Color(0xFFE2E8F0);
const _slate50 = Color(0xFFF8FAFC);

// ─── Flutter Widget ───────────────────────────────────────────────────────────

class ModernTemplate extends StatelessWidget {
  const ModernTemplate({super.key, required this.data, required this.lang});
  final CVData data;
  final Language lang;

  @override
  Widget build(BuildContext context) {
    final pi = data.personalInfo;
    final tr = data.translations;
    final visible = data.sections
        .where((s) => s.enabled && (!s.isModern || data.modernMode))
        .toList();

    const sidebarIds = {SectionType.skills, SectionType.languages, SectionType.interests};
    final main = visible.where((s) => s.id != SectionType.personalInfo && !sidebarIds.contains(s.id)).toList();
    final sidebar = visible.where((s) => sidebarIds.contains(s.id)).toList();

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header gradient
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_slate800, _slate700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                if (pi.photoBytes != null) ...[
                  ClipOval(
                    child: Image.memory(pi.photoBytes!, width: 68, height: 68, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${pi.firstName} ',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            TextSpan(
                              text: pi.lastName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 12,
                        runSpacing: 2,
                        children: [
                          if (pi.email.isNotEmpty) _contactChip(pi.email),
                          if (pi.phone.isNotEmpty) _contactChip(pi.phone),
                          if (pi.address.isNotEmpty) _contactChip(pi.address),
                          if (pi.linkedin.isNotEmpty) _contactChip(pi.linkedin),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Body: main + sidebar
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: main.map((s) => _buildMain(s.id, data, tr, lang)).whereType<Widget>().toList(),
                    ),
                  ),
                ),
                // Sidebar
                Container(
                  width: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: _slate50,
                    border: Border(left: BorderSide(color: _slate200, width: 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sidebar.map((s) => _buildSidebar(s.id, data, tr, lang)).whereType<Widget>().toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactChip(String text) => Text(
        text,
        style: const TextStyle(fontSize: 9, color: _slate400),
      );

  Widget? _buildMain(SectionType id, CVData d, Map<String, TranslatedField> tr, Language lang) {
    final lbl = _label(id.name, lang);

    Widget sectionTitle(String t) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.toUpperCase(),
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _slate800, letterSpacing: 1),
            ),
            Container(height: 1, color: _slate200, margin: const EdgeInsets.only(top: 3, bottom: 8)),
          ],
        );

    switch (id) {
      case SectionType.profile:
        if (d.profile.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(lbl),
              Text(
                getTranslated(tr, 'profile', lang, d.profile),
                style: const TextStyle(fontSize: 10, color: _slate600, height: 1.5),
              ),
            ],
          ),
        );

      case SectionType.experience:
        if (d.experiences.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(lbl),
              ...d.experiences.map((exp) => Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: _slate200, width: 2)),
                      ),
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _slate800),
                                    ),
                                    Text(
                                      getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                                      style: const TextStyle(fontSize: 10, color: _slate600),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${exp.startDate} - ${exp.current ? _pres(lang) : exp.endDate}',
                                style: const TextStyle(fontSize: 9, color: _slate400),
                              ),
                            ],
                          ),
                          if (exp.description.isNotEmpty)
                            Text(
                              getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                              style: const TextStyle(fontSize: 9, color: _slate600, height: 1.4),
                            ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        );

      case SectionType.education:
        if (d.education.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(lbl),
              ...d.education.map((edu) => Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: _slate200, width: 2)),
                      ),
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _slate800),
                                ),
                                Text(
                                  getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                                  style: const TextStyle(fontSize: 10, color: _slate600),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${edu.startDate} - ${edu.endDate}',
                            style: const TextStyle(fontSize: 9, color: _slate400),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        );

      case SectionType.projects:
        if (d.projects.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(lbl),
              ...d.projects.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _slate800),
                        ),
                        if (p.url.isNotEmpty)
                          Text(p.url, style: const TextStyle(fontSize: 8, color: Colors.blue)),
                        if (p.description.isNotEmpty)
                          Text(
                            getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                            style: const TextStyle(fontSize: 9, color: _slate600),
                          ),
                      ],
                    ),
                  )),
            ],
          ),
        );

      case SectionType.certifications:
        if (d.certifications.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(lbl),
              ...d.certifications.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: _slate700),
                        ),
                        TextSpan(
                          text: ' - ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                          style: const TextStyle(fontSize: 9, color: _slate400),
                        ),
                      ]),
                    ),
                  )),
            ],
          ),
        );

      case SectionType.volunteer:
        if (d.volunteer.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(lbl),
              ...d.volunteer.map((v) => Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: _slate200, width: 2)),
                      ),
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _slate800),
                          ),
                          Text(
                            getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                            style: const TextStyle(fontSize: 10, color: _slate600),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        );

      default:
        return null;
    }
  }

  Widget? _buildSidebar(SectionType id, CVData d, Map<String, TranslatedField> tr, Language lang) {
    final lbl = _label(id.name, lang);

    Widget sideTitle(String t) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            t.toUpperCase(),
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _slate700, letterSpacing: 0.5),
          ),
        );

    switch (id) {
      case SectionType.skills:
        if (d.skills.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sideTitle(lbl),
              ...d.skills.map((skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                          style: const TextStyle(fontSize: 9, color: _slate700),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: List.generate(5, (i) {
                            return Expanded(
                              child: Container(
                                height: 4,
                                margin: const EdgeInsets.only(right: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: i < skill.level ? _slate700 : _slate200,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );

      case SectionType.languages:
        if (d.languages.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sideTitle(lbl),
              ...d.languages.map((l) => Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: l.language, style: const TextStyle(fontSize: 9, color: _slate700)),
                        TextSpan(text: ' (${l.level})', style: const TextStyle(fontSize: 8, color: _slate400)),
                      ]),
                    ),
                  )),
            ],
          ),
        );

      case SectionType.interests:
        if (d.interests.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sideTitle(lbl),
              Text(
                getTranslated(tr, 'interests', lang, d.interests),
                style: const TextStyle(fontSize: 9, color: _slate600),
              ),
            ],
          ),
        );

      default:
        return null;
    }
  }
}

// ─── PDF Builder ─────────────────────────────────────────────────────────────
// Note: For PDF, sidebar is rendered inline (below main content) to avoid
// pw.MultiPage column truncation on page breaks.

Future<List<pw.Widget>> buildModernPdfWidgets(
  CVData data,
  Language lang,
  pw.Font regularFont,
  pw.Font boldFont,
  pw.Font italicFont,
) async {
  final pi = data.personalInfo;
  final tr = data.translations;
  final visible = data.sections
      .where((s) => s.enabled && (!s.isModern || data.modernMode))
      .toList();

  const sidebarIds = {SectionType.skills, SectionType.languages, SectionType.interests};
  final mainSections = visible.where((s) => s.id != SectionType.personalInfo && !sidebarIds.contains(s.id)).toList();
  final sidebarSections = visible.where((s) => sidebarIds.contains(s.id)).toList();

  final pSlate800 = PdfColor.fromHex('#1E293B');
  final pSlate700 = PdfColor.fromHex('#334155');
  final pSlate600 = PdfColor.fromHex('#475569');
  final pSlate400 = PdfColor.fromHex('#94A3B8');
  final pSlate200 = PdfColor.fromHex('#E2E8F0');
  final pSlate50 = PdfColor.fromHex('#F8FAFC');

  pw.TextStyle style({pw.Font? font, double size = 9, PdfColor? color, double? lineSpacing}) =>
      pw.TextStyle(font: font ?? regularFont, fontSize: size, color: color ?? pSlate700, lineSpacing: lineSpacing);

  pw.Widget sectionTitle(String t) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            t.toUpperCase(),
            style: pw.TextStyle(font: boldFont, fontSize: 9, color: pSlate800, letterSpacing: 1),
          ),
          pw.Container(height: 1, color: pSlate200, margin: const pw.EdgeInsets.only(top: 2, bottom: 6)),
        ],
      );

  final widgets = <pw.Widget>[];

  // Header
  final headerRow = <pw.Widget>[
    if (pi.photoBytes != null) ...[
      pw.Container(
        width: 52,
        height: 52,
        decoration: const pw.BoxDecoration(shape: pw.BoxShape.circle),
        child: pw.ClipOval(
          child: pw.Image(pw.MemoryImage(pi.photoBytes!), fit: pw.BoxFit.cover),
        ),
      ),
      pw.SizedBox(width: 12),
    ],
    pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.RichText(
            text: pw.TextSpan(children: [
              pw.TextSpan(text: '${pi.firstName} ', style: pw.TextStyle(font: regularFont, fontSize: 18, color: PdfColors.white)),
              pw.TextSpan(text: pi.lastName, style: pw.TextStyle(font: boldFont, fontSize: 18, color: PdfColors.white)),
            ]),
          ),
          pw.SizedBox(height: 4),
          pw.Wrap(
            spacing: 10,
            runSpacing: 2,
            children: [
              if (pi.email.isNotEmpty) pw.Text(pi.email, style: style(size: 8, color: pSlate400)),
              if (pi.phone.isNotEmpty) pw.Text(pi.phone, style: style(size: 8, color: pSlate400)),
              if (pi.address.isNotEmpty) pw.Text(pi.address, style: style(size: 8, color: pSlate400)),
            ],
          ),
        ],
      ),
    ),
  ];

  widgets.add(
    pw.Container(
      padding: const pw.EdgeInsets.all(16),
      color: pSlate800,
      child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center, children: headerRow),
    ),
  );
  widgets.add(pw.SizedBox(height: 12));

  // Main sections
  for (final section in mainSections) {
    final lbl = _label(section.id.name, lang);
    pw.Widget? content;

    switch (section.id) {
      case SectionType.profile:
        if (data.profile.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            pw.Text(getTranslated(tr, 'profile', lang, data.profile), style: style(color: pSlate600, lineSpacing: 2)),
          ],
        );

      case SectionType.experience:
        if (data.experiences.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...data.experiences.map((exp) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8, left: 8),
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border(left: pw.BorderSide(color: pSlate200, width: 2)),
                    ),
                    padding: const pw.EdgeInsets.only(left: 6),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Expanded(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                                    style: pw.TextStyle(font: boldFont, fontSize: 10, color: pSlate800),
                                  ),
                                  pw.Text(
                                    getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                                    style: style(size: 9, color: pSlate600),
                                  ),
                                ],
                              ),
                            ),
                            pw.Text(
                              '${exp.startDate} - ${exp.current ? _pres(lang) : exp.endDate}',
                              style: style(size: 8, color: pSlate400),
                            ),
                          ],
                        ),
                        if (exp.description.isNotEmpty)
                          pw.Text(
                            getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                            style: style(size: 8, color: pSlate600, lineSpacing: 2),
                          ),
                      ],
                    ),
                  ),
                )),
          ],
        );

      case SectionType.education:
        if (data.education.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...data.education.map((edu) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6, left: 8),
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border(left: pw.BorderSide(color: pSlate200, width: 2)),
                    ),
                    padding: const pw.EdgeInsets.only(left: 6),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                                style: pw.TextStyle(font: boldFont, fontSize: 10, color: pSlate800),
                              ),
                              pw.Text(
                                getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                                style: style(size: 9, color: pSlate600),
                              ),
                            ],
                          ),
                        ),
                        pw.Text(
                          '${edu.startDate} - ${edu.endDate}',
                          style: style(size: 8, color: pSlate400),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        );

      default:
        continue;
    }

    widgets.add(pw.Padding(padding: const pw.EdgeInsets.only(bottom: 10), child: content));
  }

  // Sidebar sections rendered inline for PDF
  if (sidebarSections.isNotEmpty) {
    widgets.add(
      pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          color: pSlate50,
          border: pw.Border.all(color: pSlate200, width: 1),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
        ),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: sidebarSections.map((section) {
            final lbl = _label(section.id.name, lang);
            pw.Widget? inner;

            switch (section.id) {
              case SectionType.skills:
                if (data.skills.isEmpty) return pw.SizedBox();
                inner = pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(lbl.toUpperCase(),
                        style: pw.TextStyle(font: boldFont, fontSize: 7, color: pSlate700, letterSpacing: 0.5)),
                    pw.SizedBox(height: 4),
                    ...data.skills.map((skill) => pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 4),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                                style: style(size: 8),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Row(
                                children: List.generate(5, (i) => pw.Expanded(
                                      child: pw.Container(
                                        height: 3,
                                        margin: const pw.EdgeInsets.only(right: 2),
                                        decoration: pw.BoxDecoration(
                                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(1)),
                                          color: i < skill.level ? pSlate700 : pSlate200,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )),
                  ],
                );

              case SectionType.languages:
                if (data.languages.isEmpty) return pw.SizedBox();
                inner = pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(lbl.toUpperCase(),
                        style: pw.TextStyle(font: boldFont, fontSize: 7, color: pSlate700, letterSpacing: 0.5)),
                    pw.SizedBox(height: 4),
                    ...data.languages.map((l) => pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 3),
                          child: pw.RichText(
                            text: pw.TextSpan(children: [
                              pw.TextSpan(text: l.language, style: style(size: 8)),
                              pw.TextSpan(text: ' (${l.level})', style: style(size: 7, color: pSlate400)),
                            ]),
                          ),
                        )),
                  ],
                );

              case SectionType.interests:
                if (data.interests.isEmpty) return pw.SizedBox();
                inner = pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(lbl.toUpperCase(),
                        style: pw.TextStyle(font: boldFont, fontSize: 7, color: pSlate700, letterSpacing: 0.5)),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      getTranslated(tr, 'interests', lang, data.interests),
                      style: style(size: 8, color: pSlate600),
                    ),
                  ],
                );

              default:
                return pw.SizedBox();
            }

            return pw.Expanded(
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(right: 8),
                child: inner,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  return widgets;
}
