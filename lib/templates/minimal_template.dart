import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/cv_data.dart';

// ─── Labels ──────────────────────────────────────────────────────────────────

const _labels = {
  'profile': {Language.it: 'Profilo', Language.en: 'Profile', Language.es: 'Perfil'},
  'experience': {Language.it: 'Esperienza', Language.en: 'Experience', Language.es: 'Experiencia'},
  'education': {Language.it: 'Formazione', Language.en: 'Education', Language.es: 'Educación'},
  'skills': {Language.it: 'Competenze', Language.en: 'Skills', Language.es: 'Competencias'},
  'languages': {Language.it: 'Lingue', Language.en: 'Languages', Language.es: 'Idiomas'},
  'projects': {Language.it: 'Progetti', Language.en: 'Projects', Language.es: 'Proyectos'},
  'certifications': {Language.it: 'Certificazioni', Language.en: 'Certifications', Language.es: 'Certificaciones'},
  'volunteer': {Language.it: 'Volontariato', Language.en: 'Volunteer', Language.es: 'Voluntariado'},
  'interests': {Language.it: 'Interessi', Language.en: 'Interests', Language.es: 'Intereses'},
};

const _present = {Language.it: 'Presente', Language.en: 'Present', Language.es: 'Presente'};
String _label(String key, Language lang) => _labels[key]?[lang] ?? key;
String _pres(Language lang) => _present[lang] ?? 'Present';

// ─── Colors ───────────────────────────────────────────────────────────────────

const _accent = Color(0xFF6366F1);     // indigo-500
const _gray900 = Color(0xFF111827);
const _gray700 = Color(0xFF374151);
const _gray500 = Color(0xFF6B7280);
const _gray400 = Color(0xFF9CA3AF);
const _gray200 = Color(0xFFE5E7EB);
const _gray100 = Color(0xFFF3F4F6);

// ─── Flutter Widget ───────────────────────────────────────────────────────────

class MinimalTemplate extends StatelessWidget {
  const MinimalTemplate({super.key, required this.data, required this.lang});
  final CVData data;
  final Language lang;

  @override
  Widget build(BuildContext context) {
    final pi = data.personalInfo;
    final tr = data.translations;
    final visible = data.sections
        .where((s) => s.enabled && (!s.isModern || data.modernMode))
        .toList();

    final contacts = [
      pi.email, pi.phone, pi.address, pi.linkedin, pi.website,
    ].where((s) => s.isNotEmpty).toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          if (pi.photoBytes != null) ...[
            ClipOval(
              child: Image.memory(pi.photoBytes!, width: 72, height: 72, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
          ],
          Text(
            '${pi.firstName} ${pi.lastName}'.trim(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: _gray900,
              letterSpacing: 2,
            ),
          ),
          if (contacts.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              contacts.join('  ·  '),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, color: _gray500, letterSpacing: 0.3),
            ),
          ],
          if (pi.birthDate.isNotEmpty || pi.nationality.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              [pi.birthDate, pi.nationality].where((s) => s.isNotEmpty).join('  ·  '),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, color: _gray400),
            ),
          ],
          const SizedBox(height: 16),
          Container(height: 1, color: _accent),
          const SizedBox(height: 16),
          // ── Sections ────────────────────────────────────────────────────
          ...visible
              .map((s) => _buildSection(s.id, data, tr, lang))
              .whereType<Widget>(),
        ],
      ),
    );
  }

  Widget? _buildSection(SectionType id, CVData d, Map<String, TranslatedField> tr, Language lang) {
    if (id == SectionType.personalInfo) return null;
    final lbl = _label(id.name, lang);

    Widget sectionHeader() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lbl.toUpperCase(),
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: _accent,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Container(height: 0.5, color: _gray200),
            const SizedBox(height: 8),
          ],
        );

    Widget? content;
    switch (id) {
      case SectionType.profile:
        if (d.profile.isEmpty) return null;
        content = Text(
          getTranslated(tr, 'profile', lang, d.profile),
          style: const TextStyle(fontSize: 10, color: _gray700, height: 1.6),
        );

      case SectionType.experience:
        if (d.experiences.isEmpty) return null;
        content = Column(
          children: d.experiences.map((exp) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    '${exp.startDate}\n– ${exp.current ? _pres(lang) : exp.endDate}',
                    style: const TextStyle(fontSize: 8, color: _gray400, height: 1.4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _gray900),
                      ),
                      Text(
                        [
                          getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                          if (exp.location.isNotEmpty) getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                        ].join(', '),
                        style: const TextStyle(fontSize: 9, color: _gray500),
                      ),
                      if (exp.description.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                          style: const TextStyle(fontSize: 9, color: _gray700, height: 1.4),
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
                  width: 70,
                  child: Text(
                    '${edu.startDate}\n– ${edu.endDate}',
                    style: const TextStyle(fontSize: 8, color: _gray400, height: 1.4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _gray900),
                      ),
                      Text(
                        getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                        style: const TextStyle(fontSize: 9, color: _gray500),
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
          spacing: 6,
          runSpacing: 6,
          children: d.skills.map((skill) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _gray100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _gray200),
            ),
            child: Text(
              getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
              style: const TextStyle(fontSize: 9, color: _gray700),
            ),
          )).toList(),
        );

      case SectionType.languages:
        if (d.languages.isEmpty) return null;
        content = Wrap(
          spacing: 16,
          runSpacing: 4,
          children: d.languages.map((l) => RichText(
            text: TextSpan(children: [
              TextSpan(text: l.language, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _gray700)),
              TextSpan(text: '  ${l.level}', style: const TextStyle(fontSize: 9, color: _gray400)),
            ]),
          )).toList(),
        );

      case SectionType.projects:
        if (d.projects.isEmpty) return null;
        content = Column(
          children: d.projects.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _gray900),
                ),
                if (p.url.isNotEmpty)
                  Text(p.url, style: const TextStyle(fontSize: 9, color: _accent)),
                if (p.description.isNotEmpty)
                  Text(
                    getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                    style: const TextStyle(fontSize: 9, color: _gray700),
                  ),
              ],
            ),
          )).toList(),
        );

      case SectionType.certifications:
        if (d.certifications.isEmpty) return null;
        content = Column(
          children: d.certifications.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _gray700),
                  ),
                ),
                Text(
                  '${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}${c.date.isNotEmpty ? " · ${c.date}" : ""}',
                  style: const TextStyle(fontSize: 9, color: _gray400),
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
                  width: 70,
                  child: Text(
                    '${v.startDate}\n– ${v.endDate}',
                    style: const TextStyle(fontSize: 8, color: _gray400, height: 1.4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _gray900),
                      ),
                      Text(
                        getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                        style: const TextStyle(fontSize: 9, color: _gray500),
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
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [sectionHeader(), content],
      ),
    );
  }
}

// ─── PDF Builder ─────────────────────────────────────────────────────────────

Future<List<pw.Widget>> buildMinimalPdfWidgets(
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

  final pAccent = PdfColor.fromHex('#6366F1');
  final pGray900 = PdfColor.fromHex('#111827');
  final pGray700 = PdfColor.fromHex('#374151');
  final pGray500 = PdfColor.fromHex('#6B7280');
  final pGray400 = PdfColor.fromHex('#9CA3AF');
  final pGray200 = PdfColor.fromHex('#E5E7EB');
  final pGray100 = PdfColor.fromHex('#F3F4F6');

  pw.TextStyle style({pw.Font? font, double size = 10, PdfColor? color, double? lineSpacing}) =>
      pw.TextStyle(font: font ?? regularFont, fontSize: size, color: color ?? pGray700, lineSpacing: lineSpacing);

  final contacts = [
    pi.email, pi.phone, pi.address, pi.linkedin, pi.website,
  ].where((s) => s.isNotEmpty).toList();

  final widgets = <pw.Widget>[
    // Header
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        if (pi.photoBytes != null) ...[
          pw.Container(
            width: 56,
            height: 56,
            decoration: pw.BoxDecoration(shape: pw.BoxShape.circle),
            child: pw.ClipOval(child: pw.Image(pw.MemoryImage(pi.photoBytes!), fit: pw.BoxFit.cover)),
          ),
          pw.SizedBox(height: 8),
        ],
        pw.Text(
          '${pi.firstName} ${pi.lastName}'.trim(),
          style: pw.TextStyle(font: regularFont, fontSize: 22, color: pGray900, letterSpacing: 2),
          textAlign: pw.TextAlign.center,
        ),
        if (contacts.isNotEmpty) ...[
          pw.SizedBox(height: 5),
          pw.Text(
            contacts.join('  ·  '),
            style: style(size: 8, color: pGray500),
            textAlign: pw.TextAlign.center,
          ),
        ],
        if (pi.birthDate.isNotEmpty || pi.nationality.isNotEmpty) ...[
          pw.SizedBox(height: 2),
          pw.Text(
            [pi.birthDate, pi.nationality].where((s) => s.isNotEmpty).join('  ·  '),
            style: style(size: 8, color: pGray400),
            textAlign: pw.TextAlign.center,
          ),
        ],
        pw.SizedBox(height: 12),
        pw.Container(height: 1, color: pAccent),
        pw.SizedBox(height: 12),
      ],
    ),
  ];

  pw.Widget sectionHeader(String lbl) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            lbl.toUpperCase(),
            style: pw.TextStyle(font: boldFont, fontSize: 7, color: pAccent, letterSpacing: 1.5),
          ),
          pw.SizedBox(height: 3),
          pw.Container(height: 0.5, color: pGray200),
          pw.SizedBox(height: 6),
        ],
      );

  for (final section in visible) {
    if (section.id == SectionType.personalInfo) continue;
    final lbl = _label(section.id.name, lang);

    pw.Widget? content;
    switch (section.id) {
      case SectionType.profile:
        if (data.profile.isEmpty) continue;
        content = pw.Text(
          getTranslated(tr, 'profile', lang, data.profile),
          style: style(lineSpacing: 4),
        );

      case SectionType.experience:
        if (data.experiences.isEmpty) continue;
        content = pw.Column(
          children: data.experiences.map((exp) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 60,
                  child: pw.Text(
                    '${exp.startDate} – ${exp.current ? _pres(lang) : exp.endDate}',
                    style: style(size: 7, color: pGray400),
                  ),
                ),
                pw.SizedBox(width: 10),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                        style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                      ),
                      pw.Text(
                        [
                          getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                          if (exp.location.isNotEmpty) getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                        ].join(', '),
                        style: style(size: 8, color: pGray500),
                      ),
                      if (exp.description.isNotEmpty)
                        pw.Text(
                          getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                          style: style(size: 8, lineSpacing: 2),
                        ),
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
                  width: 60,
                  child: pw.Text(
                    '${edu.startDate} – ${edu.endDate}',
                    style: style(size: 7, color: pGray400),
                  ),
                ),
                pw.SizedBox(width: 10),
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
                        style: style(size: 8, color: pGray500),
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
          runSpacing: 4,
          children: data.skills.map((skill) => pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: pw.BoxDecoration(
              color: pGray100,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
              border: pw.Border.all(color: pGray200),
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
          spacing: 16,
          runSpacing: 3,
          children: data.languages.map((l) => pw.RichText(
            text: pw.TextSpan(children: [
              pw.TextSpan(
                text: l.language,
                style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray700),
              ),
              pw.TextSpan(
                text: '  ${l.level}',
                style: style(size: 8, color: pGray400),
              ),
            ]),
          )).toList(),
        );

      case SectionType.projects:
        if (data.projects.isEmpty) continue;
        content = pw.Column(
          children: data.projects.map((p) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                  style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900),
                ),
                if (p.url.isNotEmpty) pw.Text(p.url, style: style(size: 7, color: pAccent)),
                if (p.description.isNotEmpty)
                  pw.Text(
                    getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                    style: style(size: 8),
                  ),
              ],
            ),
          )).toList(),
        );

      case SectionType.certifications:
        if (data.certifications.isEmpty) continue;
        content = pw.Column(
          children: data.certifications.map((c) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                    style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray700),
                  ),
                ),
                pw.Text(
                  '${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}${c.date.isNotEmpty ? " · ${c.date}" : ""}',
                  style: style(size: 8, color: pGray400),
                ),
              ],
            ),
          )).toList(),
        );

      case SectionType.volunteer:
        if (data.volunteer.isEmpty) continue;
        content = pw.Column(
          children: data.volunteer.map((v) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 60,
                  child: pw.Text(
                    '${v.startDate} – ${v.endDate}',
                    style: style(size: 7, color: pGray400),
                  ),
                ),
                pw.SizedBox(width: 10),
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
                        style: style(size: 8, color: pGray500),
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
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [sectionHeader(lbl), content],
      ),
    ));
  }

  return widgets;
}
