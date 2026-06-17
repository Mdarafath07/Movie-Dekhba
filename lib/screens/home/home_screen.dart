import 'dart:ui';
import '../../core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/movie_providers.dart';
import '../../providers/tv_providers.dart';
import '../../providers/person_providers.dart';
import '../../api/endpoints.dart';
import 'components/trending_carousel.dart';
import 'components/movie_list_row.dart';
import 'components/tv_list_row.dart';
import '../../providers/history_providers.dart';
import '../../providers/app_config_provider.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/update_service.dart';
import '../../core/theme/app_icons.dart';
import '../../widgets/update_dialog.dart';
import '../../widgets/welcome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _checkWelcomeDialog();
      _checkAppUpdate();
    }
  }

  Future<void> _checkWelcomeDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownWelcome = prefs.getBool('has_shown_welcome') ?? false;

    if (!hasShownWelcome && mounted) {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, anim1, anim2) => const WelcomeDialog(),
        transitionBuilder: (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
              ),
              child: child,
            ),
          );
        },
      );
      prefs.setBool('has_shown_welcome', true);
    }
  }

  Future<void> _checkAppUpdate() async {
    final updateService = UpdateService();
    final updateInfo = await updateService.checkUpdate();
    
    if (updateInfo != null && updateInfo.latestVersion != UpdateService.currentVersion && mounted) {
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
    final animeMoviesAsync = ref.watch(animeMoviesProvider);
    final recentPlays = ref.watch(recentPlaysProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);
    final hPad = Responsive.horizontalPad(context);
    final isWeb = Responsive.isWeb(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:
          isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _HomeAppBar(isDark: isDark, isWeb: isWeb, hPad: hPad),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Hero Carousel ─────────────────────────────
                    trendingAsync.when(
                      data: (movies) => TrendingCarousel(movies: movies),
                      loading: () => SizedBox(
                        height: Responsive.carouselHeight(context),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: const Color(0xFFE50914),
                            strokeWidth: 2.5,
                            backgroundColor: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      error: (e, _) => SizedBox(
                        height: Responsive.carouselHeight(context),
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

                    const SizedBox(height: 16),
                    
                    // ── Genre Selector ───────────────────────────
                    _GenreSelector(isDark: isDark, hPad: hPad),

                    const SizedBox(height: 8),

                    // ── Continue Watching ──────────────────────────
                    if (recentPlays.isNotEmpty) ...[
                      _SectionHeader(
                        title: 'Continue Watching',
                        subtitle: 'Pick up where you left off',
                        icon: Icon(Icons.play_circle_outline_rounded, color: const Color(0xFF3B82F6), size: 17),
                        iconColor: const Color(0xFF3B82F6),
                        isDark: isDark,
                        hPad: hPad,
                        onTap: () => context.push('/explore', extra: {'title': 'Continue Watching', 'type': 'history'}),
                      ),
                      SizedBox(
                        height: 168,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: hPad),
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

                    // ── Anime Section ─────────────────────────────
                    _SectionHeader(
                      title: 'Anime Universe',
                      subtitle: 'Top animation & anime',
                      icon: AppIcons.assetIcon('anime', size: 17, color: const Color(0xFFFF2E63)),
                      iconColor: const Color(0xFFFF2E63),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {
                        'title': 'Anime Universe',
                        'type': 'movie',
                        'category': 'discover',
                        'genreId': '16'
                      }),
                    ),
                    MovieListRow(title: '', asyncValue: animeMoviesAsync),

                    // ── Popular Movies ─────────────────────────────
                    _SectionHeader(
                      title: 'Popular Movies',
                      subtitle: 'Top hits this week',
                      icon: AppIcons.assetIcon('populer', size: 17, color: const Color(0xFFE50914)),
                      iconColor: const Color(0xFFE50914),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {'title': 'Popular Movies', 'type': 'movie', 'category': 'popular'}),
                    ),
                    MovieListRow(title: '', asyncValue: popularMoviesAsync),

                    // ── Trending TV ────────────────────────────────
                    _SectionHeader(
                      title: 'Trending TV',
                      subtitle: 'Most watched shows',
                      icon: AppIcons.assetIcon('tv', size: 17, color: const Color(0xFFF59E0B)),
                      iconColor: const Color(0xFFF59E0B),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {'title': 'Trending TV', 'type': 'tv', 'category': 'trending'}),
                    ),
                    TvListRow(title: '', asyncValue: trendingTvAsync),

                    // ── Popular TV Shows ───────────────────────────
                    _SectionHeader(
                      title: 'Popular TV Shows',
                      subtitle: 'Fan favorites',
                      icon: AppIcons.assetIcon('tv', size: 17, color: const Color(0xFF8B5CF6)),
                      iconColor: const Color(0xFF8B5CF6),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {'title': 'Popular TV Shows', 'type': 'tv', 'category': 'popular'}),
                    ),
                    TvListRow(title: '', asyncValue: popularTvAsync),

                    // ── Top Rated Movies ───────────────────────────
                    _SectionHeader(
                      title: 'Top Rated Movies',
                      subtitle: 'Critically acclaimed',
                      icon: AppIcons.assetIcon('topRated', size: 17, color: const Color(0xFFF5A623)),
                      iconColor: const Color(0xFFF5A623),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {'title': 'Top Rated Movies', 'type': 'movie', 'category': 'top_rated'}),
                    ),
                    MovieListRow(title: '', asyncValue: topRatedAsync),

                    // ── Top Rated TV ───────────────────────────────
                    _SectionHeader(
                      title: 'Top Rated TV',
                      subtitle: 'Best of television',
                      icon: AppIcons.assetIcon('topRated', size: 17, color: const Color(0xFFF5A623)),
                      iconColor: const Color(0xFFF5A623),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {'title': 'Top Rated TV', 'type': 'tv', 'category': 'top_rated'}),
                    ),
                    TvListRow(title: '', asyncValue: topRatedTvAsync),

                    // ── Upcoming Movies ────────────────────────────
                    _SectionHeader(
                      title: 'Upcoming Movies',
                      subtitle: 'Coming soon to theaters',
                      icon: AppIcons.assetIcon('upcoming', size: 17, color: const Color(0xFF06B6D4)),
                      iconColor: const Color(0xFF06B6D4),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {'title': 'Upcoming Movies', 'type': 'movie', 'category': 'upcoming'}),
                    ),
                    MovieListRow(title: '', asyncValue: upcomingAsync),

                    // ── Popular People ─────────────────────────────
                    _SectionHeader(
                      title: 'Popular People',
                      subtitle: 'Trending stars',
                      icon: AppIcons.assetIcon('populer', size: 17, color: const Color(0xFF10B981)),
                      iconColor: const Color(0xFF10B981),
                      isDark: isDark,
                      hPad: hPad,
                      onTap: () => context.push('/explore', extra: {'title': 'Popular People', 'type': 'people', 'category': 'popular'}),
                    ),
                    popularPeopleAsync.when(
                      data: (people) => SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: hPad),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── App Bar ──────────────────────────────────────────────
class _HomeAppBar extends ConsumerWidget {
  final bool isDark;
  final bool isWeb;
  final double hPad;
  const _HomeAppBar({required this.isDark, required this.isWeb, required this.hPad});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
            child: Row(
              children: [
                // Logo — hidden on web (sidebar has it)
                if (!isWeb) ...[
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'মুভি দেখবা',
                                overflow: TextOverflow.ellipsis,
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
                        ),
                      ],
                    ),
                  ),
                ],
                if (isWeb)
                  Text(
                    'Discover',
                    style: GoogleFonts.poppins(
                      color: isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                const Spacer(),
                // App Download Button for Mobile Web Layout
                if (kIsWeb && !isWeb) ...[
                  Consumer(
                    builder: (context, ref, child) {
                      final webConfigAsync = ref.watch(webConfigProvider);
                      final apkUrl = webConfigAsync.valueOrNull?.apkUrl ?? '';
                      if (apkUrl.isEmpty) return const SizedBox.shrink();

                      return Tooltip(
                        message: 'Download App',
                        child: GestureDetector(
                          onTap: () async {
                            final uri = Uri.tryParse(apkUrl);
                            if (uri != null && await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE50914).withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE50914).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.download_for_offline_rounded,
                              color: Color(0xFFE50914),
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                ],
                // Notification icon
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

// ── Section Header ──────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Color iconColor;
  final bool isDark;
  final VoidCallback? onTap;
  final double hPad;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isDark,
    required this.hPad,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 22, hPad, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(width: 17, height: 17, child: icon),
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
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                children: [
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
            ),
          ),
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

// ── Genre Selector ────────────────────────────────────────
class _GenreSelector extends StatelessWidget {
  final bool isDark;
  final double hPad;
  const _GenreSelector({required this.isDark, required this.hPad});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Row(
        children: [
          _GenreItem(
            title: 'Kids',
            icon: AppIcons.assetIcon('kids', size: 18, color: const Color(0xFFF9A825)),
            color: const Color(0xFFF9A825),
            isDark: isDark,
            genreId: '10751',
          ),
          _GenreItem(
            title: 'Cartoon',
            icon: AppIcons.assetIcon('cartoon', size: 18, color: const Color(0xFF4CAF50)),
            color: const Color(0xFF4CAF50),
            isDark: isDark,
            genreId: '16',
          ),
          _GenreItem(
            title: 'Horror',
            icon: AppIcons.assetIcon('horror', size: 18, color: const Color(0xFF9C27B0)),
            color: const Color(0xFF9C27B0),
            isDark: isDark,
            genreId: '27',
          ),
          _GenreItem(
            title: 'Adventure',
            icon: AppIcons.assetIcon('adventure', size: 18, color: const Color(0xFF03A9F4)),
            color: const Color(0xFF03A9F4),
            isDark: isDark,
            genreId: '12',
          ),
          _GenreItem(
            title: 'Action',
            icon: AppIcons.assetIcon('actions', size: 18, color: const Color(0xFFFF5722)),
            color: const Color(0xFFFF5722),
            isDark: isDark,
            genreId: '28',
          ),
          _GenreItem(
            title: 'Sci-Fi',
            icon: AppIcons.assetIcon('scifi', size: 18, color: const Color(0xFF673AB7)),
            color: const Color(0xFF673AB7),
            isDark: isDark,
            genreId: '878',
          ),
          _GenreItem(
            title: 'Comedy',
            icon: AppIcons.assetIcon('comedy', size: 18, color: const Color(0xFFFF4081)),
            color: const Color(0xFFFF4081),
            isDark: isDark,
            genreId: '35',
          ),
          _GenreItem(
            title: 'Romantic',
            icon: Icon(Icons.favorite_rounded, color: const Color(0xFFF06292), size: 18),
            color: const Color(0xFFF06292),
            isDark: isDark,
            genreId: '10749',
          ),
          _GenreItem(
            title: 'Sex',
            icon: AppIcons.assetIcon('sex', size: 18, color: const Color(0xFFD32F2F)),
            color: const Color(0xFFD32F2F),
            isDark: isDark,
            genreId: '0',
            onCustomTap: () => _showRandomImagePopup(context),
          ),
        ],
      ),
    );
  }

  void _showRandomImagePopup(BuildContext context) {
    final images = ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg', 'e.jpg', 'f.jpg'];
    final randomImage = images[DateTime.now().millisecond % images.length];
    
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'lib/assets/$randomImage',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.2),
                      child: const Icon(Icons.image_not_supported, color: Colors.white, size: 50),
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

class _GenreItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color color;
  final bool isDark;
  final String genreId;
  final VoidCallback? onCustomTap;

  const _GenreItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.isDark,
    required this.genreId,
    this.onCustomTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCustomTap ?? () => context.push('/explore', extra: {
        'title': '$title Movies',
        'type': 'movie',
        'category': 'discover',
        'genreId': genreId,
        if (title == 'Kids') 'certification': 'PG',
      }),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 18, height: 18, child: icon),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

