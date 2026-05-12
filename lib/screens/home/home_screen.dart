import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/movie_providers.dart';
import '../../providers/tv_providers.dart';
import '../../providers/person_providers.dart';
import '../../api/endpoints.dart';
import 'components/trending_carousel.dart';
import 'components/movie_list_row.dart';
import 'components/tv_list_row.dart';
import '../../providers/history_providers.dart';
import 'package:go_router/go_router.dart';

import '../home/components/trending_carousel.dart';
import '../../core/services/update_service.dart';
import '../../widgets/update_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppUpdate();
  }

  Future<void> _checkAppUpdate() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final updateService = UpdateService();
      final updateInfo = await updateService.checkUpdate();
      
      if (updateInfo != null && updateInfo.latestVersion != UpdateService.currentVersion) {
        if (mounted) {
          showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierLabel: '',
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, anim1, anim2) => UpdateDialog(
              latestVersion: updateInfo.latestVersion,
              updateLink: updateInfo.updateLink,
              newFeatures: updateInfo.newFeatures,
            ),
            transitionBuilder: (context, anim1, anim2, child) {
              return FadeTransition(
                opacity: anim1,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
                  ),
                  child: child,
                ),
              );
            },
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final trendingAsync = ref.watch(trendingMoviesProvider);
    final popularMoviesAsync = ref.watch(popularMoviesProvider);
    final popularTvAsync = ref.watch(popularTvProvider);
    final topRatedAsync = ref.watch(topRatedMoviesProvider);
    final upcomingAsync = ref.watch(upcomingMoviesProvider);
    final trendingTvAsync = ref.watch(trendingTvProvider);
    final topRatedTvAsync = ref.watch(topRatedTvProvider);
    final popularPeopleAsync = ref.watch(popularPeopleProvider);
    final recentPlays = ref.watch(recentPlaysProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:
          isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _HomeAppBar(isDark: isDark),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Carousel ─────────────────────────────
            trendingAsync.when(
              data: (movies) => TrendingCarousel(movies: movies),
              loading: () => SizedBox(
                height: 480,
                child: Center(
                  child: CircularProgressIndicator(
                    color: const Color(0xFFE50914),
                    strokeWidth: 2.5,
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              error: (e, _) => SizedBox(
                height: 480,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off_rounded,
                          color: Color(0xFFE50914), size: 48),
                      const SizedBox(height: 12),
                      Text('No internet connection',
                          style: GoogleFonts.poppins(
                              color: textSecondary,
                              fontWeight: FontWeight.w600)),
                      Text('Check your network settings',
                          style: GoogleFonts.poppins(
                              color: textSecondary.withOpacity(0.7),
                              fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ── Continue Watching ──────────────────────────
            if (recentPlays.isNotEmpty) ...[
              _SectionHeader(
                title: 'Continue Watching',
                subtitle: 'Pick up where you left off',
                icon: Icons.play_circle_outline_rounded,
                iconColor: const Color(0xFF3B82F6),
                isDark: isDark,
              ),
              SizedBox(
                height: 168,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: recentPlays.length,
                  itemBuilder: (context, index) {
                    final item = recentPlays[index];
                    return GestureDetector(
                      onTap: () =>
                          context.push('/${item.mediaType}/${item.id}'),
                      child: _RecentCard(
                        posterPath: item.posterPath ?? '',
                        title: item.title,
                        isDark: isDark,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),
            ],

            // ── Popular Movies ─────────────────────────────
            _SectionHeader(
              title: 'Popular Movies',
              subtitle: 'Top hits this week',
              icon: Icons.local_fire_department_rounded,
              iconColor: const Color(0xFFE50914),
              isDark: isDark,
            ),
            MovieListRow(title: '', asyncValue: popularMoviesAsync),

            // ── Trending TV ────────────────────────────────
            _SectionHeader(
              title: 'Trending TV',
              subtitle: 'Most watched shows',
              icon: Icons.trending_up_rounded,
              iconColor: const Color(0xFFF59E0B),
              isDark: isDark,
            ),
            TvListRow(title: '', asyncValue: trendingTvAsync),

            // ── Popular TV Shows ───────────────────────────
            _SectionHeader(
              title: 'Popular TV Shows',
              subtitle: 'Fan favorites',
              icon: Icons.tv_rounded,
              iconColor: const Color(0xFF8B5CF6),
              isDark: isDark,
            ),
            TvListRow(title: '', asyncValue: popularTvAsync),

            // ── Top Rated Movies ───────────────────────────
            _SectionHeader(
              title: 'Top Rated Movies',
              subtitle: 'Critically acclaimed',
              icon: Icons.military_tech_rounded,
              iconColor: const Color(0xFFF5A623),
              isDark: isDark,
            ),
            MovieListRow(title: '', asyncValue: topRatedAsync),

            // ── Top Rated TV ───────────────────────────────
            _SectionHeader(
              title: 'Top Rated TV',
              subtitle: 'Best of television',
              icon: Icons.star_rounded,
              iconColor: const Color(0xFFF5A623),
              isDark: isDark,
            ),
            TvListRow(title: '', asyncValue: topRatedTvAsync),

            // ── Upcoming Movies ────────────────────────────
            _SectionHeader(
              title: 'Upcoming Movies',
              subtitle: 'Coming soon to theaters',
              icon: Icons.calendar_today_rounded,
              iconColor: const Color(0xFF06B6D4),
              isDark: isDark,
            ),
            MovieListRow(title: '', asyncValue: upcomingAsync),

            // ── Popular People ─────────────────────────────
            _SectionHeader(
              title: 'Popular People',
              subtitle: 'Trending stars',
              icon: Icons.people_alt_rounded,
              iconColor: const Color(0xFF10B981),
              isDark: isDark,
            ),
            popularPeopleAsync.when(
              data: (people) => SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: people.length,
                  itemBuilder: (context, i) {
                    final p = people[i];
                    return Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 14),
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? const Color(0xFF1C2230)
                                  : const Color(0xFFE2E8F0),
                              border: Border.all(
                                color: const Color(0xFFE50914)
                                    .withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: p.profilePath != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          '${Endpoints.imageBaseUrl}${p.profilePath}',
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) => Container(
                                        color: isDark
                                            ? const Color(0xFF1C2230)
                                            : const Color(0xFFE2E8F0),
                                      ),
                                      errorWidget: (_, __, ___) => const Icon(
                                          Icons.person,
                                          color: Color(0xFF8B95A8),
                                          size: 32),
                                    )
                                  : const Icon(Icons.person,
                                      color: Color(0xFF8B95A8), size: 32),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            p.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: isDark
                                  ? const Color(0xFFF0F2F5)
                                  : const Color(0xFF0D1117),
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (p.knownForDepartment != null)
                            Text(
                              p.knownForDepartment!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF8B95A8),
                                fontSize: 9.5,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              loading: () => const SizedBox(
                height: 150,
                child: Center(
                  child: CircularProgressIndicator(
                      color: Color(0xFFE50914), strokeWidth: 2),
                ),
              ),
              error: (e, _) => const SizedBox.shrink(),
            ),

            const SizedBox(height: 48),

            // ── Footer ────────────────────────────────────

          ],
        ),
      ),
    );
  }
}

// ── App Bar ────────────────────────────────────────────────
class _HomeAppBar extends StatelessWidget {
  final bool isDark;
  const _HomeAppBar({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              (isDark ? const Color(0xFF0D0F14) : const Color(0xFFFFFFFF))
                  .withOpacity(0.95),
              (isDark ? const Color(0xFF0D0F14) : const Color(0xFFFFFFFF))
                  .withOpacity(0.0),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                // Logo
                Container(
                  width: 34,
                  height: 34,
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
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.movie_creation_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'MOVIE DEKHBA',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFE50914),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Notification icon only
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1C2230)
                          : const Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF2A3142)
                            : const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: isDark
                          ? const Color(0xFFF0F2F5)
                          : const Color(0xFF0D1117),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Section Header ─────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isDark;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 17),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: isDark
                      ? const Color(0xFFF0F2F5)
                      : const Color(0xFF0D1117),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF8B95A8),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'See all',
            style: GoogleFonts.poppins(
              color: const Color(0xFFE50914),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.chevron_right_rounded,
              color: Color(0xFFE50914), size: 16),
        ],
      ),
    );
  }
}

// ── Recent Watching Card ────────────────────────────────────
class _RecentCard extends StatelessWidget {
  final String posterPath;
  final String title;
  final bool isDark;

  const _RecentCard({
    required this.posterPath,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: '${Endpoints.imageBaseUrl}$posterPath',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1C2230)
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1C2230)
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.broken_image_outlined,
                          color: Color(0xFF4A5568)),
                    ),
                  ),
                ),
                // Play overlay
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE50914).withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? const Color(0xFFF0F2F5)
                  : const Color(0xFF0D1117),
            ),
          ),
        ],
      ),
    );
  }
}

