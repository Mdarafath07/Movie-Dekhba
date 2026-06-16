import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'home_screen.dart';
import '../search/search_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/favorites_screen.dart';
import '../../providers/theme_provider.dart';
import '../../core/utils/responsive_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/app_config_provider.dart';

class MainWrapper extends ConsumerStatefulWidget {
  const MainWrapper({super.key});

  @override
  ConsumerState<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final List<AnimationController> _iconControllers;
  bool _isBannerClosed = false;
  final Set<int> _visitedIndices = {0}; // Lazy: only build screens once visited

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _iconControllers = List.generate(
      4,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
      ),
    );
    _iconControllers[0].forward();
  }

  @override
  void dispose() {
    for (final c in _iconControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onTabTap(int index) {
    if (_currentIndex == index) return;
    _iconControllers[_currentIndex].reverse();
    setState(() {
      _currentIndex = index;
      _visitedIndices.add(index); // Mark as visited so it gets built
    });
    _iconControllers[index].forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final isWeb = isDesktop || isTablet;

    if (isWeb) {
      return _WebLayout(
        currentIndex: _currentIndex,
        onTabTap: _onTabTap,
        screens: _screens,
        isDark: isDark,
        isDesktop: isDesktop,
        isBannerClosed: _isBannerClosed,
        visitedIndices: _visitedIndices,
        onCloseBanner: () {
          setState(() {
            _isBannerClosed = true;
          });
        },
      );
    }

    // ── Mobile: original bottom nav ──────────────────────────────
    final navBg = isDark ? const Color(0xFF161B22) : const Color(0xFFFFFFFF);
    final navBorder = isDark ? const Color(0xFF2A3142) : const Color(0xFFE2E8F0);

    Widget mobileScaffold = Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens.asMap().entries.map((e) {
          // Only build screen after first visit — avoids rendering all 4 at startup
          return _visitedIndices.contains(e.key) ? e.value : const SizedBox.shrink();
        }).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: navBg,
          border: Border(
            top: BorderSide(color: navBorder, width: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  isActive: _currentIndex == 0,
                  controller: _iconControllers[0],
                  isDark: isDark,
                  onTap: () => _onTabTap(0),
                ),
                _NavItem(
                  icon: Icons.search_outlined,
                  activeIcon: Icons.search_rounded,
                  label: 'Search',
                  isActive: _currentIndex == 1,
                  controller: _iconControllers[1],
                  isDark: isDark,
                  onTap: () => _onTabTap(1),
                ),
                _NavItem(
                  icon: Icons.favorite_border_rounded,
                  activeIcon: Icons.favorite_rounded,
                  label: 'Favorites',
                  isActive: _currentIndex == 2,
                  controller: _iconControllers[2],
                  isDark: isDark,
                  onTap: () => _onTabTap(2),
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'Profile',
                  isActive: _currentIndex == 3,
                  controller: _iconControllers[3],
                  isDark: isDark,
                  onTap: () => _onTabTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (kIsWeb) {
      final webConfigAsync = ref.watch(webConfigProvider);
      final apkUrl = webConfigAsync.valueOrNull?.apkUrl ?? '';
      final bannerEnabled = webConfigAsync.valueOrNull?.bannerEnabled ?? false;
      final showWebBanner = bannerEnabled && !_isBannerClosed && apkUrl.isNotEmpty;

      if (showWebBanner) {
        return Stack(
          children: [
            mobileScaffold,
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: _WebUpdateBanner(
                    isDark: isDark,
                    apkUrl: apkUrl,
                    onClose: () {
                      setState(() {
                        _isBannerClosed = true;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }

    return mobileScaffold;
  }
}

// ── Web / Tablet Sidebar Layout ─────────────────────────────────
class _WebLayout extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTap;
  final List<Widget> screens;
  final bool isDark;
  final bool isDesktop;
  final bool isBannerClosed;
  final Set<int> visitedIndices;
  final VoidCallback onCloseBanner;

  const _WebLayout({
    required this.currentIndex,
    required this.onTabTap,
    required this.screens,
    required this.isDark,
    required this.isDesktop,
    required this.isBannerClosed,
    required this.visitedIndices,
    required this.onCloseBanner,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final webConfigAsync = ref.watch(webConfigProvider);
    final webConfig = webConfigAsync.valueOrNull;
    final apkUrl = webConfig?.apkUrl ?? '';
    final bannerEnabled = webConfig?.bannerEnabled ?? false;
    final showWebBanner = bannerEnabled && !isBannerClosed && apkUrl.isNotEmpty;

    final sidebarBg = isDark ? const Color(0xFF0F1218) : const Color(0xFFFFFFFF);
    final borderColor = isDark ? const Color(0xFF1E2535) : const Color(0xFFE2E8F0);
    final activeColor = const Color(0xFFE50914);

    final navItems = [
      _SideNavItem(icon: Icons.home_rounded, outlinedIcon: Icons.home_outlined, label: 'Home'),
      _SideNavItem(icon: Icons.search_rounded, outlinedIcon: Icons.search_outlined, label: 'Search'),
      _SideNavItem(icon: Icons.favorite_rounded, outlinedIcon: Icons.favorite_border_rounded, label: 'Favorites'),
      _SideNavItem(icon: Icons.person_rounded, outlinedIcon: Icons.person_outline_rounded, label: 'Profile'),
    ];

    final sidebarWidth = isDesktop ? 220.0 : 68.0;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          Row(
            children: [
              // ── Sidebar ───────────────────────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                width: sidebarWidth,
                decoration: BoxDecoration(
                  color: sidebarBg,
                  border: Border(
                    right: BorderSide(color: borderColor, width: 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                      blurRadius: 12,
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand header
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          isDesktop ? 20 : 12, 20, 12, 8),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFE50914), Color(0xFFB20710)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE50914).withOpacity(0.35),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Image.asset(
                                    'lib/assets/applogo.png',
                                    color: Colors.white,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            if (isDesktop) ...[
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'মুভি দেখবা',
                                    style: GoogleFonts.notoSansBengali(
                                      color: isDark
                                          ? const Color(0xFFF0F2F5)
                                          : const Color(0xFF0D1117),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    'MOVIE DEKHBA',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFE50914),
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.8,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Nav Items ─────────────────────────────────
                      ...navItems.asMap().entries.map((entry) {
                        final i = entry.key;
                        final item = entry.value;
                        final isActive = currentIndex == i;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 12 : 8,
                            vertical: 3,
                          ),
                          child: InkWell(
                            onTap: () => onTabTap(i),
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: isDesktop ? 14 : 10,
                                vertical: 11,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? activeColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: isDesktop
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isActive ? item.icon : item.outlinedIcon,
                                    color: isActive
                                        ? activeColor
                                        : (isDark
                                            ? const Color(0xFF8B95A8)
                                            : const Color(0xFF4A5568)),
                                    size: 22,
                                  ),
                                  if (isDesktop) ...[
                                    const SizedBox(width: 14),
                                    Text(
                                      item.label,
                                      style: GoogleFonts.poppins(
                                        color: isActive
                                            ? activeColor
                                            : (isDark
                                                ? const Color(0xFF8B95A8)
                                                : const Color(0xFF4A5568)),
                                        fontSize: 14,
                                        fontWeight: isActive
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                      const Spacer(),
                      const SizedBox(height: 120), // Placeholder space to let controls float cleanly
                    ],
                  ),
                ),
              ),

              // ── Main content ─────────────────────────────────────
              Expanded(
                child: IndexedStack(
                  index: currentIndex,
                  children: screens.asMap().entries.map((e) {
                    // Lazy: only build screens once visited
                    return visitedIndices.contains(e.key) ? e.value : const SizedBox.shrink();
                  }).toList(),
                ),
              ),
            ],
          ),
          // ── Bottom sticky download banner (Web Only) ────────
          if (showWebBanner)
            Positioned(
              bottom: 20,
              left: sidebarWidth + 24,
              right: 24,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: _WebUpdateBanner(
                    isDark: isDark,
                    apkUrl: apkUrl,
                    onClose: onCloseBanner,
                  ),
                ),
              ),
            ),
          // ── Bottom-Left Floating Controls (Web Only) ────────
          Positioned(
            bottom: 24,
            left: isDesktop ? 24 : (68 - 42) / 2,
            child: _buildFloatingControls(context, ref, isDark, themeMode),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingControls(
      BuildContext context, WidgetRef ref, bool isDark, ThemeMode themeMode) {
    final controlBg = isDark ? const Color(0xFF1C2230) : const Color(0xFFFFFFFF);
    final shadowColor = Colors.black.withOpacity(0.12);

    final downloadBtn = Consumer(
      builder: (context, ref, child) {
        final webConfigAsync = ref.watch(webConfigProvider);
        final apkUrl = webConfigAsync.valueOrNull?.apkUrl ?? '';
        if (apkUrl.isEmpty) return const SizedBox.shrink();

        return Tooltip(
          message: 'Download Mobile App',
          child: InkWell(
            onTap: () async {
              final uri = Uri.tryParse(apkUrl);
              if (uri != null && await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            borderRadius: BorderRadius.circular(21),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFE50914),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 8, offset: const Offset(0, 3)),
                ],
              ),
              child: const Icon(Icons.download_for_offline_rounded, color: Colors.white, size: 20),
            ),
          ),
        );
      },
    );

    final themeBtn = Tooltip(
      message: themeMode == ThemeMode.dark ? 'Light Mode' : 'Dark Mode',
      child: InkWell(
        onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
        borderRadius: BorderRadius.circular(21),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: controlBg,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: shadowColor, blurRadius: 8, offset: const Offset(0, 3)),
            ],
            border: Border.all(
              color: isDark ? const Color(0xFF2A3142) : const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Icon(
            themeMode == ThemeMode.dark
                ? Icons.dark_mode_rounded
                : Icons.light_mode_rounded,
            color: const Color(0xFFF5A623),
            size: 20,
          ),
        ),
      ),
    );

    if (isDesktop) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          downloadBtn,
          const SizedBox(width: 12),
          themeBtn,
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          downloadBtn,
          const SizedBox(height: 12),
          themeBtn,
        ],
      );
    }
  }

}

class _WebUpdateBanner extends StatelessWidget {
  final bool isDark;
  final String apkUrl;
  final VoidCallback onClose;

  const _WebUpdateBanner({
    required this.isDark,
    required this.apkUrl,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final bannerBg = isDark ? const Color(0xFF161B22).withOpacity(0.95) : Colors.white.withOpacity(0.95);
    final textPrimary = isDark ? Colors.white : Colors.black;
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);
    
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: bannerBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE50914).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE50914), Color(0xFFB20710)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE50914).withOpacity(0.35),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  'lib/assets/applogo.png',
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Download mobile app',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Get the best experience on your phone.',
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    color: textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE50914),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              minimumSize: const Size(0, 32),
              textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 11),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: () => _launchURL(apkUrl),
            child: const Text('Download'),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.close_rounded, size: 18, color: isDark ? Colors.white60 : Colors.black54),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> _launchURL(String urlString) async {
    final uri = Uri.tryParse(urlString);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SideNavItem {
  final IconData icon;
  final IconData outlinedIcon;
  final String label;
  const _SideNavItem({
    required this.icon,
    required this.outlinedIcon,
    required this.label,
  });
}

// ── Mobile Nav Item ─────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final AnimationController controller;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.controller,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFFE50914);
    final inactiveColor =
        isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final t = controller.value;
          return SizedBox(
            width: 72,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pill indicator + icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: 36,
                  width: isActive ? 56 : 36,
                  decoration: BoxDecoration(
                    color: isActive
                        ? activeColor.withOpacity(0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Transform.scale(
                      scale: isActive ? (0.9 + 0.1 * t) : 1.0,
                      child: Icon(
                        isActive ? activeIcon : icon,
                        color: isActive ? activeColor : inactiveColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: GoogleFonts.poppins(
                    color: isActive ? activeColor : inactiveColor,
                    fontSize: 10,
                    fontWeight:
                        isActive ? FontWeight.w700 : FontWeight.w400,
                  ),
                  child: Text(label),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
