import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/person_repository.dart';
import '../models/person_model.dart';
import '../models/person_detail_model.dart';
import '../models/person_combined_credits_model.dart';
import '../models/person_external_ids_model.dart';
import '../models/person_images_model.dart';
import '../models/person_movie_credits_model.dart';
import '../models/person_tv_credits_model.dart';
import '../models/person_tagged_images_model.dart';
import '../models/person_translations_model.dart';
import '../models/change_model.dart';

// ---------------------------------------------------------------------------
// Repository
// ---------------------------------------------------------------------------

final personRepositoryProvider = Provider<PersonRepository>(
  (ref) => PersonRepository(),
);

// ---------------------------------------------------------------------------
// Popular people
// ---------------------------------------------------------------------------

final popularPeopleProvider = FutureProvider<List<Person>>((ref) async {
  return ref.watch(personRepositoryProvider).getPopularPeople();
});

// ---------------------------------------------------------------------------
// Latest person  (live — changes continuously)
// ---------------------------------------------------------------------------

final latestPersonProvider = FutureProvider<PersonDetail>((ref) async {
  return ref.watch(personRepositoryProvider).getLatestPerson();
});

// ---------------------------------------------------------------------------
// Person details  — parameterised by person id
// ---------------------------------------------------------------------------

final personDetailsProvider =
    FutureProvider.family<PersonDetail, int>((ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonDetails(personId);
});

// ---------------------------------------------------------------------------
// Person changes  — parameterised by person id
// ---------------------------------------------------------------------------

final personChangesProvider =
    FutureProvider.family<ChangesResponse, int>((ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonChanges(personId);
});

// ---------------------------------------------------------------------------
// External IDs  — parameterised by person id
// ---------------------------------------------------------------------------

final personExternalIdsProvider =
    FutureProvider.family<PersonExternalIds, int>((ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonExternalIds(personId);
});

// ---------------------------------------------------------------------------
// Profile images  — parameterised by person id
// ---------------------------------------------------------------------------

final personImagesProvider =
    FutureProvider.family<PersonImages, int>((ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonImages(personId);
});

// ---------------------------------------------------------------------------
// Movie credits  — parameterised by person id
// ---------------------------------------------------------------------------

final personMovieCreditsProvider =
    FutureProvider.family<PersonMovieCreditsResponse, int>((ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonMovieCredits(personId);
});

// ---------------------------------------------------------------------------
// Combined credits  — parameterised by person id
// ---------------------------------------------------------------------------

final personCombinedCreditsProvider =
    FutureProvider.family<CombinedCreditsResponse, int>((ref, personId) async {
  return ref.watch(personRepositoryProvider).getCombinedCredits(personId);
});

// ---------------------------------------------------------------------------
// TV credits  — parameterised by person id
// ---------------------------------------------------------------------------

final personTvCreditsProvider =
    FutureProvider.family<PersonTvCreditsResponse, int>((ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonTvCredits(personId);
});

// ---------------------------------------------------------------------------
// Tagged images  — parameterised by person id
// ---------------------------------------------------------------------------

final personTaggedImagesProvider =
    FutureProvider.family<PersonTaggedImagesResponse, int>(
        (ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonTaggedImages(personId);
});

// ---------------------------------------------------------------------------
// Translations  — parameterised by person id
// ---------------------------------------------------------------------------

final personTranslationsProvider =
    FutureProvider.family<PersonTranslationsResponse, int>(
        (ref, personId) async {
  return ref.watch(personRepositoryProvider).getPersonTranslations(personId);
});

// ---------------------------------------------------------------------------
// Search
// ---------------------------------------------------------------------------

final searchPersonQueryProvider = StateProvider<String>((ref) => '');

final searchPersonProvider = FutureProvider<List<Person>>((ref) async {
  final query = ref.watch(searchPersonQueryProvider);
  if (query.trim().isEmpty) return [];
  return ref.watch(personRepositoryProvider).searchPerson(query);
});
