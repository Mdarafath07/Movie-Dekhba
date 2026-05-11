import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/tv_show_model.dart';
import '../../../api/endpoints.dart';
import '../../../widgets/shimmer_loading.dart';

class TvListRow extends StatelessWidget {
  final String title;
  final AsyncValue<List<TvShow>> asyncValue;

  const TvListRow({
    super.key,
    required this.title,
    required this.asyncValue,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary)),
          ),
        SizedBox(
          height: 220,
          child: asyncValue.when(
            data: (shows) => ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              itemCount: shows.length,
              itemBuilder: (context, index) {
                final show = shows[index];
                return _TvCard(show: show, textPrimary: textPrimary, textSecondary: textSecondary);
              },
            ),
            loading: () => ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              itemCount: 6,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: ShimmerLoading(width: 130, height: 200),
              ),
            ),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('No internet connection', style: GoogleFonts.poppins(color: textSecondary, fontSize: 13)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TvCard extends StatelessWidget {
  final TvShow show;
  final Color textPrimary;
  final Color textSecondary;

  const _TvCard({required this.show, required this.textPrimary, required this.textSecondary});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/tv/${show.id}'),
      child: Container(
        width: 130,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    show.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl: '${Endpoints.imageBaseUrl}${show.posterPath}',
                            fit: BoxFit.cover,
                            placeholder: (_, __) => const ShimmerLoading(width: 130, height: 170),
                            errorWidget: (_, __, ___) => Container(
                              color: Colors.grey[900],
                              child: const Icon(Icons.tv, color: Colors.white30, size: 40),
                            ),
                          )
                        : Container(color: Colors.grey[900], child: const Icon(Icons.tv, color: Colors.white30, size: 40)),
                    // Rating badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 12),
                            const SizedBox(width: 2),
                            Text(
                              show.voteAverage.toStringAsFixed(1),
                              style: GoogleFonts.poppins(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bottom gradient
                    Positioned(
                      bottom: 0, left: 0, right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              show.name,
              style: GoogleFonts.poppins(color: textPrimary, fontSize: 12, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (show.firstAirDate != null && show.firstAirDate!.length >= 4)
              Text(
                show.firstAirDate!.substring(0, 4),
                style: GoogleFonts.poppins(color: textSecondary, fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
