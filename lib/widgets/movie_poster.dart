import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/endpoints.dart';
import 'shimmer_loading.dart';

class MoviePoster extends StatelessWidget {
  final String? posterPath;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const MoviePoster({
    super.key,
    required this.posterPath,
    this.width = 120,
    this.height = 180,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: width,
          height: height,
          child: posterPath != null && posterPath!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: '${Endpoints.imageBaseUrl}$posterPath',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ShimmerLoading(width: width, height: height),
                  errorWidget: (context, url, error) => _buildErrorWidget(isDark),
                )
              : _buildErrorWidget(isDark),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(bool isDark) {
    return Container(
      color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
      child: Center(
        child: Icon(
          Icons.movie_outlined, 
          color: isDark ? Colors.white24 : Colors.black26, 
          size: width * 0.3,
        ),
      ),
    );
  }
}
