import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
      : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(_handleAuthError(e));
    }
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(_handleAuthError(e));
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        return await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null;

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<String> createGuestSession() async {
    // Note: This requires DioClient, but AuthRepository currently uses FirebaseAuth.
    // For a cleaner architecture, we could pass DioClient to AuthRepository.
    // However, I'll instantiate it here for the guest session.
    try {
      final dio = Dio();
      // Use the API key from Endpoints or DioClient logic.
      // Ideally, use DioClient.
      // Since AuthRepository doesn't have it, I'll fetch it using DioClient instance.
      throw Exception('Guest Session should be implemented in AccountRepository or a dedicated TMDB AuthRepository');
    } catch (e) {
      throw Exception('Failed to create guest session: $e');
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      return 'auth/${error.code}';
    }
    return error.toString();
  }
}
