import 'package:cloud_firestore/cloud_firestore.dart';

class AppUpdateInfo {
  final String latestVersion;
  final String updateLink;
  final bool isForced;

  AppUpdateInfo({
    required this.latestVersion,
    required this.updateLink,
    required this.isForced,
  });

  factory AppUpdateInfo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return AppUpdateInfo(
      latestVersion: data['latest_version'] ?? '1.0.0',
      updateLink: data['update_link'] ?? '',
      isForced: data['is_forced'] ?? true,
    );
  }
}

class UpdateService {
  static const String currentVersion = '1.0.0'; // Manually update this before releasing new versions

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUpdateInfo?> checkUpdate() async {
    try {
      final doc = await _firestore.collection('app_config').doc('settings').get();
      if (doc.exists) {
        return AppUpdateInfo.fromFirestore(doc);
      }
    } catch (e) {
      print('Update check error: $e');
    }
    return null;
  }
}






