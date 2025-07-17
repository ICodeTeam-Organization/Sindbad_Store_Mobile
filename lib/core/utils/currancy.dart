import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/utils/key_name.dart';

class Currancy {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<String> getCountry() async {
    return await storage.read(key: KeyName.country) ?? '1';
  }

// If you must have a synchronous method, you need to store the currency value in memory
// after fetching it asynchronously at app startup, then return it synchronously.
// Example:
  static String? _cachedCurrency;

  static Future<void> initCurrency() async {
    switch (await Currancy.getCountry()) {
      case '1':
        _cachedCurrency = 'ر.س';
        break;
      case '2':
        _cachedCurrency = 'د.ا';
        break;
      default:
        _cachedCurrency = 'ر.س';
    }
  }

  static String get currency {
    return _cachedCurrency ?? 'ر.س';
  }
}
