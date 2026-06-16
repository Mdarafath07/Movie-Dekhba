import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/account_providers.dart';
import '../../providers/auth_providers.dart';
import '../../providers/tv_providers.dart';
import '../../models/tv_show_model.dart';
import '../../widgets/movie_poster.dart';
import '../../core/utils/responsive_utils.dart';

// Provide a guest session ID for demo purposes.
// In a real app, this would be generated once and stored securely.
final guestSessionProvider = FutureProvider<String>((ref) async {
  final accountRepo = ref.read(accountRepositoryProvider);
  return accountRepo.createGuestSession();
});

final ratedTvProvider = FutureProvider<List<TvShow>>((ref) async {
  final guestSessionId = await ref.watch(guestSessionProvider.future);
  final tvRepo = ref.watch(tvRepositoryProvider);
  return tvRepo.getGuestSessionRatedTv(guestSessionId);
});

class RatingsScreen extends ConsumerWidget {
  const RatingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratedTvAsync = ref.watch(ratedTvProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rated TV Shows'),
        backgroundColor: Colors.transparent,
      ),
      body: ratedTvAsync.when(
        data: (shows) {
          if (shows.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No rated TV shows found.', style: TextStyle(color: Colors.grey.shade400, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('Rate shows to see them here!', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return Responsive.constrainedContent(
            context: context,
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.gridColumns(context),
                childAspectRatio: Responsive.gridAspectRatio(context),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: shows.length,
              itemBuilder: (context, index) {
                final show = shows[index];
                return MoviePoster(
                  posterPath: show.posterPath,
                  width: double.infinity,
                  height: double.infinity,
                  onTap: () {},
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
