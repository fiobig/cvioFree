import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cv_data.dart';
import '../state/cv_provider.dart';
import '../i18n/app_localizations.dart';
import 'form_screen.dart';
import 'preview_screen.dart';
import 'settings_screen.dart';

/// Height of the floating tab bar + its bottom margin, so child screens
/// can add matching padding and never get clipped.
const kFloatingTabBarHeight = 96.0;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _tab = 0;

  static const _tabs = [
    PreviewScreen(),
    FormScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(appLocalizationsProvider);
    final cv = ref.watch(cvProvider);
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/icons/icon_cvio.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              l.t('appTitle'),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: primary,
              ),
            ),
          ],
        ),
        actions: [
          // Language chip
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: PopupMenuButton<Language>(
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onSelected: ref.read(cvProvider.notifier).setLanguage,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primary.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.translate, size: 16, color: primary),
                    const SizedBox(width: 5),
                    Text(
                      cv.currentLanguage.flag,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              itemBuilder: (_) => Language.values.map((lang) {
                final selected = cv.currentLanguage == lang;
                return PopupMenuItem(
                  value: lang,
                  child: Row(
                    children: [
                      Text(lang.flag, style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          lang.label,
                          style: TextStyle(
                            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                            color: selected ? primary : null,
                          ),
                        ),
                      ),
                      if (selected) Icon(Icons.check_circle, size: 18, color: primary),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      extendBody: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: _tabs[_tab],
      ),
      bottomNavigationBar: _LiquidGlassTabBar(
        selectedIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: [
          _TabItem(icon: Icons.preview_outlined, selectedIcon: Icons.preview, label: l.t('preview')),
          _TabItem(icon: Icons.edit_outlined, selectedIcon: Icons.edit, label: l.t('edit')),
        ],
      ),
    );
  }
}

// ─── Liquid Glass Tab Bar ────────────────────────────────────────────────────

class _TabItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _TabItem({required this.icon, required this.selectedIcon, required this.label});
}

class _LiquidGlassTabBar extends StatelessWidget {
  const _LiquidGlassTabBar({
    required this.selectedIndex,
    required this.onTap,
    required this.items,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<_TabItem> items;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final primary = Theme.of(context).colorScheme.primary;
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    // Liquid glass colors
    final glassColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.55);
    final glassBorder = isDark
        ? Colors.white.withValues(alpha: 0.15)
        : Colors.white.withValues(alpha: 0.8);
    final glassInnerBorder = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.white.withValues(alpha: 0.4);
    final shadowColor = Colors.black.withValues(alpha: isDark ? 0.4 : 0.08);
    final pillColor = primary.withValues(alpha: isDark ? 0.25 : 0.12);

    return Padding(
      padding: EdgeInsets.fromLTRB(48, 0, 48, 10 + bottomPadding),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          boxShadow: [
            // Outer soft shadow
            BoxShadow(
              color: shadowColor,
              blurRadius: 24,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
            // Subtle inner glow at top
            BoxShadow(
              color: Colors.white.withValues(alpha: isDark ? 0.03 : 0.5),
              blurRadius: 0,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              decoration: BoxDecoration(
                // Gradient for liquid glass depth
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    glassColor,
                    glassColor.withValues(alpha: (glassColor.a * 0.7)),
                  ],
                ),
                borderRadius: BorderRadius.circular(29),
                border: Border.all(color: glassBorder, width: 0.5),
              ),
              // Inner highlight border
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border(
                    top: BorderSide(color: glassInnerBorder, width: 0.5),
                  ),
                ),
                child: Row(
                  children: List.generate(items.length, (i) {
                    final selected = i == selectedIndex;
                    final item = items[i];
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTap(i),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            padding: EdgeInsets.symmetric(
                              horizontal: selected ? 16 : 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected ? pillColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(18),
                              border: selected
                                  ? Border.all(
                                      color: primary.withValues(alpha: 0.15),
                                      width: 0.5,
                                    )
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    selected ? item.selectedIcon : item.icon,
                                    key: ValueKey(selected),
                                    size: 21,
                                    color: selected
                                        ? primary
                                        : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                                  ),
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutCubic,
                                  child: selected
                                      ? Padding(
                                          padding: const EdgeInsets.only(left: 6),
                                          child: Text(
                                            item.label,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: primary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
