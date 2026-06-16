import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../providers/user_content_providers.dart';
import '../../api/endpoints.dart';
import '../../repositories/firestore_repository.dart';
import '../../core/utils/responsive_utils.dart';

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistAsync = ref.watch(watchlistStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA);
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);
    final cardColor = isDark ? const Color(0xFF161B22) : Colors.white;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: cardColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: textPrimary, size: 20),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'My Watchlist',
            style: GoogleFonts.poppins(
              color: textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Movies'),
              Tab(text: 'TV Shows'),
            ],
            indicatorColor: const Color(0xFFE50914),
            indicatorWeight: 3,
            labelColor: textPrimary,
            unselectedLabelColor: textSecondary,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14),
            unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        body: watchlistAsync.when(
          data: (watchlist) {
            final movies = watchlist.where((f) => f.mediaType == 'movie').toList();
            final tvShows = watchlist.where((f) => f.mediaType == 'tv').toList();
            return TabBarView(
              children: [
                _WatchlistGrid(items: movies, emptyMsg: 'Watchlist is empty', textPrimary: textPrimary, textSecondary: textSecondary, isDark: isDark),
                _WatchlistGrid(items: tvShows, emptyMsg: 'Watchlist is empty', textPrimary: textPrimary, textSecondary: textSecondary, isDark: isDark),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFE50914), strokeWidth: 2)),
          error: (e, _) {
            final isPermissionDenied = e is FirebaseException && e.code == 'permission-denied';
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isPermissionDenied ? Icons.lock_outline_rounded : Icons.wifi_off_rounded,
                      size: 48,
                      color: const Color(0xFFE50914),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isPermissionDenied ? 'Access Denied (Rules Expired)' : 'No internet connection',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPermissionDenied
                          ? 'Please set/update your Firestore Rules in Firebase Console to allow read/write.'
                          : 'Please check your connection and try again.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: textSecondary, fontSize: 13),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WatchlistGrid extends StatelessWidget {
  final List<FavoriteItem> items;
  final String emptyMsg;
  final Color textPrimary;
  final Color textSecondary;
  final bool isDark;

  const _WatchlistGrid({
    required this.items, 
    required this.emptyMsg, 
    required this.textPrimary, 
    required this.textSecondary, 
    required this.isDark
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bookmark_border_rounded, size: 40, color: textSecondary.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            Text(
              emptyMsg,
              style: GoogleFonts.poppins(
                color: textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add movies to watch later!',
              style: GoogleFonts.poppins(color: textSecondary, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return Responsive.constrainedContent(
      context: context,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.gridColumns(context),
          childAspectRatio: Responsive.gridAspectRatio(context),
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => context.push('/${item.mediaType}/${item.id}'),
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
                          imageUrl: '${Endpoints.imageBaseUrl}${item.posterPath}',
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.broken_image_outlined, color: textSecondary.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
                          ),
                          child: const Icon(Icons.bookmark_rounded, color: Colors.white, size: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
