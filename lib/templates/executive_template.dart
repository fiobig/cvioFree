import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/cv_data.dart';

// ─── Labels ──────────────────────────────────────────────────────────────────

const _labels = {
  'profile': {Language.it: 'Profilo Esecutivo', Language.en: 'Executive Profile', Language.es: 'Perfil Ejecutivo'},
  'experience': {Language.it: 'Esperienza Professionale', Language.en: 'Professional Experience', Language.es: 'Experiencia Profesional'},
  'education': {Language.it: 'Formazione', Language.en: 'Education', Language.es: 'Formación'},
  'skills': {Language.it: 'Competenze Chiave', Language.en: 'Core Competencies', Language.es: 'Competencias Clave'},
  'languages': {Language.it: 'Lingue', Language.en: 'Languages', Language.es: 'Idiomas'},
  'projects': {Language.it: 'Progetti', Language.en: 'Projects', Language.es: 'Proyectos'},
  'certifications': {Language.it: 'Certificazioni', Language.en: 'Certifications', Language.es: 'Certificaciones'},
  'volunteer': {Language.it: 'Volontariato', Language.en: 'Volunteer Work', Language.es: 'Voluntariado'},
  'interests': {Language.it: 'Interessi', Language.en: 'Interests', Language.es: 'Intereses'},
};

const _present = {Language.it: 'Presente', Language.en: 'Present', Language.es: 'Presente'};
String _label(String key, Language lang) => _labels[key]?[lang] ?? key;
String _pres(Language lang) => _present[lang] ?? 'Present';

// ─── Colors ───────────────────────────────────────────────────────────────────

const _headerBg = Color(0xFF0F172A);   // slate-950
const _amber = Color(0xFFF59E0B);      // amber-500
const _amberLight = Color(0xFFFEF3C7); // amber-50
const _gray900 = Color(0xFF111827);
const _gray700 = Color(0xFF374151);
const _gray600 = Color(0xFF4B5563);
const _gray500 = Color(0xFF6B7280);
const _gray200 = Color(0xFFE5E7EB);
const _gray100 = Color(0xFFF3F4F6);

// ─── Flutter Widget ───────────────────────────────────────────────────────────

class ExecutiveTemplate extends StatelessWidget {
  const ExecutiveTemplate({super.key, required this.data, required this.lang});
  final CVData data;
  final Language lang;

  @override
  Widget build(BuildContext context) {
    final pi = data.personalInfo;
    final tr = data.translations;
    final visible = data.sections
        .where((s) => s.enabled && (!s.isModern || data.modernMode))
        .toList();

    final contacts = <String>[
      if (pi.email.isNotEmpty) pi.email,
      if (pi.phone.isNotEmpty) pi.phone,
      if (pi.address.isNotEmpty) pi.address,
      if (pi.linkedin.isNotEmpty) pi.linkedin,
      if (pi.website.isNotEmpty) pi.website,
    ];

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Container(
            color: _headerBg,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                if (pi.photoBytes != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.memory(pi.photoBytes!, width: 72, height: 88, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 18),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pi.firstName} ${pi.lastName}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (pi.birthDate.isNotEmpty || pi.nationality.isNotEmpty)
                        Text(
                          [pi.birthDate, pi.nationality].where((s) => s.isNotEmpty).join('  ·  '),
                          style: const TextStyle(fontSize: 10, color: _amber),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Contact strip
          Container(
            color: const Color(0xFF1E293B), // slate-800
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Wrap(
              spacing: 20,
              runSpacing: 2,
              children: contacts
                  .map((c) => Text(c, style: const TextStyle(fontSize: 9, color: Color(0xFF94A3B8))))
                  .toList(),
            ),
          ),
          // ── Sections ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: visible
                  .map((s) => _buildSection(s.id, data, tr, lang))
                  .whereType<Widget>()
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildSection(SectionType id, CVData d, Map<String, TranslatedField> tr, Language lang) {
    if (id == SectionType.personalInfo) return null;
    final lbl = _label(id.name, lang);

    Widget sectionHeader() => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 4, height: 18, color: _amber, margin: const EdgeInsets.only(right: 10)),
                  Text(
                    lbl.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _headerBg,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(height: 1, color: _gray200),
            ],
          ),
        );

    Widget? content;
    switch (id) {
      case SectionType.profile:
        if (d.profile.isEmpty) return null;
        content = Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _amberLight,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _amber.withAlpha(80)),
          ),
          child: Text(
            getTranslated(tr, 'profile', lang, d.profile),
            style: const TextStyle(fontSize: 10, color: _gray700, height: 1.6),
          ),
        );

      case SectionType.experience:
        if (d.experiences.isEmpty) return null;
        content = Column(
          children: d.experiences.map((exp) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline dot + line
                Column(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: _amber,
                      ),
                    ),
                    Container(width: 1, height: 50, color: _gray200),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _gray900),
                            ),
                          ),
                          Text(
                            '${exp.startDate} – ${exp.current ? _pres(lang) : exp.endDate}',
                            style: const TextStyle(fontSize: 9, color: _amber, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text(
                        [
                          getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                          if (exp.location.isNotEmpty) getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                        ].join(' — '),
                        style: const TextStyle(fontSize: 10, color: _gray600, fontWeight: FontWeight.w500),
                      ),
                      if (exp.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                          style: const TextStyle(fontSize: 9, color: _gray700, height: 1.5),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.education:
        if (d.education.isEmpty) return null;
        content = Column(
          children: d.education.map((edu) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    '${edu.startDate} – ${edu.endDate}',
                    style: const TextStyle(fontSize: 9, color: _amber, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                      ),
                      Text(
                        getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                        style: const TextStyle(fontSize: 10, color: _gray600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.skills:
        if (d.skills.isEmpty) return null;
        content = Wrap(
          spacing: 8,
          runSpacing: 8,
          children: d.skills.map((skill) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: _gray100,
              borderRadius: BorderRadius.circular(4),
              border: Border(left: BorderSide(color: _amber, width: 3)),
            ),
            child: Text(
              getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
              style: const TextStyle(fontSize: 10, color: _gray700, fontWeight: FontWeight.w500),
            ),
          )).toList(),
        );

      case SectionType.languages:
        if (d.languages.isEmpty) return null;
        content = Wrap(
          spacing: 16,
          runSpacing: 6,
          children: d.languages.map((l) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: _gray100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: l.language,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _gray900),
                ),
                TextSpan(
                  text: '  ${l.level}',
                  style: const TextStyle(fontSize: 9, color: _gray500),
                ),
              ]),
            ),
          )).toList(),
        );

      case SectionType.projects:
        if (d.projects.isEmpty) return null;
        content = Column(
          children: d.projects.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: _gray200),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                  ),
                  if (p.url.isNotEmpty)
                    Text(p.url, style: const TextStyle(fontSize: 9, color: _amber)),
                  if (p.description.isNotEmpty)
                    Text(
                      getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                      style: const TextStyle(fontSize: 9, color: _gray700),
                    ),
                ],
              ),
            ),
          )).toList(),
        );

      case SectionType.certifications:
        if (d.certifications.isEmpty) return null;
        content = Column(
          children: d.certifications.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 8, top: 2),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: _amber),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _gray900),
                      ),
                      TextSpan(
                        text: '  · ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                        style: const TextStyle(fontSize: 9, color: _gray500),
                      ),
                      if (c.date.isNotEmpty)
                        TextSpan(
                          text: ' (${c.date})',
                          style: const TextStyle(fontSize: 9, color: _gray500),
                        ),
                    ]),
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.volunteer:
        if (d.volunteer.isEmpty) return null;
        content = Column(
          children: d.volunteer.map((v) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    '${v.startDate} – ${v.endDate}',
                    style: const TextStyle(fontSize: 9, color: _amber, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                      ),
                      Text(
                        getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                        style: const TextStyle(fontSize: 10, color: _gray600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.interests:
        if (d.interests.isEmpty) return null;
        content = Text(
          getTranslated(tr, 'interests', lang, d.interests),
          style: const TextStyle(fontSize: 10, color: _gray700, height: 1.5),
        );

      default:
        return null;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [sectionHeader(), content],
      ),
    );
  }
}

// ─── PDF Builder ─────────────────────────────────────────────────────────────

Future<List<pw.Widget>> buildExecutivePdfWidgets(
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

  final pHeaderBg = PdfColor.fromHex('#0F172A');
  final pSlate800 = PdfColor.fromHex('#1E293B');
  final pSlate400 = PdfColor.fromHex('#94A3B8');
  final pAmber = PdfColor.fromHex('#F59E0B');
  final pAmberLight = PdfColor.fromHex('#FEF3C7');
  final pGray900 = PdfColor.fromHex('#111827');
  final pGray700 = PdfColor.fromHex('#374151');
  final pGray600 = PdfColor.fromHex('#4B5563');
  final pGray500 = PdfColor.fromHex('#6B7280');
  final pGray200 = PdfColor.fromHex('#E5E7EB');
  final pGray100 = PdfColor.fromHex('#F3F4F6');

  pw.TextStyle style({pw.Font? font, double size = 10, PdfColor? color, double? lineSpacing}) =>
      pw.TextStyle(font: font ?? regularFont, fontSize: size, color: color ?? pGray700, lineSpacing: lineSpacing);

  final contacts = <String>[
    if (pi.email.isNotEmpty) pi.email,
    if (pi.phone.isNotEmpty) pi.phone,
    if (pi.address.isNotEmpty) pi.address,
    if (pi.linkedin.isNotEmpty) pi.linkedin,
    if (pi.website.isNotEmpty) pi.website,
  ];

  final widgets = <pw.Widget>[
    // Header
    pw.Container(
      color: pHeaderBg,
      padding: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: pw.Row(
        children: [
          if (pi.photoBytes != null) ...[
            pw.Container(
              width: 60,
              height: 72,
              margin: const pw.EdgeInsets.only(right: 14),
              child: pw.Image(pw.MemoryImage(pi.photoBytes!), fit: pw.BoxFit.cover),
            ),
          ],
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${pi.firstName} ${pi.lastName}',
                  style: pw.TextStyle(font: boldFont, fontSize: 20, color: PdfColors.white, letterSpacing: 0.5),
                ),
                if (pi.birthDate.isNotEmpty || pi.nationality.isNotEmpty) ...[
                  pw.SizedBox(height: 3),
                  pw.Text(
                    [pi.birthDate, pi.nationality].where((s) => s.isNotEmpty).join('  ·  '),
                    style: style(size: 9, color: pAmber),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
    // Contact strip
    pw.Container(
      color: pSlate800,
      padding: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: pw.Wrap(
        spacing: 16,
        runSpacing: 2,
        children: contacts.map((c) => pw.Text(c, style: style(size: 8, color: pSlate400))).toList(),
      ),
    ),
    pw.SizedBox(height: 14),
  ];

  pw.Widget sectionHeader(String lbl) => pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 8),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Container(width: 4, height: 14, color: pAmber, margin: const pw.EdgeInsets.only(right: 8)),
                pw.Text(
                  lbl.toUpperCase(),
                  style: pw.TextStyle(font: boldFont, fontSize: 8, color: pHeaderBg, letterSpacing: 1.2),
                ),
              ],
            ),
            pw.SizedBox(height: 3),
            pw.Container(height: 0.5, color: pGray200),
          ],
        ),
      );

  for (final section in visible) {
    if (section.id == SectionType.personalInfo) continue;
    final lbl = _label(section.id.name, lang);
    pw.Widget? content;

    switch (section.id) {
      case SectionType.profile:
        if (data.profile.isEmpty) continue;
        content = pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            color: pAmberLight,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
            border: pw.Border.all(color: PdfColor.fromHex('#FDE68A')),
          ),
          child: pw.Text(
            getTranslated(tr, 'profile', lang, data.profile),
            style: style(lineSpacing: 4),
          ),
        );

      case SectionType.experience:
        if (data.experiences.isEmpty) continue;
        content = pw.Column(
          children: data.experiences.map((exp) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 10),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                              style: pw.TextStyle(font: boldFont, fontSize: 11, color: pGray900),
                            ),
                          ),
                          pw.Text(
                            '${exp.startDate} – ${exp.current ? _pres(lang) : exp.endDate}',
                            style: pw.TextStyle(font: boldFont, fontSize: 8, color: pAmber),
                          ),
                        ],
                      ),
                      pw.Text(
                        [
                          getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                          if (exp.location.isNotEmpty) getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                        ].join(' — '),
                        style: style(size: 9, color: pGray600),
                      ),
                      if (exp.description.isNotEmpty) ...[
                        pw.SizedBox(height: 3),
                        pw.Text(
                          getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                          style: style(size: 8, lineSpacing: 2),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.education:
        if (data.education.isEmpty) continue;
        content = pw.Column(
          children: data.education.map((edu) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 80,
                  child: pw.Text(
                    '${edu.startDate} – ${edu.endDate}',
                    style: pw.TextStyle(font: boldFont, fontSize: 8, color: pAmber),
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                        style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                      ),
                      pw.Text(
                        getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                        style: style(size: 9, color: pGray600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.skills:
        if (data.skills.isEmpty) continue;
        content = pw.Wrap(
          spacing: 6,
          runSpacing: 5,
          children: data.skills.map((skill) => pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: pw.BoxDecoration(
              color: pGray100,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              border: pw.Border(left: pw.BorderSide(color: pAmber, width: 3)),
            ),
            child: pw.Text(
              getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
              style: style(size: 8),
            ),
          )).toList(),
        );

      case SectionType.languages:
        if (data.languages.isEmpty) continue;
        content = pw.Wrap(
          spacing: 10,
          runSpacing: 4,
          children: data.languages.map((l) => pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: pw.BoxDecoration(
              color: pGray100,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
            ),
            child: pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(text: l.language, style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900)),
                pw.TextSpan(text: '  ${l.level}', style: style(size: 8, color: pGray500)),
              ]),
            ),
          )).toList(),
        );

      case SectionType.projects:
        if (data.projects.isEmpty) continue;
        content = pw.Column(
          children: data.projects.map((p) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 7),
            child: pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: pGray200),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                    style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900),
                  ),
                  if (p.url.isNotEmpty) pw.Text(p.url, style: style(size: 7, color: pAmber)),
                  if (p.description.isNotEmpty)
                    pw.Text(
                      getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                      style: style(size: 8),
                    ),
                ],
              ),
            ),
          )).toList(),
        );

      case SectionType.certifications:
        if (data.certifications.isEmpty) continue;
        content = pw.Column(
          children: data.certifications.map((c) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 4),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: 5,
                  height: 5,
                  margin: const pw.EdgeInsets.only(right: 6, top: 2),
                  decoration: pw.BoxDecoration(shape: pw.BoxShape.circle, color: pAmber),
                ),
                pw.Expanded(
                  child: pw.RichText(
                    text: pw.TextSpan(children: [
                      pw.TextSpan(
                        text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                        style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900),
                      ),
                      pw.TextSpan(
                        text: '  · ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                        style: style(size: 8, color: pGray500),
                      ),
                      if (c.date.isNotEmpty)
                        pw.TextSpan(text: ' (${c.date})', style: style(size: 8, color: pGray500)),
                    ]),
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.volunteer:
        if (data.volunteer.isEmpty) continue;
        content = pw.Column(
          children: data.volunteer.map((v) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 7),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 80,
                  child: pw.Text(
                    '${v.startDate} – ${v.endDate}',
                    style: pw.TextStyle(font: boldFont, fontSize: 8, color: pAmber),
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                        style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900),
                      ),
                      pw.Text(
                        getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                        style: style(size: 8, color: pGray600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.interests:
        if (data.interests.isEmpty) continue;
        content = pw.Text(
          getTranslated(tr, 'interests', lang, data.interests),
          style: style(lineSpacing: 3),
        );

      default:
        continue;
    }

    widgets.add(pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 14),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [sectionHeader(lbl), content],
      ),
    ));
  }

  return widgets;
}
