import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/movie_repository.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository();
});

final trendingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getTrendingMovies();
});

final popularMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getPopularMovies();
});

final topRatedMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getTopRatedMovies();
});

final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getUpcomingMovies();
});

final movieDetailsProvider = FutureProvider.family<MovieDetail, int>((ref, id) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getMovieDetails(id);
});

final similarMoviesProvider = FutureProvider.family<List<Movie>, int>((ref, id) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getSimilarMovies(id);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  final repository = ref.watch(movieRepositoryProvider);
  return repository.searchMovies(query);
});

final movieVideosProvider = FutureProvider.family((ref, int id) async {
  return ref.watch(movieRepositoryProvider).getVideos(id);
});

final movieKeywordsProvider = FutureProvider.family((ref, int id) async {
  return ref.watch(movieRepositoryProvider).getKeywords(id);
});

final movieReviewsProvider = FutureProvider.family((ref, int id) async {
  return ref.watch(movieRepositoryProvider).getReviews(id);
});

final movieWatchProvidersProvider = FutureProvider.family((ref, int id) async {
  return ref.watch(movieRepositoryProvider).getWatchProviders(id);
});

final movieReleaseDatesProvider = FutureProvider.family((ref, int id) async {
  return ref.watch(movieRepositoryProvider).getReleaseDates(id);
});
final animeMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.discoverMovies(withGenres: '16');
});
