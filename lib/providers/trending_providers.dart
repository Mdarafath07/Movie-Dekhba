import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/trending_repository.dart';
import '../models/movie_response.dart';
import '../models/person_model.dart';
import '../models/search_multi_model.dart';
import '../models/tv_show_model.dart';

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  return TrendingRepository();
});

// Fixed window providers
final trendingAllDayProvider = FutureProvider.autoDispose<MultiSearchResponse>((ref) {
  return ref.read(trendingRepositoryProvider).getTrendingAll(TrendingTimeWindow.day);
});

final trendingMoviesDayProvider = FutureProvider.autoDispose<MovieResponse>((ref) {
  return ref.read(trendingRepositoryProvider).getTrendingMovies(TrendingTimeWindow.day);
});

final trendingTvDayProvider = FutureProvider.autoDispose<TvShowResponse>((ref) {
  return ref.read(trendingRepositoryProvider).getTrendingTv(TrendingTimeWindow.day);
});

final trendingPeopleDayProvider = FutureProvider.autoDispose<PersonResponse>((ref) {
  return ref.read(trendingRepositoryProvider).getTrendingPeople(TrendingTimeWindow.day);
});

// Family providers for flexible time window
final trendingAllProvider = FutureProvider.autoDispose.family<MultiSearchResponse, String>((ref, timeWindow) {
  return ref.read(trendingRepositoryProvider).getTrendingAll(timeWindow);
});

final trendingMoviesProvider = FutureProvider.autoDispose.family<MovieResponse, String>((ref, timeWindow) {
  return ref.read(trendingRepositoryProvider).getTrendingMovies(timeWindow);
});

final trendingTvProvider = FutureProvider.autoDispose.family<TvShowResponse, String>((ref, timeWindow) {
  return ref.read(trendingRepositoryProvider).getTrendingTv(timeWindow);
});

final trendingPeopleProvider = FutureProvider.autoDispose.family<PersonResponse, String>((ref, timeWindow) {
  return ref.read(trendingRepositoryProvider).getTrendingPeople(timeWindow);
});
