import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/search_repository.dart';
import '../models/collection_model.dart';
import '../models/company_model.dart';
import '../models/keyword_model.dart';
import '../models/movie_response.dart';
import '../models/person_model.dart';
import '../models/search_multi_model.dart';
import '../models/tv_show_model.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository();
});

// ---------------------------------------------------------------------------
// Shared search query
// UI writes: ref.read(searchTextProvider.notifier).state = 'avengers';
// Providers read: ref.watch(searchTextProvider)
// ---------------------------------------------------------------------------

final searchTextProvider = StateProvider<String>((ref) => '');

// ---------------------------------------------------------------------------
// Collection  — /search/collection
// ---------------------------------------------------------------------------

final searchCollectionsProvider =
    FutureProvider.autoDispose<SearchCollectionResponse>((ref) async {
  final query = ref.watch(searchTextProvider);
  if (query.trim().isEmpty) {
    return SearchCollectionResponse(
        page: 0, results: [], totalPages: 0, totalResults: 0);
  }
  return ref.read(searchRepositoryProvider).searchCollections(query);
});

// ---------------------------------------------------------------------------
// Company  — /search/company
// ---------------------------------------------------------------------------

final searchCompaniesProvider =
    FutureProvider.autoDispose<SearchCompanyResponse>((ref) async {
  final query = ref.watch(searchTextProvider);
  if (query.trim().isEmpty) {
    return SearchCompanyResponse(
        page: 0, results: [], totalPages: 0, totalResults: 0);
  }
  return ref.read(searchRepositoryProvider).searchCompanies(query);
});

// ---------------------------------------------------------------------------
// Keyword  — /search/keyword
// ---------------------------------------------------------------------------

final searchKeywordsProvider =
    FutureProvider.autoDispose<SearchKeywordResponse>((ref) async {
  final query = ref.watch(searchTextProvider);
  if (query.trim().isEmpty) {
    return SearchKeywordResponse(
        page: 0, results: [], totalPages: 0, totalResults: 0);
  }
  return ref.read(searchRepositoryProvider).searchKeywords(query);
});

// ---------------------------------------------------------------------------
// Movie  — /search/movie  (full paginated response)
// ---------------------------------------------------------------------------

final searchMoviesResultProvider =
    FutureProvider.autoDispose<MovieResponse>((ref) async {
  final query = ref.watch(searchTextProvider);
  if (query.trim().isEmpty) {
    return MovieResponse(page: 0, results: [], totalPages: 0, totalResults: 0);
  }
  return ref.read(searchRepositoryProvider).searchMovies(query);
});

// ---------------------------------------------------------------------------
// Multi  — /search/multi
// ---------------------------------------------------------------------------

final searchMultiProvider =
    FutureProvider.autoDispose<MultiSearchResponse>((ref) async {
  final query = ref.watch(searchTextProvider);
  if (query.trim().isEmpty) {
    return MultiSearchResponse(
        page: 0, results: [], totalPages: 0, totalResults: 0);
  }
  return ref.read(searchRepositoryProvider).searchMulti(query);
});

// ---------------------------------------------------------------------------
// Person  — /search/person  (full paginated response)
// ---------------------------------------------------------------------------

final searchPeopleProvider =
    FutureProvider.autoDispose<PersonResponse>((ref) async {
  final query = ref.watch(searchTextProvider);
  if (query.trim().isEmpty) {
    return PersonResponse(page: 0, results: [], totalPages: 0, totalResults: 0);
  }
  return ref.read(searchRepositoryProvider).searchPeople(query);
});

// ---------------------------------------------------------------------------
// TV  — /search/tv  (full paginated response)
// ---------------------------------------------------------------------------

final searchTvResultProvider =
    FutureProvider.autoDispose<TvShowResponse>((ref) async {
  final query = ref.watch(searchTextProvider);
  if (query.trim().isEmpty) {
    return TvShowResponse(
        page: 0, results: [], totalPages: 0, totalResults: 0);
  }
  return ref.read(searchRepositoryProvider).searchTv(query);
});
