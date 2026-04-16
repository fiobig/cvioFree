import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/cv_data.dart';

// ─── Labels ──────────────────────────────────────────────────────────────────

const _labels = {
  'profile': {Language.it: 'Su di me', Language.en: 'About Me', Language.es: 'Sobre Mí'},
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

const _sidebarBg = Color(0xFF1E1B4B);      // indigo-950
const _sidebarAccent = Color(0xFF818CF8);  // indigo-400
const _sidebarText = Color(0xFFE0E7FF);    // indigo-100
const _mainBg = Colors.white;
const _accent = Color(0xFF4F46E5);         // indigo-600
const _gray900 = Color(0xFF111827);
const _gray700 = Color(0xFF374151);
const _gray500 = Color(0xFF6B7280);

// ─── Flutter Widget ───────────────────────────────────────────────────────────

class SidebarTemplate extends StatelessWidget {
  const SidebarTemplate({super.key, required this.data, required this.lang});
  final CVData data;
  final Language lang;

  @override
  Widget build(BuildContext context) {
    final pi = data.personalInfo;
    final tr = data.translations;
    final visible = data.sections
        .where((s) => s.enabled && (!s.isModern || data.modernMode))
        .toList();

    const sidebarSectionIds = {SectionType.skills, SectionType.languages, SectionType.interests};
    final mainSections = visible
        .where((s) => s.id != SectionType.personalInfo && !sidebarSectionIds.contains(s.id))
        .toList();
    final sidebarSections = visible.where((s) => sidebarSectionIds.contains(s.id)).toList();

    return Container(
      color: _mainBg,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Sidebar ───────────────────────────────────────────────────
            Container(
              width: 150,
              color: _sidebarBg,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Photo
                  if (pi.photoBytes != null) ...[
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _sidebarAccent, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.memory(pi.photoBytes!, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ] else ...[
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _sidebarAccent.withAlpha(60),
                      ),
                      child: const Icon(Icons.person, color: _sidebarAccent, size: 32),
                    ),
                    const SizedBox(height: 10),
                  ],
                  // Name
                  Text(
                    pi.firstName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: _sidebarText,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    pi.lastName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Contact info
                  if (pi.email.isNotEmpty) _contactItem(Icons.email_outlined, pi.email),
                  if (pi.phone.isNotEmpty) _contactItem(Icons.phone_outlined, pi.phone),
                  if (pi.address.isNotEmpty) _contactItem(Icons.location_on_outlined, pi.address),
                  if (pi.linkedin.isNotEmpty) _contactItem(Icons.link_outlined, pi.linkedin),
                  if (pi.website.isNotEmpty) _contactItem(Icons.language_outlined, pi.website),
                  if (pi.birthDate.isNotEmpty) _contactItem(Icons.cake_outlined, pi.birthDate),
                  if (pi.nationality.isNotEmpty) _contactItem(Icons.flag_outlined, pi.nationality),
                  const SizedBox(height: 10),
                  // Sidebar sections
                  ...sidebarSections
                      .map((s) => _buildSidebarSection(s.id, data, tr, lang))
                      .whereType<Widget>(),
                ],
              ),
            ),
            // ── Main content ──────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: mainSections
                      .map((s) => _buildMainSection(s.id, data, tr, lang))
                      .whereType<Widget>()
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactItem(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Icon(icon, size: 10, color: _sidebarAccent),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 8, color: _sidebarText),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      );

  Widget? _buildSidebarSection(SectionType id, CVData d, Map<String, TranslatedField> tr, Language lang) {
    final lbl = _label(id.name, lang);

    Widget sideTitle() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 0.5, color: _sidebarAccent.withAlpha(80)),
            const SizedBox(height: 8),
            Text(
              lbl.toUpperCase(),
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: _sidebarAccent,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 6),
          ],
        );

    switch (id) {
      case SectionType.skills:
        if (d.skills.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sideTitle(),
              ...d.skills.map((skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                          style: const TextStyle(fontSize: 8, color: _sidebarText),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: List.generate(5, (i) => Expanded(
                            child: Container(
                              height: 3,
                              margin: const EdgeInsets.only(right: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: i < skill.level ? _sidebarAccent : _sidebarAccent.withAlpha(40),
                              ),
                            ),
                          )),
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
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sideTitle(),
              ...d.languages.map((l) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.language, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: _sidebarText)),
                        Text(l.level, style: const TextStyle(fontSize: 7, color: _sidebarAccent)),
                      ],
                    ),
                  )),
            ],
          ),
        );

      case SectionType.interests:
        if (d.interests.isEmpty) return null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sideTitle(),
              Text(
                getTranslated(tr, 'interests', lang, d.interests),
                style: const TextStyle(fontSize: 8, color: _sidebarText, height: 1.4),
              ),
            ],
          ),
        );

      default:
        return null;
    }
  }

  Widget? _buildMainSection(SectionType id, CVData d, Map<String, TranslatedField> tr, Language lang) {
    final lbl = _label(id.name, lang);

    Widget sectionTitle() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 3, height: 14, color: _accent, margin: const EdgeInsets.only(right: 8)),
                Text(
                  lbl.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: _accent,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
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
              sectionTitle(),
              Text(
                getTranslated(tr, 'profile', lang, d.profile),
                style: const TextStyle(fontSize: 10, color: _gray700, height: 1.5),
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
              sectionTitle(),
              ...d.experiences.map((exp) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${exp.startDate} – ${exp.current ? _pres(lang) : exp.endDate}',
                          style: const TextStyle(fontSize: 8, color: _gray500),
                        ),
                        Text(
                          getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                        ),
                        Text(
                          [
                            getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                            if (exp.location.isNotEmpty) getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                          ].join(' · '),
                          style: const TextStyle(fontSize: 9, color: _accent),
                        ),
                        if (exp.description.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                            style: const TextStyle(fontSize: 9, color: _gray700, height: 1.4),
                          ),
                        ],
                      ],
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
              sectionTitle(),
              ...d.education.map((edu) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${edu.startDate} – ${edu.endDate}',
                            style: const TextStyle(fontSize: 8, color: _gray500)),
                        Text(
                          getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _gray900),
                        ),
                        Text(
                          getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                          style: const TextStyle(fontSize: 9, color: _accent),
                        ),
                      ],
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
              sectionTitle(),
              ...d.projects.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(tr, 'proj.${p.id}.name', lang, p.name),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _gray900),
                        ),
                        if (p.url.isNotEmpty)
                          Text(p.url, style: const TextStyle(fontSize: 8, color: _accent)),
                        if (p.description.isNotEmpty)
                          Text(
                            getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                            style: const TextStyle(fontSize: 9, color: _gray700),
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
              sectionTitle(),
              ...d.certifications.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _gray900),
                        ),
                        TextSpan(
                          text: '  ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                          style: const TextStyle(fontSize: 9, color: _gray500),
                        ),
                        if (c.date.isNotEmpty)
                          TextSpan(
                            text: ' (${c.date})',
                            style: const TextStyle(fontSize: 8, color: _gray500),
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
              sectionTitle(),
              ...d.volunteer.map((v) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${v.startDate} – ${v.endDate}',
                            style: const TextStyle(fontSize: 8, color: _gray500)),
                        Text(
                          getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _gray900),
                        ),
                        Text(
                          getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                          style: const TextStyle(fontSize: 9, color: _accent),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );

      default:
        return null;
    }
  }
}

// ─── PDF Builder ─────────────────────────────────────────────────────────────
// Note: sidebar content is rendered as a header block then main content
// to avoid pw.MultiPage column-split issues.

Future<List<pw.Widget>> buildSidebarPdfWidgets(
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

  const sidebarSectionIds = {SectionType.skills, SectionType.languages, SectionType.interests};
  final mainSections = visible
      .where((s) => s.id != SectionType.personalInfo && !sidebarSectionIds.contains(s.id))
      .toList();
  final sidebarSections = visible.where((s) => sidebarSectionIds.contains(s.id)).toList();

  final pSidebarBg = PdfColor.fromHex('#1E1B4B');
  final pSidebarAccent = PdfColor.fromHex('#818CF8');
  final pSidebarText = PdfColor.fromHex('#E0E7FF');
  final pAccent = PdfColor.fromHex('#4F46E5');
  final pGray900 = PdfColor.fromHex('#111827');
  final pGray700 = PdfColor.fromHex('#374151');
  final pGray500 = PdfColor.fromHex('#6B7280');

  pw.TextStyle mainStyle({pw.Font? font, double size = 10, PdfColor? color, double? lineSpacing}) =>
      pw.TextStyle(font: font ?? regularFont, fontSize: size, color: color ?? pGray700, lineSpacing: lineSpacing);

  pw.TextStyle sideStyle({pw.Font? font, double size = 9, PdfColor? color}) =>
      pw.TextStyle(font: font ?? regularFont, fontSize: size, color: color ?? pSidebarText);

  // ── Build sidebar content list ─────────────────────────────────────────────
  final sidebarWidgets = <pw.Widget>[];

  // Contact info
  final contactEntries = <MapEntry<String, String>>[
    if (pi.email.isNotEmpty) MapEntry('Email', pi.email),
    if (pi.phone.isNotEmpty) MapEntry('Tel', pi.phone),
    if (pi.address.isNotEmpty) MapEntry('', pi.address),
    if (pi.linkedin.isNotEmpty) MapEntry('LinkedIn', pi.linkedin),
    if (pi.website.isNotEmpty) MapEntry('Web', pi.website),
    if (pi.birthDate.isNotEmpty) MapEntry('', pi.birthDate),
    if (pi.nationality.isNotEmpty) MapEntry('', pi.nationality),
  ];

  for (final entry in contactEntries) {
    sidebarWidgets.add(
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
        child: pw.Text(
          entry.key.isNotEmpty ? '${entry.key}: ${entry.value}' : entry.value,
          style: sideStyle(size: 7),
        ),
      ),
    );
  }

  // Sidebar sections
  for (final section in sidebarSections) {
    final lbl = _label(section.id.name, lang);
    sidebarWidgets.add(pw.SizedBox(height: 8));
    sidebarWidgets.add(pw.Container(height: 0.5, color: pSidebarAccent));
    sidebarWidgets.add(pw.SizedBox(height: 5));
    sidebarWidgets.add(
      pw.Text(
        lbl.toUpperCase(),
        style: pw.TextStyle(font: boldFont, fontSize: 7, color: pSidebarAccent, letterSpacing: 0.8),
      ),
    );
    sidebarWidgets.add(pw.SizedBox(height: 4));

    switch (section.id) {
      case SectionType.skills:
        for (final skill in data.skills) {
          sidebarWidgets.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 5),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    getTranslated(tr, 'skill.${skill.id}.name', lang, skill.name),
                    style: sideStyle(size: 7),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Row(
                    children: List.generate(5, (i) => pw.Expanded(
                      child: pw.Container(
                        height: 2.5,
                        margin: const pw.EdgeInsets.only(right: 1.5),
                        decoration: pw.BoxDecoration(
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                          color: i < skill.level ? pSidebarAccent : PdfColor.fromHex('#312E81'),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          );
        }
      case SectionType.languages:
        for (final l in data.languages) {
          sidebarWidgets.add(
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(l.language, style: pw.TextStyle(font: boldFont, fontSize: 8, color: pSidebarText)),
                  pw.Text(l.level, style: sideStyle(size: 7, color: pSidebarAccent)),
                ],
              ),
            ),
          );
        }
      case SectionType.interests:
        if (data.interests.isNotEmpty) {
          sidebarWidgets.add(
            pw.Text(
              getTranslated(tr, 'interests', lang, data.interests),
              style: sideStyle(size: 7),
            ),
          );
        }
      default:
        break;
    }
  }

  // ── Build main content widgets ─────────────────────────────────────────────
  final mainWidgets = <pw.Widget>[];

  pw.Widget mainSectionTitle(String lbl) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(width: 3, height: 12, color: pAccent, margin: const pw.EdgeInsets.only(right: 6)),
              pw.Text(
                lbl.toUpperCase(),
                style: pw.TextStyle(font: boldFont, fontSize: 7, color: pAccent, letterSpacing: 0.8),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
        ],
      );

  for (final section in mainSections) {
    final lbl = _label(section.id.name, lang);
    pw.Widget? content;

    switch (section.id) {
      case SectionType.profile:
        if (data.profile.isEmpty) continue;
        content = pw.Text(
          getTranslated(tr, 'profile', lang, data.profile),
          style: mainStyle(lineSpacing: 3),
        );

      case SectionType.experience:
        if (data.experiences.isEmpty) continue;
        content = pw.Column(
          children: data.experiences.map((exp) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('${exp.startDate} – ${exp.current ? _pres(lang) : exp.endDate}',
                    style: mainStyle(size: 7, color: pGray500)),
                pw.Text(
                  getTranslated(tr, 'exp.${exp.id}.jobTitle', lang, exp.jobTitle),
                  style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                ),
                pw.Text(
                  [
                    getTranslated(tr, 'exp.${exp.id}.company', lang, exp.company),
                    if (exp.location.isNotEmpty) getTranslated(tr, 'exp.${exp.id}.location', lang, exp.location),
                  ].join(' · '),
                  style: mainStyle(size: 8, color: pAccent),
                ),
                if (exp.description.isNotEmpty)
                  pw.Text(
                    getTranslated(tr, 'exp.${exp.id}.description', lang, exp.description),
                    style: mainStyle(size: 8, lineSpacing: 2),
                  ),
              ],
            ),
          )).toList(),
        );

      case SectionType.education:
        if (data.education.isEmpty) continue;
        content = pw.Column(
          children: data.education.map((edu) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('${edu.startDate} – ${edu.endDate}', style: mainStyle(size: 7, color: pGray500)),
                pw.Text(
                  getTranslated(tr, 'edu.${edu.id}.degree', lang, edu.degree),
                  style: pw.TextStyle(font: boldFont, fontSize: 10, color: pGray900),
                ),
                pw.Text(
                  getTranslated(tr, 'edu.${edu.id}.institution', lang, edu.institution),
                  style: mainStyle(size: 8, color: pAccent),
                ),
              ],
            ),
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
                if (p.url.isNotEmpty) pw.Text(p.url, style: mainStyle(size: 7, color: pAccent)),
                if (p.description.isNotEmpty)
                  pw.Text(
                    getTranslated(tr, 'proj.${p.id}.description', lang, p.description),
                    style: mainStyle(size: 8),
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
            child: pw.RichText(
              text: pw.TextSpan(children: [
                pw.TextSpan(
                  text: getTranslated(tr, 'cert.${c.id}.name', lang, c.name),
                  style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900),
                ),
                pw.TextSpan(
                  text: '  ${getTranslated(tr, 'cert.${c.id}.issuer', lang, c.issuer)}',
                  style: mainStyle(size: 8, color: pGray500),
                ),
                if (c.date.isNotEmpty)
                  pw.TextSpan(text: ' (${c.date})', style: mainStyle(size: 7, color: pGray500)),
              ]),
            ),
          )).toList(),
        );

      case SectionType.volunteer:
        if (data.volunteer.isEmpty) continue;
        content = pw.Column(
          children: data.volunteer.map((v) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('${v.startDate} – ${v.endDate}', style: mainStyle(size: 7, color: pGray500)),
                pw.Text(
                  getTranslated(tr, 'vol.${v.id}.role', lang, v.role),
                  style: pw.TextStyle(font: boldFont, fontSize: 9, color: pGray900),
                ),
                pw.Text(
                  getTranslated(tr, 'vol.${v.id}.organization', lang, v.organization),
                  style: mainStyle(size: 8, color: pAccent),
                ),
              ],
            ),
          )).toList(),
        );

      default:
        continue;
    }

    mainWidgets.add(pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [mainSectionTitle(lbl), content],
      ),
    ));
  }

  // ── Compose: header row + main content ────────────────────────────────────
  final widgets = <pw.Widget>[];

  // Header: sidebar panel (left) + intro (right)
  widgets.add(
    pw.Container(
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Sidebar panel
          pw.Container(
            width: 150,
            color: pSidebarBg,
            padding: const pw.EdgeInsets.all(14),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (pi.photoBytes != null) ...[
                  pw.Center(
                    child: pw.Container(
                      width: 56,
                      height: 56,
                      decoration: pw.BoxDecoration(shape: pw.BoxShape.circle),
                      child: pw.ClipOval(
                        child: pw.Image(pw.MemoryImage(pi.photoBytes!), fit: pw.BoxFit.cover),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                ],
                pw.Center(
                  child: pw.Text(
                    pi.firstName,
                    style: pw.TextStyle(font: regularFont, fontSize: 13, color: pSidebarText, letterSpacing: 0.5),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    pi.lastName,
                    style: pw.TextStyle(font: boldFont, fontSize: 13, color: PdfColors.white, letterSpacing: 0.5),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.SizedBox(height: 10),
                ...sidebarWidgets,
              ],
            ),
          ),
          // Main content
          pw.Expanded(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: mainWidgets,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  return widgets;
}
