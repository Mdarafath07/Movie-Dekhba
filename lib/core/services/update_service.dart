import 'package:cloud_firestore/cloud_firestore.dart';

class AppUpdateInfo {
  final String latestVersion;
  final String updateLink;
  final bool isForced;
  final List<String> newFeatures;

  AppUpdateInfo({
    required this.latestVersion,
    required this.updateLink,
    required this.isForced,
    required this.newFeatures,
  });

  factory AppUpdateInfo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final featuresRaw = data['new_features'];
    List<String> features = [];
    if (featuresRaw is List) {
      features = featuresRaw.map((e) => e.toString()).toList();
    } else if (featuresRaw is String && featuresRaw.isNotEmpty) {
      features = featuresRaw.split('\n').where((s) => s.trim().isNotEmpty).toList();
    }
    
    return AppUpdateInfo(
      latestVersion: data['latest_version'] ?? '1.0.0',
      updateLink: data['update_link'] ?? '',
      isForced: data['is_forced'] ?? true,
      newFeatures: features,
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






