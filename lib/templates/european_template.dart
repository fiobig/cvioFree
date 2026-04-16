import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/cv_data.dart';

// ─── Section labels ───────────────────────────────────────────────────────────

const _labels = {
  'profile': {Language.it: 'Profilo Professionale', Language.en: 'Professional Profile', Language.es: 'Perfil Profesional'},
  'experience': {Language.it: 'Esperienza Lavorativa', Language.en: 'Work Experience', Language.es: 'Experiencia Laboral'},
  'education': {Language.it: 'Istruzione e Formazione', Language.en: 'Education and Training', Language.es: 'Educación y Formación'},
  'skills': {Language.it: 'Competenze', Language.en: 'Skills', Language.es: 'Competencias'},
  'languages': {Language.it: 'Lingue', Language.en: 'Languages', Language.es: 'Idiomas'},
  'projects': {Language.it: 'Progetti', Language.en: 'Projects', Language.es: 'Proyectos'},
  'certifications': {Language.it: 'Certificazioni', Language.en: 'Certifications', Language.es: 'Certificaciones'},
  'volunteer': {Language.it: 'Volontariato', Language.en: 'Volunteer Work', Language.es: 'Voluntariado'},
  'interests': {Language.it: 'Interessi', Language.en: 'Interests', Language.es: 'Intereses'},
};

const _present = {Language.it: 'Presente', Language.en: 'Present', Language.es: 'Presente'};

String _label(String key, Language lang) => _labels[key]?[lang] ?? key;
String _pres(Language lang) => _present[lang] ?? 'Present';

// ─── Color constants ───────────────────────────────────────────────────────────

const _blue = Color(0xFF2563EB);
const _blueLight = Color(0xFF1D4ED8);
const _gray900 = Color(0xFF111827);
const _gray700 = Color(0xFF374151);
const _gray600 = Color(0xFF4B5563);
const _gray500 = Color(0xFF6B7280);
const _gray400 = Color(0xFF9CA3AF);
const _gray200 = Color(0xFFE5E7EB);
const _gray100 = Color(0xFFF3F4F6);

// ─── Flutter Widget (screen preview) ─────────────────────────────────────────

class EuropeanTemplate extends StatelessWidget {
  const EuropeanTemplate({super.key, required this.data, required this.lang});

  final CVData data;
  final Language lang;

  @override
  Widget build(BuildContext context) {
    final pi = data.personalInfo;
    final visibleSections = data.sections
        .where((s) => s.enabled && (!s.isModern || data.modernMode))
        .toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(pi),
          const SizedBox(height: 20),
          // Sections
          ...visibleSections
              .map((s) => _buildSection(s.id, data, lang))
              .whereType<Widget>(),
        ],
      ),
    );
  }

  Widget _buildHeader(PersonalInfo pi) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _blue, width: 2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pi.photoBytes != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.memory(
                pi.photoBytes!,
                width: 72,
                height: 88,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${pi.firstName} ${pi.lastName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _gray900,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 24,
                  runSpacing: 2,
                  children: [
                    if (pi.address.isNotEmpty) _infoText(pi.address),
                    if (pi.phone.isNotEmpty) _infoText(pi.phone),
                    if (pi.email.isNotEmpty) _infoText(pi.email),
                    if (pi.birthDate.isNotEmpty) _infoText(pi.birthDate),
                    if (pi.nationality.isNotEmpty) _infoText(pi.nationality),
                    if (pi.linkedin.isNotEmpty) _infoText(pi.linkedin),
                    if (pi.website.isNotEmpty) _infoText(pi.website),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoText(String text) => Text(
        text,
        style: const TextStyle(fontSize: 10, color: _gray600),
      );

  Widget? _buildSection(SectionType id, CVData d, Language lang) {
    final tr = d.translations;
    final label = _label(id.name, lang);

    switch (id) {
      case SectionType.personalInfo:
        return null;

      case SectionType.profile:
        if (d.profile.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Text(
            getTranslated(tr, 'profile', lang, d.profile),
            style: const TextStyle(fontSize: 10, color: _gray700, height: 1.5),
          ),
        );

      case SectionType.experience:
        if (d.experiences.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Column(
            children: d.experiences.map((exp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${exp.startDate} - ${exp.current ? _pres(lang) : exp.endDate}',
                      style: const TextStyle(fontSize: 9, color: _gray500),
                    ),
                    Text(
                      getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                    ),
                    Text(
                      [
                        getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                        if (exp.location.isNotEmpty)
                          getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                      ].join(', '),
                      style: const TextStyle(fontSize: 10, color: _blueLight),
                    ),
                    if (exp.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                          style: const TextStyle(fontSize: 9, color: _gray600, height: 1.4),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case SectionType.education:
        if (d.education.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Column(
            children: d.education.map((edu) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${edu.startDate} - ${edu.endDate}',
                        style: const TextStyle(fontSize: 9, color: _gray500)),
                    Text(
                      getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                    ),
                    Text(
                      getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                      style: const TextStyle(fontSize: 10, color: _blueLight),
                    ),
                    if (edu.description.isNotEmpty)
                      Text(
                        getTranslated(tr, 'edu.${edu.id}.description', lang, edu.description),
                        style: const TextStyle(fontSize: 9, color: _gray600),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case SectionType.skills:
        if (d.skills.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Column(
            children: d.skills.map((skill) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                        style: const TextStyle(fontSize: 10, color: _gray700),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Container(
                          width: 12,
                          height: 6,
                          margin: const EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: i < skill.level ? _blue : _gray200,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case SectionType.languages:
        if (d.languages.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Column(
            children: d.languages.map((l) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Text(l.language,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: _gray700)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: _gray100,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(l.level, style: const TextStyle(fontSize: 9, color: _gray500)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case SectionType.projects:
        if (d.projects.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Column(
            children: d.projects.map((p) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                    ),
                    if (p.url.isNotEmpty)
                      Text(p.url, style: const TextStyle(fontSize: 9, color: _blue)),
                    if (p.description.isNotEmpty)
                      Text(
                        getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                        style: const TextStyle(fontSize: 9, color: _gray600),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case SectionType.certifications:
        if (d.certifications.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Column(
            children: d.certifications.map((c) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: _gray700),
                      ),
                      TextSpan(
                        text: ' - ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                        style: const TextStyle(fontSize: 9, color: _gray500),
                      ),
                      if (c.date.isNotEmpty)
                        TextSpan(
                          text: ' (${c.date})',
                          style: const TextStyle(fontSize: 9, color: _gray400),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );

      case SectionType.volunteer:
        if (d.volunteer.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Column(
            children: d.volunteer.map((v) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${v.startDate} - ${v.endDate}',
                        style: const TextStyle(fontSize: 9, color: _gray500)),
                    Text(
                      getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                    ),
                    Text(
                      getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                      style: const TextStyle(fontSize: 10, color: _blueLight),
                    ),
                    if (v.description.isNotEmpty)
                      Text(
                        getTranslated(tr, 'vol.${v.id}.description', lang, v.description),
                        style: const TextStyle(fontSize: 9, color: _gray600),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case SectionType.interests:
        if (d.interests.isEmpty) return null;
        return _SectionRow(
          label: label,
          child: Text(
            getTranslated(tr, 'interests', lang, d.interests),
            style: const TextStyle(fontSize: 10, color: _gray700),
          ),
        );
    }
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Padding(
              padding: const EdgeInsets.only(top: 2, right: 12),
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 9,
                  color: _gray500,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Container(
            width: 2,
            color: _blue,
            margin: const EdgeInsets.only(right: 12),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ─── PDF Builder ─────────────────────────────────────────────────────────────

Future<List<pw.Widget>> buildEuropeanPdfWidgets(
  CVData data,
  Language lang,
  pw.Font regularFont,
  pw.Font boldFont,
  pw.Font italicFont,
) async {
  final pi = data.personalInfo;
  final tr = data.translations;
  final visibleSections = data.sections
      .where((s) => s.enabled && (!s.isModern || data.modernMode))
      .toList();

  final pBlue = PdfColor.fromHex('#2563EB');
  final pGray900 = PdfColor.fromHex('#111827');
  final pGray700 = PdfColor.fromHex('#374151');
  final pGray600 = PdfColor.fromHex('#4B5563');
  final pGray500 = PdfColor.fromHex('#6B7280');
  final pGray400 = PdfColor.fromHex('#9CA3AF');
  final pGray200 = PdfColor.fromHex('#E5E7EB');
  final pGray100 = PdfColor.fromHex('#F3F4F6');
  final pBlueLight = PdfColor.fromHex('#1D4ED8');

  pw.TextStyle style({
    pw.Font? font,
    double size = 10,
    PdfColor? color,
    double? lineSpacing,
  }) =>
      pw.TextStyle(
        font: font ?? regularFont,
        fontSize: size,
        color: color ?? pGray700,
        lineSpacing: lineSpacing,
      );

  // Header
  final headerChildren = <pw.Widget>[
    if (pi.photoBytes != null)
      pw.Container(
        width: 60,
        height: 72,
        margin: const pw.EdgeInsets.only(right: 12),
        child: pw.Image(pw.MemoryImage(pi.photoBytes!), fit: pw.BoxFit.cover),
      ),
    pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '${pi.firstName} ${pi.lastName}',
            style: pw.TextStyle(font: boldFont, fontSize: 18, color: pGray900),
          ),
          pw.SizedBox(height: 4),
          pw.Wrap(
            spacing: 16,
            runSpacing: 2,
            children: [
              if (pi.address.isNotEmpty) pw.Text(pi.address, style: style(size: 9, color: pGray600)),
              if (pi.phone.isNotEmpty) pw.Text(pi.phone, style: style(size: 9, color: pGray600)),
              if (pi.email.isNotEmpty) pw.Text(pi.email, style: style(size: 9, color: pGray600)),
              if (pi.birthDate.isNotEmpty) pw.Text(pi.birthDate, style: style(size: 9, color: pGray600)),
              if (pi.nationality.isNotEmpty) pw.Text(pi.nationality, style: style(size: 9, color: pGray600)),
              if (pi.linkedin.isNotEmpty) pw.Text(pi.linkedin, style: style(size: 9, color: pGray600)),
              if (pi.website.isNotEmpty) pw.Text(pi.website, style: style(size: 9, color: pGray600)),
            ],
          ),
        ],
      ),
    ),
  ];

  final widgets = <pw.Widget>[
    pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 12),
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: pBlue, width: 2)),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: headerChildren,
      ),
    ),
    pw.SizedBox(height: 12),
  ];

  // Sections
  for (final section in visibleSections) {
    if (section.id == SectionType.personalInfo) continue;
    final lbl = _label(section.id.name, lang);

    pw.Widget? content;

    switch (section.id) {
      case SectionType.profile:
        if (data.profile.isEmpty) continue;
        content = pw.Text(
          getTranslated(tr, 'profile', lang, data.profile),
          style: style(lineSpacing: 3),
        );

      case SectionType.experience:
        if (data.experiences.isEmpty) continue;
        content = pw.Column(
          children: data.experiences.map((exp) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '${exp.startDate} - ${exp.current ? _pres(lang) : exp.endDate}',
                    style: style(size: 8, color: pGray500),
                  ),
                  pw.Text(
                    getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                    style: pw.TextStyle(font: boldFont, fontSize: 11, color: pGray900),
                  ),
                  pw.Text(
                    [
                      getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                      if (exp.location.isNotEmpty)
                        getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                    ].join(', '),
                    style: style(size: 9, color: pBlueLight),
                  ),
                  if (exp.description.isNotEmpty)
                    pw.Text(
                      getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                      style: style(size: 8, color: pGray600, lineSpacing: 2),
                    ),
                ],
              ),
            );
          }).toList(),
        );

      case SectionType.education:
        if (data.education.isEmpty) continue;
        content = pw.Column(
          children: data.education.map((edu) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('${edu.startDate} - ${edu.endDate}',
                      style: style(size: 8, color: pGray500)),
                  pw.Text(
                    getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                    style: pw.TextStyle(font: boldFont, fontSize: 11, color: pGray900),
                  ),
                  pw.Text(
                    getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                    style: style(size: 9, color: pBlueLight),
                  ),
                  if (edu.description.isNotEmpty)
                    pw.Text(
                      getTranslated(tr, 'edu.${edu.id}.description', lang, edu.description),
                      style: style(size: 8, color: pGray600),
                    ),
                ],
              ),
            );
          }).toList(),
        );

      case SectionType.skills:
        if (data.skills.isEmpty) continue;
        content = pw.Column(
          children: data.skills.map((skill) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Row(
                children: [
                  pw.SizedBox(
                    width: 80,
                    child: pw.Text(
                      getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                      style: style(size: 9),
                    ),
                  ),
                  pw.Row(
                    children: List.generate(5, (i) {
                      return pw.Container(
                        width: 10,
                        height: 5,
                        margin: const pw.EdgeInsets.only(right: 2),
                        decoration: pw.BoxDecoration(
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                          color: i < skill.level ? pBlue : pGray200,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          }).toList(),
        );

      case SectionType.languages:
        if (data.languages.isEmpty) continue;
        content = pw.Column(
          children: data.languages.map((l) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 3),
              child: pw.Row(
                children: [
                  pw.Text(l.language,
                      style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray700)),
                  pw.SizedBox(width: 6),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: pw.BoxDecoration(
                      color: pGray100,
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                    ),
                    child: pw.Text(l.level, style: style(size: 8, color: pGray500)),
                  ),
                ],
              ),
            );
          }).toList(),
        );

      case SectionType.projects:
        if (data.projects.isEmpty) continue;
        content = pw.Column(
          children: data.projects.map((p) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                    style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                  ),
                  if (p.url.isNotEmpty) pw.Text(p.url, style: style(size: 8, color: pBlue)),
                  if (p.description.isNotEmpty)
                    pw.Text(
                      getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                      style: style(size: 8, color: pGray600),
                    ),
                ],
              ),
            );
          }).toList(),
        );

      case SectionType.certifications:
        if (data.certifications.isEmpty) continue;
        content = pw.Column(
          children: data.certifications.map((c) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 3),
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                      style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray700),
                    ),
                    pw.TextSpan(
                      text: ' - ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                      style: style(size: 8, color: pGray500),
                    ),
                    if (c.date.isNotEmpty)
                      pw.TextSpan(
                        text: ' (${c.date})',
                        style: style(size: 8, color: pGray400),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        );

      case SectionType.volunteer:
        if (data.volunteer.isEmpty) continue;
        content = pw.Column(
          children: data.volunteer.map((v) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('${v.startDate} - ${v.endDate}',
                      style: style(size: 8, color: pGray500)),
                  pw.Text(
                    getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                    style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                  ),
                  pw.Text(
                    getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                    style: style(size: 9, color: pBlueLight),
                  ),
                  if (v.description.isNotEmpty)
                    pw.Text(
                      getTranslated(tr, 'vol.${v.id}.description', lang, v.description),
                      style: style(size: 8, color: pGray600),
                    ),
                ],
              ),
            );
          }).toList(),
        );

      case SectionType.interests:
        if (data.interests.isEmpty) continue;
        content = pw.Text(
          getTranslated(tr, 'interests', lang, data.interests),
          style: style(),
        );

      default:
        continue;
    }

    widgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 110,
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(top: 1, right: 10),
                child: pw.Text(
                  lbl.toUpperCase(),
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 7,
                    color: pGray500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            pw.Container(width: 2, color: pBlue, margin: const pw.EdgeInsets.only(right: 10)),
            pw.Expanded(child: content),
          ],
        ),
      ),
    );
  }

  return widgets;
}
