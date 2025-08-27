import 'package:flutter/services.dart';

abstract class Iconz {
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkAssetExists(String? bldrsThemeAsset) async {
    bool _exists = false;

    /// This method should check if bldrs_theme asset exists or not
    /// and to be called from the project that depends on bldrs_theme
    if (bldrsThemeAsset != null) {
      await rootBundle.load(bldrsThemeAsset).then((_) {
        _exists = true;
      }).catchError((error) {
        _exists = false;
      });
    }

    return _exists;
  }
  // --------------------
  /// artworks
  // static const String logoSvg = 'assets/logo.svg';
  static const String logoPng = 'assets/logo.png';
  static const String power = 'assets/logo.png';
  static const String check = 'assets/logo.png';
  static const String xSmall = 'assets/logo.png';
  static const String more = 'assets/logo.png';
  static const String viewsIcon = 'assets/logo.png';
  static const String paste = 'assets/logo.png';
  // -----------------------------------------------------------------------------
}
