import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/cv_data.dart';

const _labels = {
  'profile': {Language.it: 'Profilo', Language.en: 'Profile', Language.es: 'Perfil'},
  'experience': {Language.it: 'Esperienza Professionale', Language.en: 'Professional Experience', Language.es: 'Experiencia Profesional'},
  'education': {Language.it: 'Formazione', Language.en: 'Education', Language.es: 'Formación'},
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

const _emerald900 = Color(0xFF064E3B);
const _emerald800 = Color(0xFF065F46);
const _emerald700 = Color(0xFF047857);
const _emerald50 = Color(0xFFECFDF5);
const _emerald200 = Color(0xFFA7F3D0);
const _gray900 = Color(0xFF111827);
const _gray700 = Color(0xFF374151);
const _gray600 = Color(0xFF4B5563);
const _gray500 = Color(0xFF6B7280);
const _gray400 = Color(0xFF9CA3AF);

// ─── Flutter Widget ───────────────────────────────────────────────────────────

class ClassicTemplate extends StatelessWidget {
  const ClassicTemplate({super.key, required this.data, required this.lang});
  final CVData data;
  final Language lang;

  @override
  Widget build(BuildContext context) {
    final pi = data.personalInfo;
    final tr = data.translations;
    final visible = data.sections
        .where((s) => s.enabled && (!s.isModern || data.modernMode))
        .toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          _buildHeader(pi),
          // Photo (below header for classic)
          if (pi.photoBytes != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.memory(pi.photoBytes!, width: 56, height: 72, fit: BoxFit.cover),
            ),
          ],
          // Sections
          ...visible.map((s) => _buildSection(s.id, data, tr, lang)).whereType<Widget>(),
        ],
      ),
    );
  }

  Widget _buildHeader(PersonalInfo pi) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _emerald800, width: 2)),
      ),
      child: Column(
        children: [
          Text(
            '${pi.firstName} ${pi.lastName}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _emerald900,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 2,
            children: [
              if (pi.email.isNotEmpty) _contactItem(pi.email, isFirst: true),
              if (pi.phone.isNotEmpty) _contactItem(pi.phone),
              if (pi.address.isNotEmpty) _contactItem(pi.address),
              if (pi.linkedin.isNotEmpty) _contactItem(pi.linkedin),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactItem(String text, {bool isFirst = false}) => Text(
        isFirst ? text : '| $text',
        style: const TextStyle(fontSize: 9, color: _gray600),
      );

  Widget? _buildSection(SectionType id, CVData d, Map<String, TranslatedField> tr, Language lang) {
    if (id == SectionType.personalInfo) return null;
    final lbl = _label(id.name, lang);

    Widget sectionTitle(String t) => Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _emerald800,
                  letterSpacing: 0.5,
                ),
              ),
              Container(height: 2, color: _emerald800),
            ],
          ),
        );

    switch (id) {
      case SectionType.profile:
        if (d.profile.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            Text(
              getTranslated(tr, 'profile', lang, d.profile),
              style: const TextStyle(fontSize: 10, color: _gray700, height: 1.5),
            ),
          ],
        );

      case SectionType.experience:
        if (d.experiences.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...d.experiences.map((exp) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                            ),
                          ),
                          Text(
                            '${exp.startDate} - ${exp.current ? _pres(lang) : exp.endDate}',
                            style: const TextStyle(fontSize: 9, color: _gray500),
                          ),
                        ],
                      ),
                      Text(
                        [
                          getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                          if (exp.location.isNotEmpty)
                            getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                        ].join(' | '),
                        style: const TextStyle(fontSize: 10, color: _emerald700, fontStyle: FontStyle.italic),
                      ),
                      if (exp.description.isNotEmpty)
                        Text(
                          getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                          style: const TextStyle(fontSize: 9, color: _gray600, height: 1.4),
                        ),
                    ],
                  ),
                )),
          ],
        );

      case SectionType.education:
        if (d.education.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...d.education.map((edu) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                            ),
                          ),
                          Text(
                            '${edu.startDate} - ${edu.endDate}',
                            style: const TextStyle(fontSize: 9, color: _gray500),
                          ),
                        ],
                      ),
                      Text(
                        getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                        style: const TextStyle(fontSize: 10, color: _emerald700, fontStyle: FontStyle.italic),
                      ),
                      if (edu.description.isNotEmpty)
                        Text(
                          getTranslated(tr, 'edu.${edu.id}.description', lang, edu.description),
                          style: const TextStyle(fontSize: 9, color: _gray600),
                        ),
                    ],
                  ),
                )),
          ],
        );

      case SectionType.skills:
        if (d.skills.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: d.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _emerald50,
                    border: Border.all(color: _emerald200),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                          style: const TextStyle(fontSize: 9, color: _emerald800),
                        ),
                        TextSpan(
                          text: ' ${'●' * skill.level}${'○' * (5 - skill.level)}',
                          style: const TextStyle(fontSize: 8, color: _emerald700),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );

      case SectionType.languages:
        if (d.languages.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: d.languages.map((l) {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: l.language,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: _gray700),
                      ),
                      TextSpan(
                        text: ' (${l.level})',
                        style: const TextStyle(fontSize: 9, color: _gray400),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );

      case SectionType.projects:
        if (d.projects.isEmpty) return null;
        return Column(
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
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _gray900),
                      ),
                      if (p.description.isNotEmpty)
                        Text(
                          getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                          style: const TextStyle(fontSize: 9, color: _gray600),
                        ),
                    ],
                  ),
                )),
          ],
        );

      case SectionType.certifications:
        if (d.certifications.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...d.certifications.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: _gray700),
                      ),
                      TextSpan(
                        text: ' - ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                        style: const TextStyle(fontSize: 9, color: _gray500),
                      ),
                    ]),
                  ),
                )),
          ],
        );

      case SectionType.volunteer:
        if (d.volunteer.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...d.volunteer.map((v) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                      ),
                      Text(
                        getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                        style: const TextStyle(fontSize: 10, color: _emerald700, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )),
          ],
        );

      case SectionType.interests:
        if (d.interests.isEmpty) return null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            Text(
              getTranslated(tr, 'interests', lang, d.interests),
              style: const TextStyle(fontSize: 10, color: _gray700),
            ),
          ],
        );

      default:
        return null;
    }
  }
}

// ─── PDF Builder ─────────────────────────────────────────────────────────────

Future<List<pw.Widget>> buildClassicPdfWidgets(
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

  final pEmerald900 = PdfColor.fromHex('#064E3B');
  final pEmerald800 = PdfColor.fromHex('#065F46');
  final pEmerald700 = PdfColor.fromHex('#047857');
  final pEmerald50 = PdfColor.fromHex('#ECFDF5');
  final pEmerald200 = PdfColor.fromHex('#A7F3D0');
  final pGray900 = PdfColor.fromHex('#111827');
  final pGray700 = PdfColor.fromHex('#374151');
  final pGray600 = PdfColor.fromHex('#4B5563');
  final pGray500 = PdfColor.fromHex('#6B7280');
  final pGray400 = PdfColor.fromHex('#9CA3AF');

  pw.TextStyle style({pw.Font? font, double size = 10, PdfColor? color, double? lineSpacing, FontStyle? fontStyle}) =>
      pw.TextStyle(
        font: fontStyle == FontStyle.italic ? italicFont : (font ?? regularFont),
        fontSize: size,
        color: color ?? pGray700,
        lineSpacing: lineSpacing,
      );

  pw.Widget sectionTitle(String t) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              t.toUpperCase(),
              style: pw.TextStyle(font: boldFont, fontSize: 10, color: pEmerald800, letterSpacing: 0.5),
            ),
            pw.Container(height: 2, color: pEmerald800),
          ],
        ),
      );

  final widgets = <pw.Widget>[];

  // Header (centered)
  final contactItems = <String>[
    if (pi.email.isNotEmpty) pi.email,
    if (pi.phone.isNotEmpty) pi.phone,
    if (pi.address.isNotEmpty) pi.address,
    if (pi.linkedin.isNotEmpty) pi.linkedin,
  ];

  widgets.add(
    pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: pEmerald800, width: 2)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            '${pi.firstName} ${pi.lastName}',
            style: pw.TextStyle(font: boldFont, fontSize: 20, color: pEmerald900, letterSpacing: 1),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            contactItems.join(' | '),
            style: style(size: 8, color: pGray600),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    ),
  );

  if (pi.photoBytes != null) {
    widgets.add(pw.SizedBox(height: 8));
    widgets.add(
      pw.Center(
        child: pw.Container(
          width: 48,
          height: 60,
          child: pw.Image(pw.MemoryImage(pi.photoBytes!), fit: pw.BoxFit.cover),
        ),
      ),
    );
  }

  // Sections
  for (final section in visible) {
    if (section.id == SectionType.personalInfo) continue;
    final lbl = _label(section.id.name, lang);
    pw.Widget? content;

    switch (section.id) {
      case SectionType.profile:
        if (data.profile.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            pw.Text(getTranslated(tr, 'profile', lang, data.profile), style: style(lineSpacing: 2)),
          ],
        );

      case SectionType.experience:
        if (data.experiences.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...data.experiences.map((exp) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                              style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                            ),
                          ),
                          pw.Text(
                            '${exp.startDate} - ${exp.current ? _pres(lang) : exp.endDate}',
                            style: style(size: 8, color: pGray500),
                          ),
                        ],
                      ),
                      pw.Text(
                        [
                          getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                          if (exp.location.isNotEmpty)
                            getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                        ].join(' | '),
                        style: pw.TextStyle(font: italicFont, fontSize: 9, color: pEmerald700),
                      ),
                      if (exp.description.isNotEmpty)
                        pw.Text(
                          getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                          style: style(size: 8, color: pGray600, lineSpacing: 2),
                        ),
                    ],
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
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                              style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                            ),
                          ),
                          pw.Text(
                            '${edu.startDate} - ${edu.endDate}',
                            style: style(size: 8, color: pGray500),
                          ),
                        ],
                      ),
                      pw.Text(
                        getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                        style: pw.TextStyle(font: italicFont, fontSize: 9, color: pEmerald700),
                      ),
                      if (edu.description.isNotEmpty)
                        pw.Text(
                          getTranslated(tr, 'edu.${edu.id}.description', lang, edu.description),
                          style: style(size: 8, color: pGray600),
                        ),
                    ],
                  ),
                )),
          ],
        );

      case SectionType.skills:
        if (data.skills.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            pw.Wrap(
              spacing: 6,
              runSpacing: 4,
              children: data.skills.map((skill) {
                return pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: pw.BoxDecoration(
                    color: pEmerald50,
                    border: pw.Border.all(color: pEmerald200),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
                  ),
                  child: pw.RichText(
                    text: pw.TextSpan(children: [
                      pw.TextSpan(
                        text: getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                        style: pw.TextStyle(font: regularFont, fontSize: 8, color: pEmerald800),
                      ),
                      pw.TextSpan(
                        text: ' ${'●' * skill.level}${'○' * (5 - skill.level)}',
                        style: pw.TextStyle(font: regularFont, fontSize: 7, color: pEmerald700),
                      ),
                    ]),
                  ),
                );
              }).toList(),
            ),
          ],
        );

      case SectionType.languages:
        if (data.languages.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            pw.Wrap(
              spacing: 12,
              runSpacing: 4,
              children: data.languages.map((l) {
                return pw.RichText(
                  text: pw.TextSpan(children: [
                    pw.TextSpan(
                      text: l.language,
                      style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray700),
                    ),
                    pw.TextSpan(
                      text: ' (${l.level})',
                      style: style(size: 8, color: pGray400),
                    ),
                  ]),
                );
              }).toList(),
            ),
          ],
        );

      case SectionType.projects:
        if (data.projects.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...data.projects.map((p) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                        style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900),
                      ),
                      if (p.description.isNotEmpty)
                        pw.Text(
                          getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                          style: style(size: 8, color: pGray600),
                        ),
                    ],
                  ),
                )),
          ],
        );

      case SectionType.certifications:
        if (data.certifications.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...data.certifications.map((c) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 3),
                  child: pw.RichText(
                    text: pw.TextSpan(children: [
                      pw.TextSpan(
                        text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                        style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray700),
                      ),
                      pw.TextSpan(
                        text: ' - ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                        style: style(size: 8, color: pGray500),
                      ),
                    ]),
                  ),
                )),
          ],
        );

      case SectionType.volunteer:
        if (data.volunteer.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            ...data.volunteer.map((v) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                        style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                      ),
                      pw.Text(
                        getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                        style: pw.TextStyle(font: italicFont, fontSize: 9, color: pEmerald700),
                      ),
                    ],
                  ),
                )),
          ],
        );

      case SectionType.interests:
        if (data.interests.isEmpty) continue;
        content = pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            sectionTitle(lbl),
            pw.Text(getTranslated(tr, 'interests', lang, data.interests), style: style()),
          ],
        );

      default:
        continue;
    }

    widgets.add(content);
  }

  return widgets;
}
