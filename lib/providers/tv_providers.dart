import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/tv_repository.dart';
import '../models/tv_show_model.dart';
import '../models/tv_detail_model.dart';
import '../models/movie_misc_models.dart';
import '../models/tv_aggregate_credits_model.dart';
import '../models/tv_episode_detail_model.dart';

final tvRepositoryProvider = Provider<TvRepository>((ref) {
  return TvRepository();
});

final trendingTvProvider = FutureProvider<List<TvShow>>((ref) async {
  final repository = ref.watch(tvRepositoryProvider);
  return (await repository.getTrendingTv()).results;
});

final popularTvProvider = FutureProvider<List<TvShow>>((ref) async {
  final repository = ref.watch(tvRepositoryProvider);
  return (await repository.getPopularTv()).results;
});

final topRatedTvProvider = FutureProvider<List<TvShow>>((ref) async {
  final repository = ref.watch(tvRepositoryProvider);
  return (await repository.getTopRatedTv()).results;
});

final airingTodayTvProvider = FutureProvider<List<TvShow>>((ref) async {
  final repository = ref.watch(tvRepositoryProvider);
  return (await repository.getAiringTodayTv()).results;
});

final onTheAirTvProvider = FutureProvider<List<TvShow>>((ref) async {
  final repository = ref.watch(tvRepositoryProvider);
  return (await repository.getOnTheAirTv()).results;
});

final tvDetailsProvider = FutureProvider.family<TvDetail, int>((ref, id) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvDetails(id);
});

final tvAccountStatesProvider = FutureProvider.family<AccountState, int>((ref, id) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvAccountStates(id);
});

final tvAggregateCreditsProvider = FutureProvider.family<TvAggregateCreditsResponse, int>((ref, id) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvAggregateCredits(id);
});

final tvSeasonDetailsProvider = FutureProvider.family<TvSeasonDetail, ({int seriesId, int seasonNumber})>((ref, params) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvSeasonDetails(params.seriesId, params.seasonNumber);
});

typedef EpisodeParams = ({int seriesId, int seasonNumber, int episodeNumber});

final tvEpisodeDetailsProvider = FutureProvider.family<TvEpisodeFullDetail, EpisodeParams>((ref, p) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvEpisodeDetails(p.seriesId, p.seasonNumber, p.episodeNumber);
});

final tvEpisodeCreditsProvider = FutureProvider.family<TvEpisodeCredits, EpisodeParams>((ref, p) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvEpisodeCredits(p.seriesId, p.seasonNumber, p.episodeNumber);
});

final tvEpisodeVideosProvider = FutureProvider.family<TvEpisodeVideosResponse, EpisodeParams>((ref, p) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvEpisodeVideos(p.seriesId, p.seasonNumber, p.episodeNumber);
});

final tvEpisodeImagesProvider = FutureProvider.family<TvEpisodeImages, EpisodeParams>((ref, p) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvEpisodeImages(p.seriesId, p.seasonNumber, p.episodeNumber);
});

final tvEpisodeExternalIdsProvider = FutureProvider.family<TvEpisodeExternalIds, EpisodeParams>((ref, p) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvEpisodeExternalIds(p.seriesId, p.seasonNumber, p.episodeNumber);
});

final tvExternalIdsProvider = FutureProvider.family<TvEpisodeExternalIds, int>((ref, id) async {
  final repository = ref.watch(tvRepositoryProvider);
  return repository.getTvExternalIds(id);
});
