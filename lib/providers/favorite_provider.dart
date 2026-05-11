import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/firestore_repository.dart';

final firestoreRepositoryProvider = Provider((ref) => FirestoreRepository());

final favoritesStreamProvider = StreamProvider<List<FavoriteItem>>((ref) {
  return ref.watch(firestoreRepositoryProvider).getFavorites();
});

final isFavoriteProvider = StreamProvider.family<bool, int>((ref, id) {
  return ref.watch(firestoreRepositoryProvider).isFavorite(id);
});
