import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/firestore_repository.dart';

final firestoreRepositoryProvider = Provider((ref) => FirestoreRepository());

// --- Favorites Providers ---
final favoritesStreamProvider = StreamProvider<List<FavoriteItem>>((ref) {
  return ref.watch(firestoreRepositoryProvider).getFavorites();
});

final isFavoriteProvider = StreamProvider.family<bool, int>((ref, id) {
  return ref.watch(firestoreRepositoryProvider).isFavorite(id);
});

// --- Watchlist Providers ---
final watchlistStreamProvider = StreamProvider<List<FavoriteItem>>((ref) {
  return ref.watch(firestoreRepositoryProvider).getWatchlist();
});

final isWatchlistedProvider = StreamProvider.family<bool, int>((ref, id) {
  return ref.watch(firestoreRepositoryProvider).isWatchlisted(id);
});

// --- Settings Providers ---
final userSettingsProvider = StreamProvider<Map<String, dynamic>>((ref) {
  return ref.watch(firestoreRepositoryProvider).getSettings();
});
