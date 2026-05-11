import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/watch_provider_model.dart';
import '../repositories/movie_repository.dart';
import '../repositories/tv_repository.dart';
import '../repositories/watch_provider_repository.dart';

final watchProviderRepositoryProvider = Provider((ref) => WatchProviderRepository());
final movieRepositoryProvider = Provider((ref) => MovieRepository());
final tvRepositoryProvider = Provider((ref) => TvRepository());

final watchProviderRegionsProvider = FutureProvider<List<TmdbRegion>>((ref) async {
  return ref.watch(watchProviderRepositoryProvider).getAvailableRegions();
});

final movieWatchProvidersProvider = FutureProvider.family<WatchProvidersResponse, int>((ref, movieId) async {
  return ref.watch(movieRepositoryProvider).getWatchProviders(movieId);
});

final tvWatchProvidersProvider = FutureProvider.family<WatchProvidersResponse, int>((ref, tvId) async {
  return ref.watch(tvRepositoryProvider).getWatchProviders(tvId);
});
