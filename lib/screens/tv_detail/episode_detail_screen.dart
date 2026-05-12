import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/endpoints.dart';
import '../../providers/tv_providers.dart';
import '../../models/tv_episode_detail_model.dart';
import '../../widgets/shimmer_loading.dart';
import '../../core/utils/play_url_helper.dart';

class EpisodeDetailScreen extends ConsumerStatefulWidget {
  final int seriesId;
  final int seasonNumber;
  final int episodeNumber;
  final String seriesName;

  const EpisodeDetailScreen({
    super.key,
    required this.seriesId,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.seriesName,
  });

  @override
  ConsumerState<EpisodeDetailScreen> createState() => _EpisodeDetailScreenState();
}

class _EpisodeDetailScreenState extends ConsumerState<EpisodeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double? _userRating;
  String? _cachedImdbId;

  EpisodeParams get _params => (
        seriesId: widget.seriesId,
        seasonNumber: widget.seasonNumber,
        episodeNumber: widget.episodeNumber,
      );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  void _showRatingDialog(bool isDark, Color textPrimary, Color cardColor) {
    double tempRating = _userRating ?? 7.0;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Rate this Episode',
              style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${tempRating.toStringAsFixed(1)} / 10',
                style: GoogleFonts.poppins(color: const Color(0xFFE50914), fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Slider(
                value: tempRating,
                min: 0.5,
                max: 10.0,
                divisions: 19,
                activeColor: const Color(0xFFE50914),
                inactiveColor: isDark ? Colors.white24 : Colors.black12,
                onChanged: (v) => setDialogState(() => tempRating = v),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0.5', style: GoogleFonts.poppins(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12)),
                  Text('10.0', style: GoogleFonts.poppins(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel', style: GoogleFonts.poppins(color: isDark ? Colors.white54 : Colors.black54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE50914)),
              onPressed: () async {
                Navigator.pop(ctx);
                setState(() => _userRating = tempRating);
                try {
                  await ref.read(tvRepositoryProvider).addEpisodeRating(
                    widget.seriesId,
                    widget.seasonNumber,
                    widget.episodeNumber,
                    tempRating,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Rated ${tempRating.toStringAsFixed(1)}/10 ✓', style: GoogleFonts.poppins()),
                        backgroundColor: Colors.green[700],
                      ),
                    );
                  }
                } catch (_) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Rating requires login', style: GoogleFonts.poppins()), backgroundColor: Colors.orange),
                    );
                  }
                }
              },
              child: Text('Submit', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final episodeAsync = ref.watch(tvEpisodeDetailsProvider(_params));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA);

    return episodeAsync.when(
      data: (ep) => _EpisodeContent(
        ep: ep,
        params: _params,
        seriesName: widget.seriesName,
        tabController: _tabController,
        userRating: _userRating,
        onRate: () => _showRatingDialog(isDark, isDark ? Colors.white : Colors.black, isDark ? const Color(0xFF1C2230) : Colors.white),
      ),
      loading: () => Scaffold(
        backgroundColor: bgColor,
        body: const Center(child: CircularProgressIndicator(color: Color(0xFFE50914))),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: bgColor,
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
                'Check your network settings',
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

class _EpisodeContent extends ConsumerWidget {
  final TvEpisodeFullDetail ep;
  final EpisodeParams params;
  final String seriesName;
  final TabController tabController;
  final double? userRating;
  final VoidCallback onRate;

  const _EpisodeContent({
    required this.ep,
    required this.params,
    required this.seriesName,
    required this.tabController,
    this.userRating,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creditsAsync = ref.watch(tvEpisodeCreditsProvider(params));
    final videosAsync = ref.watch(tvEpisodeVideosProvider(params));
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA);
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);
    final cardColor = isDark ? const Color(0xFF1C2230) : const Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (ctx, _) => [
          SliverAppBar(
            expandedHeight: size.height * 0.40,
            pinned: true,
            backgroundColor: bgColor,
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
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    icon: Icon(userRating != null ? Icons.star_rounded : Icons.star_outline_rounded, 
                      color: userRating != null ? const Color(0xFFFFD700) : Colors.white, size: 18),
                    onPressed: onRate,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: IconButton(
                    icon: const Icon(Icons.share_outlined, color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ep.stillPath != null
                      ? CachedNetworkImage(
                          imageUrl: '${Endpoints.imageBaseUrlOriginal}${ep.stillPath}',
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const ShimmerLoading(),
                          errorWidget: (_, __, ___) => Container(color: cardColor),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [cardColor, bgColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Icon(Icons.tv, size: 80, color: textSecondary.withOpacity(0.2)),
                        ),
                  // Gradient overlay
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          bgColor.withOpacity(0.4),
                          bgColor.withOpacity(0.9),
                          bgColor,
                        ],
                        stops: const [0.0, 0.45, 0.8, 1.0],
                      ),
                    ),
                  ),
                  // Bottom info
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seriesName.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFE50914),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ep.name,
                          style: GoogleFonts.poppins(
                            color: textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _MetaChip(label: 'S${ep.seasonNumber}', icon: Icons.layers_outlined, isDark: isDark),
                            const SizedBox(width: 8),
                            _MetaChip(label: 'E${ep.episodeNumber}', icon: Icons.play_circle_outline, isDark: isDark),
                            if (ep.runtime != null) ...[
                              const SizedBox(width: 8),
                              _MetaChip(label: '${ep.runtime}m', icon: Icons.schedule_outlined, isDark: isDark),
                            ],
                            if (ep.voteAverage > 0) ...[
                              const SizedBox(width: 12),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    ep.voteAverage.toStringAsFixed(1),
                                    style: GoogleFonts.poppins(color: textPrimary, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Play button + Rating
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ep.airDate != null)
                    Text(
                      'Aired: ${ep.airDate}',
                      style: GoogleFonts.poppins(color: textSecondary, fontSize: 12),
                    ),
                  const SizedBox(height: 12),
                  // Official Audio Row
                  Consumer(
                    builder: (context, ref, child) {
                      final tvDetailsAsync = ref.watch(tvDetailsProvider(params.seriesId));
                      return tvDetailsAsync.maybeWhen(
                        data: (tv) => tv.languages.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
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
                              )
                            : const SizedBox.shrink(),
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final seriesIdsAsync = ref.watch(tvExternalIdsProvider(params.seriesId));

                            return ElevatedButton.icon(
                              onPressed: () {
                                seriesIdsAsync.when(
                                  data: (sIds) {
                                    final url = PlayUrlHelper.getTvServers(
                                      imdbId: sIds.imdbId,
                                      tmdbId: params.seriesId,
                                      season: params.seasonNumber,
                                      episode: params.episodeNumber,
                                    ).first.url;
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
                              icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                              label: Text('PLAY EPISODE', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.8)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE50914),
                                minimumSize: const Size(0, 54),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 8,
                                shadowColor: const Color(0xFFE50914).withOpacity(0.3),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: OutlinedButton.icon(
                          onPressed: onRate,
                          icon: Icon(
                            userRating != null ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: const Color(0xFFFFD700),
                            size: 22,
                          ),
                          label: Text(
                            userRating != null ? '${userRating!.toStringAsFixed(1)}' : 'RATE',
                            style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
                            backgroundColor: cardColor,
                            minimumSize: const Size(0, 54),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Overview

                  if (ep.overview.isNotEmpty) ...[
                    Text('Overview', style: GoogleFonts.poppins(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(ep.overview, style: GoogleFonts.poppins(color: textSecondary, fontSize: 14, height: 1.6)),
                    const SizedBox(height: 32),
                  ],
                  // Videos row
                  videosAsync.when(
                    data: (vids) {
                      final trailers = vids.results.where((v) => v.site == 'YouTube').toList();
                      if (trailers.isEmpty) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trailers & Videos', style: GoogleFonts.poppins(color: textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 110,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: trailers.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (ctx, i) {
                                final v = trailers[i];
                                return _VideoThumbCard(video: v, cardColor: cardColor);
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  // TabBar
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05), width: 1)),
                    ),
                    child: TabBar(
                      controller: tabController,
                      indicatorColor: const Color(0xFFE50914),
                      indicatorWeight: 3,
                      labelColor: textPrimary,
                      unselectedLabelColor: textSecondary,
                      labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
                      tabs: const [
                        Tab(text: 'Cast'),
                        Tab(text: 'Crew'),
                        Tab(text: 'Guest'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: creditsAsync.when(
          data: (credits) => TabBarView(
            controller: tabController,
            children: [
              _PersonList(people: credits.cast, textPrimary: textPrimary, textSecondary: textSecondary),
              _PersonList(people: credits.crew.map((c) => TvEpisodeCastMember(
                id: c.id, 
                name: c.name, 
                originalName: c.originalName,
                character: '${c.job} · ${c.department}', 
                creditId: c.creditId,
                order: 0,
                profilePath: c.profilePath,
              )).toList(), textPrimary: textPrimary, textSecondary: textSecondary),
              _PersonList(people: credits.guestStars, textPrimary: textPrimary, textSecondary: textSecondary),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFE50914))),
          error: (e, _) => Center(child: Text('Failed to load credits', style: GoogleFonts.poppins(color: const Color(0xFFE50914)))),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isDark;
  const _MetaChip({required this.label, required this.icon, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isDark ? Colors.white60 : Colors.black54, size: 14),
          const SizedBox(width: 6),
          Text(label, style: GoogleFonts.poppins(color: isDark ? Colors.white70 : Colors.black87, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _VideoThumbCard extends StatelessWidget {
  final TvEpisodeVideo video;
  final Color cardColor;
  const _VideoThumbCard({required this.video, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final url = 'https://www.youtube.com/watch?v=${video.key}';
        context.push('/play', extra: url);
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cardColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://img.youtube.com/vi/${video.key}/mqdefault.jpg',
                fit: BoxFit.cover,
                placeholder: (_, __) => const ShimmerLoading(),
                errorWidget: (_, __, ___) => Container(color: cardColor),
              ),
              Container(color: Colors.black.withOpacity(0.3)),
              const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 40)),
              Positioned(
                bottom: 8, left: 8, right: 8,
                child: Text(
                  video.name,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonList extends StatelessWidget {
  final List<TvEpisodeCastMember> people;
  final Color textPrimary;
  final Color textSecondary;
  const _PersonList({required this.people, required this.textPrimary, required this.textSecondary});

  @override
  Widget build(BuildContext context) {
    if (people.isEmpty) {
      return Center(child: Text('No information available', style: GoogleFonts.poppins(color: textSecondary)));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: people.length,
      itemBuilder: (ctx, i) {
        final p = people[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: textSecondary.withOpacity(0.1),
            backgroundImage: p.profilePath != null
                ? CachedNetworkImageProvider('${Endpoints.imageBaseUrl}${p.profilePath}')
                : null,
            child: p.profilePath == null ? Icon(Icons.person, color: textSecondary.withOpacity(0.5)) : null,
          ),
          title: Text(p.name, style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: Text(p.character, style: GoogleFonts.poppins(color: textSecondary, fontSize: 12)),
          trailing: Icon(Icons.chevron_right, color: textSecondary.withOpacity(0.3)),
          onTap: () {},
        );
      },
    );
  }
}
