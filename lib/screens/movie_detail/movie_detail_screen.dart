import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/movie_providers.dart';
import '../../api/endpoints.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/watch_provider_section.dart';
import '../../core/utils/play_url_helper.dart';
import '../../providers/watch_provider_providers.dart' hide movieWatchProvidersProvider;
import '../../providers/user_content_providers.dart';
import '../../repositories/firestore_repository.dart';
import '../../providers/auth_providers.dart';
import '../../providers/history_providers.dart';

class MovieDetailScreen extends ConsumerWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetailAsync = ref.watch(movieDetailsProvider(movieId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return movieDetailAsync.when(
      data: (movie) => _MovieDetailContent(movie: movie, movieId: movieId),
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

class _MovieDetailContent extends ConsumerStatefulWidget {
  final dynamic movie;
  final int movieId;
  const _MovieDetailContent({required this.movie, required this.movieId});

  @override
  ConsumerState<_MovieDetailContent> createState() => _MovieDetailContentState();
}

class _MovieDetailContentState extends ConsumerState<_MovieDetailContent> {
  @override
  Widget build(BuildContext context) {
    final videosAsync = ref.watch(movieVideosProvider(widget.movieId));
    final keywordsAsync = ref.watch(movieKeywordsProvider(widget.movieId));
    final reviewsAsync = ref.watch(movieReviewsProvider(widget.movieId));
    final watchProvidersAsync = ref.watch(movieWatchProvidersProvider(widget.movieId));
    final similarAsync = ref.watch(similarMoviesProvider(widget.movieId));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final movie = widget.movie;
    final movieId = widget.movieId;

    final bgColor = isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA);
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);
    final cardColor = isDark ? const Color(0xFF1C2230) : const Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero AppBar ──────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 420,
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
            actions: [
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
                  CachedNetworkImage(
                    imageUrl: '${Endpoints.imageBaseUrlOriginal}${movie.backdropPath ?? movie.posterPath}',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const ShimmerLoading(),
                    errorWidget: (ctx, url, err) => Container(color: Colors.grey[900]),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          bgColor.withOpacity(0.3),
                          bgColor.withOpacity(0.9),
                          bgColor,
                        ],
                        stops: const [0.0, 0.4, 0.8, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16, left: 16, right: 16,
                    child: Text(
                      movie.title,
                      style: GoogleFonts.poppins(
                        color: textPrimary, fontSize: 28,
                        fontWeight: FontWeight.w900, height: 1.2,
                      ),
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

                  // ── Meta row ──────────────────────────────────────
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 20),
                      const SizedBox(width: 4),
                      Text(movie.voteAverage.toStringAsFixed(1),
                          style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(width: 16),
                      if (movie.releaseDate != null && movie.releaseDate!.length >= 4)
                        Text(movie.releaseDate!.substring(0, 4),
                            style: GoogleFonts.poppins(color: textSecondary, fontSize: 14)),
                      const SizedBox(width: 12),
                      if (movie.runtime != null)
                        Text('${movie.runtime} min',
                            style: GoogleFonts.poppins(color: textSecondary, fontSize: 14)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          movie.genres.map((e) => e.name).join(' • '),
                          style: GoogleFonts.poppins(color: textSecondary, fontSize: 13),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                   ],
                  ),
                  const SizedBox(height: 12),
                  // Official Audio Row
                  if (movie.spokenLanguages.isNotEmpty)
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
                            movie.spokenLanguages.map((l) => l.englishName).join(', '),
                            style: GoogleFonts.poppins(color: textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref.read(recentPlaysProvider.notifier).addToRecent(
                          FavoriteItem(
                            id: movie.id,
                            title: movie.title,
                            posterPath: movie.posterPath,
                            mediaType: 'movie',
                            voteAverage: movie.voteAverage.toDouble(),
                            createdAt: DateTime.now(),
                          ),
                        );
                        final url = PlayUrlHelper.getMovieServers(
                          imdbId: movie.imdbId,
                          tmdbId: movie.id,
                        ).first.url;
                        context.push('/play', extra: url);
                      },
                      icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                      label: Text('PLAY NOW', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: 1.1)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE50914),
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 8,
                        shadowColor: const Color(0xFFE50914).withOpacity(0.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Action buttons ────────────────────────────────
                  Row(
                    children: [
                      _CompactActionButton(
                        icon: Icons.favorite_border_rounded,
                        activeIcon: Icons.favorite_rounded,
                        label: 'Favorite',
                        color: const Color(0xFFE50914),
                        isActiveProvider: isFavoriteProvider(movie.id),
                        onTap: () async {
                          final user = ref.read(userProvider);
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please login first')));
                            return;
                          }
                          await ref.read(firestoreRepositoryProvider).toggleFavorite(
                            FavoriteItem(
                              id: movie.id, title: movie.title, posterPath: movie.posterPath,
                              mediaType: 'movie', voteAverage: movie.voteAverage.toDouble(), createdAt: DateTime.now(),
                            ),
                          );
                        },
                        isDark: isDark, textPrimary: textPrimary, cardColor: cardColor,
                      ),
                      const SizedBox(width: 10),
                      _CompactActionButton(
                        icon: Icons.bookmark_border_rounded,
                        activeIcon: Icons.bookmark_rounded,
                        label: 'Watchlist',
                        color: const Color(0xFFF59E0B),
                        isActiveProvider: isWatchlistedProvider(movie.id),
                        onTap: () async {
                          final user = ref.read(userProvider);
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please login first')));
                            return;
                          }
                          await ref.read(firestoreRepositoryProvider).toggleWatchlist(
                            FavoriteItem(
                              id: movie.id, title: movie.title, posterPath: movie.posterPath,
                              mediaType: 'movie', voteAverage: movie.voteAverage.toDouble(), createdAt: DateTime.now(),
                            ),
                          );
                        },
                        isDark: isDark, textPrimary: textPrimary, cardColor: cardColor,
                      ),
                      const SizedBox(width: 10),
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

                  // ── Overview ──────────────────────────────────────
                  const _SectionTitle(title: 'Overview'),
                  const SizedBox(height: 10),
                  Text(movie.overview,
                      style: GoogleFonts.poppins(fontSize: 14, height: 1.7, color: textSecondary)),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // ── Trailers & Videos ────────────────────────────────────
          SliverToBoxAdapter(
            child: videosAsync.when(
              data: (data) {
                final videos = data.results.where((v) => v.site == 'YouTube').toList();
                if (videos.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _SectionTitle(title: 'Trailers & Videos'),
                    ),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: videos.length,
                        itemBuilder: (context, i) {
                          final v = videos[i];
                          return GestureDetector(
                            onTap: () => context.push('/play',
                                extra: 'https://www.youtube.com/watch?v=${v.key}'),
                            child: Container(
                              width: 260,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: cardColor,
                                border: Border.all(color: textPrimary.withOpacity(0.1)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: 'https://img.youtube.com/vi/${v.key}/mqdefault.jpg',
                                      width: 260, height: 170, fit: BoxFit.cover,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                                        ),
                                      ),
                                    ),
                                    const Center(
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xCCE50914),
                                        radius: 24,
                                        child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8, left: 12, right: 12,
                                      child: Text(v.name,
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                    ),
                                    Positioned(
                                      top: 8, right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(v.type.toUpperCase(),
                                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
          ),

          // ── Where to Watch ───────────────────────────────────────
          SliverToBoxAdapter(
            child: watchProvidersAsync.when(
              data: (data) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: WatchProviderSection(data: data),
              ),
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
          ),

          // ── Reviews ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: reviewsAsync.when(
              data: (data) {
                if (data.results.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _SectionTitle(title: 'Reviews'),
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: data.results.length,
                        itemBuilder: (context, i) {
                          final r = data.results[i];
                          final rating = r.authorDetails.rating;
                          return Container(
                            width: 280,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: textPrimary.withOpacity(0.1)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color(0xFFE50914),
                                      backgroundImage: r.authorDetails.avatarPath != null
                                          ? CachedNetworkImageProvider(
                                              r.authorDetails.avatarPath!.startsWith('/')
                                                  ? '${Endpoints.imageBaseUrl}${r.authorDetails.avatarPath}'
                                                  : r.authorDetails.avatarPath!,
                                            )
                                          : null,
                                      child: r.authorDetails.avatarPath == null
                                          ? Text(r.author.isNotEmpty ? r.author[0].toUpperCase() : '?',
                                              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold))
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(r.author,
                                              style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                                              maxLines: 1, overflow: TextOverflow.ellipsis),
                                          if (rating != null)
                                            Row(
                                              children: [
                                                const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 14),
                                                const SizedBox(width: 2),
                                                Text(rating.toStringAsFixed(1),
                                                    style: GoogleFonts.poppins(color: const Color(0xFFFFD700), fontSize: 12, fontWeight: FontWeight.w600)),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: Text(r.content,
                                      style: GoogleFonts.poppins(color: textSecondary, fontSize: 12, height: 1.5),
                                      maxLines: 4, overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
          ),

          // ── Keywords ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: keywordsAsync.when(
              data: (data) {
                if (data.keywords.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionTitle(title: 'Keywords'),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: data.keywords.take(16).map((kw) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: textPrimary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: textPrimary.withOpacity(0.1)),
                            ),
                            child: Text(kw.name,
                                style: GoogleFonts.poppins(color: textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
          ),

          // ── Similar Movies ───────────────────────────────────────
          SliverToBoxAdapter(
            child: similarAsync.when(
              data: (movies) {
                if (movies.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _SectionTitle(title: 'More Like This'),
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: movies.length,
                        itemBuilder: (context, i) {
                          final m = movies[i];
                          return GestureDetector(
                            onTap: () => context.push('/movie/${m.id}'),
                            child: Container(
                              width: 125,
                              margin: const EdgeInsets.only(right: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: m.posterPath != null
                                          ? '${Endpoints.imageBaseUrl}${m.posterPath}'
                                          : '',
                                      width: 125, height: 180, fit: BoxFit.cover,
                                      placeholder: (_, __) => Container(
                                          width: 125, height: 180, color: textPrimary.withOpacity(0.05)),
                                      errorWidget: (_, __, ___) => Container(
                                          width: 125, height: 180,
                                          color: textPrimary.withOpacity(0.05),
                                          child: Icon(Icons.movie_outlined, color: textSecondary, size: 36)),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(m.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(color: textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
          ),

          // ── Collection Banner ────────────────────────────────────
          if (movie.belongsToCollection != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle(title: 'Part of a Collection'),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: '${Endpoints.imageBaseUrlOriginal}${movie.belongsToCollection!.backdropPath ?? movie.belongsToCollection!.posterPath}',
                            height: 150, width: double.infinity, fit: BoxFit.cover,
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                                  begin: Alignment.bottomLeft, end: Alignment.topRight,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16, left: 16, right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.belongsToCollection!.name,
                                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                Text('VIEW COLLECTION →',
                                    style: GoogleFonts.poppins(color: const Color(0xFFE50914), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);

    return Row(
      children: [
        Container(
          width: 4, height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFE50914),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(title,
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: textPrimary)),
      ],
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

