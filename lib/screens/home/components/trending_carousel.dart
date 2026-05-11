import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../models/movie_model.dart';
import '../../../api/endpoints.dart';
import '../../../widgets/shimmer_loading.dart';

class TrendingCarousel extends StatefulWidget {
  final List<Movie> movies;
  const TrendingCarousel({super.key, required this.movies});

  @override
  State<TrendingCarousel> createState() => _TrendingCarouselState();
}

class _TrendingCarouselState extends State<TrendingCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = widget.movies.take(6).toList();
    if (items.isEmpty) return const SizedBox();

    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: items.length,
          options: CarouselOptions(
            height: 500,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayCurve: Curves.easeInOut,
            onPageChanged: (index, _) => setState(() => _currentIndex = index),
          ),
          itemBuilder: (context, index, realIndex) {
            final movie = items[index];
            return GestureDetector(
              onTap: () => context.push('/movie/${movie.id}'),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Backdrop image
                  CachedNetworkImage(
                    imageUrl: '${Endpoints.imageBaseUrlOriginal}${movie.backdropPath ?? movie.posterPath}',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const ShimmerLoading(),
                    errorWidget: (_, __, ___) => Container(color: Colors.grey[900]),
                  ),
                  // Multi-stop gradient for depth
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                          const Color(0xFF0A0A0A).withOpacity(0.95),
                          const Color(0xFF0A0A0A),
                        ],
                        stops: const [0.0, 0.2, 0.55, 0.85, 1.0],
                      ),
                    ),
                  ),
                  // Side gradient for vignette
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    bottom: 32,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE50914),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('TRENDING', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.15,
                            shadows: [Shadow(color: Colors.black, blurRadius: 12)],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                            const SizedBox(width: 12),
                            if (movie.releaseDate != null && movie.releaseDate!.length >= 4)
                              Text(movie.releaseDate!.substring(0, 4), style: const TextStyle(color: Colors.white54, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => context.push('/movie/${movie.id}'),
                              icon: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 22),
                              label: const Text('Play', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                              ),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton.icon(
                              onPressed: () => context.push('/movie/${movie.id}'),
                              icon: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 18),
                              label: const Text('Details', style: TextStyle(color: Colors.white, fontSize: 14)),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white54),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // Dot indicators
        Positioned(
          bottom: 12,
          right: 16,
          child: Row(
            children: List.generate(items.length, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == i ? 20 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: _currentIndex == i ? const Color(0xFFE50914) : Colors.white38,
                borderRadius: BorderRadius.circular(3),
              ),
            )),
          ),
        ),
      ],
    );
  }
}
