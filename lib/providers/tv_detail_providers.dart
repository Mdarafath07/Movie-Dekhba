import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tv_detail_model.dart';
import '../repositories/tv_repository.dart';

final tvRepositoryProvider = Provider<TvRepository>((ref) => TvRepository());

final tvDetailsProvider = FutureProvider.family<TvDetail, int>((ref, tvId) async {
  final repo = ref.watch(tvRepositoryProvider);
  return repo.getTvDetails(tvId);
});

typedef SeasonParams = ({int tvId, int seasonNumber});

final seasonDetailsProvider = FutureProvider.family<TvSeasonDetail, SeasonParams>((ref, params) async {
  final repo = ref.watch(tvRepositoryProvider);
  return repo.getTvSeasonDetails(params.tvId, params.seasonNumber);
});
