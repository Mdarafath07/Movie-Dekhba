import 'package:dio/dio.dart';
import '../api/endpoints.dart';
import '../models/review_model.dart';
import '../core/network/dio_client.dart';

class ReviewRepository {
  final DioClient _dioClient;

  ReviewRepository(this._dioClient);

  // ---------------------------------------------------------------------------
  // Review details — GET /3/review/{review_id}
  // ---------------------------------------------------------------------------

  /// Retrieve the full details of a single review by its string ID.
  ///
  /// [reviewId] is the TMDB review ID (e.g. "640b2aeecaaca20079decdcc").
  Future<ReviewDetail> getReviewDetails(String reviewId) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.reviewDetails(reviewId),
      );
      return ReviewDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load review details: ${e.message}');
    }
  }
}
