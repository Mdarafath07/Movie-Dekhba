import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteItem {
  final int id;
  final String title;
  final String? posterPath;
  final String mediaType; // 'movie' or 'tv'
  final double voteAverage;
  final DateTime createdAt;

  FavoriteItem({
    required this.id,
    required this.title,
    this.posterPath,
    required this.mediaType,
    required this.voteAverage,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'mediaType': mediaType,
      'voteAverage': voteAverage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String toJson() => toMap().toString(); // Basic for now, but I'll use jsonEncode later.

  Map<String, dynamic> toJsonMap() => toMap();

  factory FavoriteItem.fromJsonMap(Map<String, dynamic> map) => FavoriteItem.fromMap(map);

  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      mediaType: map['mediaType'],
      voteAverage: (map['voteAverage'] as num).toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

class FirestoreRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirestoreRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  CollectionReference get _favoritesRef {
    if (_uid == null) throw Exception('User not logged in');
    return _firestore.collection('users').doc(_uid).collection('favorites');
  }

  CollectionReference get _watchlistRef {
    if (_uid == null) throw Exception('User not logged in');
    return _firestore.collection('users').doc(_uid).collection('watchlist');
  }

  DocumentReference get _settingsRef {
    if (_uid == null) throw Exception('User not logged in');
    return _firestore.collection('users').doc(_uid);
  }

  // --- Favorites ---
  Future<void> toggleFavorite(FavoriteItem item) async {
    final doc = _favoritesRef.doc(item.id.toString());
    final snapshot = await doc.get();

    if (snapshot.exists) {
      await doc.delete();
    } else {
      await doc.set(item.toMap());
    }
  }

  Stream<bool> isFavorite(int id) {
    if (_uid == null) return Stream.value(false);
    return _favoritesRef.doc(id.toString()).snapshots().map((doc) => doc.exists);
  }

  Stream<List<FavoriteItem>> getFavorites() {
    if (_uid == null) return Stream.value([]);
    return _favoritesRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FavoriteItem.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // --- Watchlist ---
  Future<void> toggleWatchlist(FavoriteItem item) async {
    final doc = _watchlistRef.doc(item.id.toString());
    final snapshot = await doc.get();

    if (snapshot.exists) {
      await doc.delete();
    } else {
      await doc.set(item.toMap());
    }
  }

  Stream<bool> isWatchlisted(int id) {
    if (_uid == null) return Stream.value(false);
    return _watchlistRef.doc(id.toString()).snapshots().map((doc) => doc.exists);
  }

  Stream<List<FavoriteItem>> getWatchlist() {
    if (_uid == null) return Stream.value([]);
    return _watchlistRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FavoriteItem.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // --- Settings ---
  Future<void> updateSetting(String key, dynamic value) async {
    await _settingsRef.set({key: value}, SetOptions(merge: true));
  }

  Stream<Map<String, dynamic>> getSettings() {
    if (_uid == null) return Stream.value({});
    return _settingsRef.snapshots().map((doc) => (doc.data() as Map<String, dynamic>?) ?? {});
  }
}
