import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../i18n/app_localizations.dart';
import '../widgets/template_selector.dart';
import 'home_screen.dart' show kFloatingTabBarHeight;
import '../widgets/form_steps/personal_info_step.dart';
import '../widgets/form_steps/profile_step.dart';
import '../widgets/form_steps/experience_step.dart';
import '../widgets/form_steps/education_step.dart';
import '../widgets/form_steps/skills_step.dart';
import '../widgets/form_steps/languages_step.dart';
import '../widgets/form_steps/projects_step.dart';
import '../widgets/form_steps/certifications_step.dart';
import '../widgets/form_steps/volunteer_step.dart';
import '../widgets/form_steps/interests_step.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Build the ordered list of steps based on visible sections + template step at index 0
  List<_Step> _buildSteps(CVData cv, AppLocalizations l) {
    final steps = <_Step>[
      _Step(label: l.t('templateSelect'), body: const TemplateSelector()),
    ];

    final visible = cv.sections.where((s) => s.enabled && (!s.isModern || cv.modernMode)).toList();

    for (final section in visible) {
      steps.add(_Step(
        label: l.t(section.id.name),
        body: _stepWidget(section.id),
      ));
    }
    return steps;
  }

  Widget _stepWidget(SectionType id) {
    switch (id) {
      case SectionType.personalInfo:
        return const PersonalInfoStep();
      case SectionType.profile:
        return const ProfileStep();
      case SectionType.experience:
        return const ExperienceStep();
      case SectionType.education:
        return const EducationStep();
      case SectionType.skills:
        return const SkillsStep();
      case SectionType.languages:
        return const LanguagesStep();
      case SectionType.projects:
        return const ProjectsStep();
      case SectionType.certifications:
        return const CertificationsStep();
      case SectionType.volunteer:
        return const VolunteerStep();
      case SectionType.interests:
        return const InterestsStep();
    }
  }

  void _goTo(int page, int total) {
    if (page < 0 || page >= total) return;
    setState(() => _currentPage = page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cv = ref.watch(cvProvider);
    final l = ref.watch(appLocalizationsProvider);
    final steps = _buildSteps(cv, l);
    final total = steps.length;

    return Column(
      children: [
        // Step indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${l.t('step')} ${_currentPage + 1} / $total',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    steps[_currentPage].label,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 60), // balance
                ],
              ),
              const SizedBox(height: 8),
              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(total, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: i == _currentPage ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _currentPage
                          ? Theme.of(context).colorScheme.primary
                          : i < _currentPage
                              ? Theme.of(context).colorScheme.primary.withAlpha(100)
                              : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        // Page content
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            children: steps.map((s) => s.body).toList(),
          ),
        ),
        // Navigation buttons
        Container(
          padding: EdgeInsets.fromLTRB(
            16, 10, 16,
            10 + MediaQuery.of(context).viewPadding.bottom + kFloatingTabBarHeight,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              if (_currentPage > 0)
                OutlinedButton.icon(
                  onPressed: () => _goTo(_currentPage - 1, total),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: Text(l.t('prev')),
                ),
              const Spacer(),
              if (_currentPage < total - 1)
                FilledButton.icon(
                  onPressed: () => _goTo(_currentPage + 1, total),
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: Text(l.t('next')),
                  iconAlignment: IconAlignment.end,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Step {
  const _Step({required this.label, required this.body});
  final String label;
  final Widget body;
}
