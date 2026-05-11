import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/endpoints.dart';
import '../models/watch_provider_model.dart';

class WatchProviderSection extends StatelessWidget {
  final WatchProvidersResponse data;
  final String region;

  const WatchProviderSection({
    super.key,
    required this.data,
    this.region = 'US',
  });

  @override
  Widget build(BuildContext context) {
    final regionData = data.results[region] ?? data.results.values.firstOrNull;
    if (regionData == null) return const SizedBox.shrink();

    final flatrate = regionData.flatrate ?? [];
    final rent = regionData.rent ?? [];
    final buy = regionData.buy ?? [];

    if (flatrate.isEmpty && rent.isEmpty && buy.isEmpty) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Where to Watch', textPrimary: textPrimary),
        const SizedBox(height: 12),
        if (flatrate.isNotEmpty) ...[
          _ProviderCategory(title: 'Streaming', providers: flatrate, textSecondary: textSecondary),
          const SizedBox(height: 16),
        ],
        if (rent.isNotEmpty) ...[
          _ProviderCategory(title: 'Rent', providers: rent, textSecondary: textSecondary),
          const SizedBox(height: 16),
        ],
        if (buy.isNotEmpty) ...[
          _ProviderCategory(title: 'Buy', providers: buy, textSecondary: textSecondary),
          const SizedBox(height: 16),
        ],
        Text(
          'Source: JustWatch',
          style: GoogleFonts.poppins(color: textSecondary.withOpacity(0.5), fontSize: 10),
        ),
      ],
    );
  }
}

class _ProviderCategory extends StatelessWidget {
  final String title;
  final List<WatchProviderItem> providers;
  final Color textSecondary;

  const _ProviderCategory({required this.title, required this.providers, required this.textSecondary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final p = providers[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Tooltip(
                  message: p.providerName,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: '${Endpoints.imageBaseUrl}${p.logoPath}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        width: 50,
                        height: 50,
                        color: textSecondary.withOpacity(0.1),
                        child: Icon(Icons.tv, color: textSecondary.withOpacity(0.5), size: 20),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color textPrimary;
  const _SectionTitle({required this.title, required this.textPrimary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFE50914),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
      ],
    );
  }
}
