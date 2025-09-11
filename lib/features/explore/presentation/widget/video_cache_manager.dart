import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoCacheManager {
  static const key = "videoCache";

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7), // cache expires after 7 days
      maxNrOfCacheObjects: 50, // max 50 videos stored
    ),
  );

  static Future<void> clearCache() async {
    await instance.emptyCache();
  }
}
