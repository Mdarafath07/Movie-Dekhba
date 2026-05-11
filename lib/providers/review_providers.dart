import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/review_repository.dart';
import '../models/review_model.dart';
import '../core/network/dio_client.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(DioClient());
});

// ---------------------------------------------------------------------------
// Review details — parameterised by review id (String)
// ---------------------------------------------------------------------------

/// Fetches the full details of a single review.
///
/// Usage:
/// ```dart
/// final reviewAsync = ref.watch(reviewDetailProvider('640b2aeecaaca20079decdcc'));
/// ```
final reviewDetailProvider =
    FutureProvider.family<ReviewDetail, String>((ref, reviewId) async {
  return ref.watch(reviewRepositoryProvider).getReviewDetails(reviewId);
});
