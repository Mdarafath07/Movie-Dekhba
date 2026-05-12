import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/endpoints.dart';
import '../../models/tv_detail_model.dart';
import '../../providers/tv_detail_providers.dart';
import '../../providers/tv_providers.dart' hide tvDetailsProvider;
import '../../providers/watch_provider_providers.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/watch_provider_section.dart';
import '../../core/utils/play_url_helper.dart';
import '../../providers/user_content_providers.dart';
import '../../repositories/firestore_repository.dart';
import '../../providers/auth_providers.dart';
import '../../providers/history_providers.dart';

class TvDetailScreen extends ConsumerWidget {
  final int tvId;
  const TvDetailScreen({super.key, required this.tvId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvAsync = ref.watch(tvDetailsProvider(tvId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return tvAsync.when(
      data: (tv) => _TvDetailContent(tv: tv),
      loading: () => Scaffold(
        backgroundColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
        body: const Center(child: CircularProgressIndicator(color: Color(0xFFE50914))),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 64, color: Color(0xFFE50914)),
              const SizedBox(height: 16),
              Text(
                'No internet connection',
                style: GoogleFonts.poppins(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please check your network settings',
                style: GoogleFonts.poppins(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TvDetailContent extends ConsumerStatefulWidget {
  final TvDetail tv;
  const _TvDetailContent({required this.tv});

  @override
  ConsumerState<_TvDetailContent> createState() => _TvDetailContentState();
}

class _TvDetailContentState extends ConsumerState<_TvDetailContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _expandedSeason;
  String? _cachedImdbId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchProvidersAsync = ref.watch(tvWatchProvidersProvider(widget.tv.id));
    final tv = widget.tv;
    final size = MediaQuery.of(context).size;
    final mainSeasons = tv.seasons.where((s) => s.seasonNumber > 0).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA);
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);
    final cardColor = isDark ? const Color(0xFF1C2230) : const Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- HERO HEADER ---
          SliverAppBar(
            expandedHeight: size.height * 0.52,
            pinned: true,
            backgroundColor: bgColor,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.4),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: '${Endpoints.imageBaseUrlOriginal}${tv.backdropPath ?? tv.posterPath}',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const ShimmerLoading(),
                    errorWidget: (_, __, ___) => Container(color: Colors.grey[900]),
                  ),
                  // Deep gradient overlay
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          bgColor.withOpacity(0.3),
                          bgColor.withOpacity(0.85),
                          bgColor,
                        ],
                        stops: const [0.0, 0.4, 0.75, 1.0],
                      ),
                    ),
                  ),
                  // Bottom info overlay
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tv.networks.isNotEmpty)
                          Text(
                            tv.networks.first.name.toUpperCase(),
                            style: GoogleFonts.poppins(color: const Color(0xFFE50914), fontWeight: FontWeight.w800, letterSpacing: 2, fontSize: 12),
                          ),
                        const SizedBox(height: 6),
                        Text(
                          tv.name,
                          style: GoogleFonts.poppins(color: textPrimary, fontSize: 28, fontWeight: FontWeight.w900, height: 1.1),
                        ),
                        if (tv.tagline != null && tv.tagline!.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(tv.tagline!, style: GoogleFonts.poppins(color: textSecondary, fontSize: 13, fontStyle: FontStyle.italic)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // Meta row
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 18),
                      const SizedBox(width: 4),
                      Text(
                        tv.voteAverage.toStringAsFixed(1),
                        style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(width: 12),
                      if (tv.firstAirDate != null && tv.firstAirDate!.length >= 4)
                        Text(tv.firstAirDate!.substring(0, 4), style: GoogleFonts.poppins(color: textSecondary, fontSize: 14)),
                      const SizedBox(width: 12),
                      if (tv.numberOfSeasons != null)
                        Text('${tv.numberOfSeasons} Season${tv.numberOfSeasons! > 1 ? 's' : ''}', style: GoogleFonts.poppins(color: textSecondary, fontSize: 14)),
                      const Spacer(),
                      if (tv.status != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: tv.status == 'Returning Series' ? Colors.green.withOpacity(0.1) : textSecondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: tv.status == 'Returning Series' ? Colors.green : textSecondary, width: 0.5),
                          ),
                          child: Text(
                            tv.status!,
                            style: GoogleFonts.poppins(color: tv.status == 'Returning Series' ? Colors.green : textSecondary, fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Genre chips
                  if (tv.genres.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tv.genres.map((g) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: textPrimary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: textPrimary.withOpacity(0.1), width: 0.5),
                        ),
                        child: Text(g.name, style: GoogleFonts.poppins(color: textSecondary, fontSize: 11.5, fontWeight: FontWeight.w500)),
                      )).toList(),
                    ),
                  const SizedBox(height: 12),
                  // Official Audio Row
                  if (tv.languages.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.language_rounded, color: textSecondary, size: 14),
                        const SizedBox(width: 8),
                        Text(
                          'Official Audio: ',
                          style: GoogleFonts.poppins(color: textSecondary, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: Text(
                            tv.languages.join(', ').toUpperCase(),
                            style: GoogleFonts.poppins(color: textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  Consumer(
                    builder: (context, ref, child) {
                      final externalIdsAsync = ref.watch(tvExternalIdsProvider(tv.id));
                      return ElevatedButton.icon(
                        onPressed: () {
                          externalIdsAsync.when(
                            data: (ids) {
                              if (ids.imdbId != null) {
                                setState(() => _cachedImdbId = ids.imdbId);
                              }
                              final url = PlayUrlHelper.getTvServers(
                                imdbId: ids.imdbId,
                                tmdbId: tv.id,
                                season: 1,
                                episode: 1,
                              ).first.url;
                              ref.read(recentPlaysProvider.notifier).addToRecent(
                                FavoriteItem(
                                  id: tv.id,
                                  title: tv.name,
                                  posterPath: tv.posterPath,
                                  mediaType: 'tv',
                                  voteAverage: tv.voteAverage.toDouble(),
                                  createdAt: DateTime.now(),
                                ),
                              );
                              context.push('/play', extra: url);
                            },
                            loading: () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Loading playback info...')),
                            ),
                            error: (e, _) => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No internet connection')),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_arrow_rounded, size: 28, color: Colors.white),
                        label: Text('PLAY NOW', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 1.1)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE50914),
                          minimumSize: const Size(double.infinity, 54),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 8,
                          shadowColor: const Color(0xFFE50914).withOpacity(0.4),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // ACTION BUTTONS ROW (Improved to prevent cut-off)
                  Row(
                    children: [
                      _CompactActionButton(
                        icon: Icons.favorite_border_rounded,
                        activeIcon: Icons.favorite_rounded,
                        label: 'Favorite',
                        color: const Color(0xFFE50914),
                        isActiveProvider: isFavoriteProvider(tv.id),
                        onTap: () async {
                          final user = ref.read(userProvider);
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please login first')));
                            return;
                          }
                          await ref.read(firestoreRepositoryProvider).toggleFavorite(
                            FavoriteItem(
                              id: tv.id, title: tv.name, posterPath: tv.posterPath,
                              mediaType: 'tv', voteAverage: tv.voteAverage.toDouble(), createdAt: DateTime.now(),
                            ),
                          );
                        },
                        isDark: isDark, textPrimary: textPrimary, cardColor: cardColor,
                      ),
                      const SizedBox(width: 8),
                      _CompactActionButton(
                        icon: Icons.bookmark_border_rounded,
                        activeIcon: Icons.bookmark_rounded,
                        label: 'Watchlist',
                        color: const Color(0xFFF59E0B),
                        isActiveProvider: isWatchlistedProvider(tv.id),
                        onTap: () async {
                          final user = ref.read(userProvider);
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please login first')));
                            return;
                          }
                          await ref.read(firestoreRepositoryProvider).toggleWatchlist(
                            FavoriteItem(
                              id: tv.id, title: tv.name, posterPath: tv.posterPath,
                              mediaType: 'tv', voteAverage: tv.voteAverage.toDouble(), createdAt: DateTime.now(),
                            ),
                          );
                        },
                        isDark: isDark, textPrimary: textPrimary, cardColor: cardColor,
                      ),
                      const SizedBox(width: 8),
                      _CompactActionButton(
                        icon: Icons.share_rounded,
                        label: 'Share',
                        color: const Color(0xFF06B6D4),
                        onTap: () {},
                        isDark: isDark, textPrimary: textPrimary, cardColor: cardColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // OVERVIEW
                  Text('Overview', style: GoogleFonts.poppins(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(tv.overview, style: GoogleFonts.poppins(color: textSecondary, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 32),

                  // WATCH PROVIDERS
                  watchProvidersAsync.when(
                    data: (data) => WatchProviderSection(data: data),
                    loading: () => const SizedBox.shrink(),
                    error: (e, _) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 28),

                  // SEASONS HEADER
                  Row(
                    children: [
                      Text('Seasons & Episodes', style: GoogleFonts.poppins(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      if (tv.numberOfEpisodes != null)
                        Text('${tv.numberOfEpisodes} eps', style: GoogleFonts.poppins(color: textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // SEASONS LIST
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final season = mainSeasons[index];
                final isExpanded = _expandedSeason == season.seasonNumber;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: _SeasonCard(
                    season: season,
                    tvId: tv.id,
                    isExpanded: isExpanded,
                    onTap: () {
                      setState(() {
                        _expandedSeason = isExpanded ? null : season.seasonNumber;
                      });
                    },
                    isDark: isDark,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    cardColor: cardColor,
                  ),
                );
              },
              childCount: mainSeasons.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }
}

// ── COMPACT ACTION BUTTON ───────────────────────────────────
class _CompactActionButton extends ConsumerWidget {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isDark;
  final Color textPrimary;
  final Color cardColor;
  final ProviderListenable<AsyncValue<bool>>? isActiveProvider;
  final bool isActive;

  const _CompactActionButton({
    required this.icon,
    this.activeIcon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.isDark,
    required this.textPrimary,
    required this.cardColor,
    this.isActiveProvider,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool active = isActive;
    if (isActiveProvider != null) {
      active = ref.watch(isActiveProvider!).value ?? false;
    }

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: active ? color : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.12)),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                active ? (activeIcon ?? icon) : icon,
                color: active ? color : textPrimary.withOpacity(0.6),
                size: 20,
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: active ? color : textPrimary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeasonCard extends ConsumerWidget {
  final TvSeason season;
  final int tvId;
  final bool isExpanded;
  final VoidCallback onTap;
  final bool isDark;
  final Color textPrimary;
  final Color textSecondary;
  final Color cardColor;

  const _SeasonCard({
    required this.season, 
    required this.tvId, 
    required this.isExpanded, 
    required this.onTap,
    required this.isDark,
    required this.textPrimary,
    required this.textSecondary,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasonAsync = isExpanded ? ref.watch(seasonDetailsProvider((tvId: tvId, seasonNumber: season.seasonNumber))) : null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? const Color(0xFFE50914).withOpacity(0.4) : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.12)),
          width: 1,
        ),
        boxShadow: isExpanded ? [
          BoxShadow(color: const Color(0xFFE50914).withOpacity(0.1), blurRadius: 10, spreadRadius: -2)
        ] : null,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: season.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl: '${Endpoints.imageBaseUrl}${season.posterPath}',
                            width: 65, height: 95, fit: BoxFit.cover,
                            placeholder: (_, __) => const ShimmerLoading(width: 65, height: 95),
                          )
                        : Container(width: 65, height: 95, color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1), child: Icon(Icons.tv, color: textSecondary, size: 32)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(season.name, style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        if (season.episodeCount != null)
                          Text('${season.episodeCount} Episodes', style: GoogleFonts.poppins(color: textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                        if (season.airDate != null && season.airDate!.length >= 4)
                          Text(season.airDate!.substring(0, 4), style: GoogleFonts.poppins(color: textSecondary.withOpacity(0.7), fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: textSecondary),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: isDark ? Colors.white10 : Colors.black12, height: 1),
            ),
            if (seasonAsync == null)
              const SizedBox()
            else
              seasonAsync.when(
                data: (detail) => _EpisodeList(
                  episodes: detail.episodes,
                  tvId: tvId,
                  tvName: season.name,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  isDark: isDark,
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator(color: Color(0xFFE50914), strokeWidth: 2.5)),
                ),
                error: (e, _) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Failed to load episodes', style: GoogleFonts.poppins(color: const Color(0xFFE50914), fontSize: 13)),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _EpisodeList extends StatelessWidget {
  final List<TvEpisodeDetail> episodes;
  final int tvId;
  final String tvName;
  final Color textPrimary;
  final Color textSecondary;
  final bool isDark;

  const _EpisodeList({
    required this.episodes, 
    required this.tvId, 
    required this.tvName,
    required this.textPrimary,
    required this.textSecondary,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: episodes.map((ep) => _EpisodeTile(
        episode: ep, 
        tvId: tvId, 
        tvName: tvName,
        textPrimary: textPrimary,
        textSecondary: textSecondary,
        isDark: isDark,
      )).toList(),
    );
  }
}

class _EpisodeTile extends StatelessWidget {
  final TvEpisodeDetail episode;
  final int tvId;
  final String tvName;
  final Color textPrimary;
  final Color textSecondary;
  final bool isDark;

  const _EpisodeTile({
    required this.episode, 
    required this.tvId, 
    required this.tvName,
    required this.textPrimary,
    required this.textSecondary,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '/tv/$tvId/season/${episode.seasonNumber}/episode/${episode.episodeNumber}'
          '?name=${Uri.encodeComponent(tvName)}',
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // Episode thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  episode.stillPath != null
                      ? CachedNetworkImage(
                          imageUrl: '${Endpoints.imageBaseUrl}${episode.stillPath}',
                          width: 110, height: 65, fit: BoxFit.cover,
                          placeholder: (_, __) => const ShimmerLoading(width: 110, height: 65),
                        )
                      : Container(width: 110, height: 65, color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('E${episode.episodeNumber}', style: GoogleFonts.poppins(color: const Color(0xFFE50914), fontSize: 11, fontWeight: FontWeight.w800)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          episode.name,
                          style: GoogleFonts.poppins(color: textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (episode.overview.isNotEmpty)
                    Text(
                      episode.overview,
                      style: GoogleFonts.poppins(color: textSecondary, fontSize: 11, height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (episode.runtime != null) ...[
                    const SizedBox(height: 4),
                    Text('${episode.runtime}m', style: GoogleFonts.poppins(color: textSecondary.withOpacity(0.5), fontSize: 10, fontWeight: FontWeight.w500)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

