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
  static const String logoSvg = 'assets/logo.svg';
  static const String logoPng = 'assets/logo.png';
  static const String paste = 'assets/paste.svg';
  static const String xBig = 'assets/x_big.svg';
  static const String check = 'assets/check.svg';
  static const String star = 'assets/star.svg';
  static const String calendar = 'assets/calendar.svg';
  static const String notification = 'assets/notification.svg';
  static const String sheets = 'assets/sheets.svg';
  static const String whatsapp = 'assets/whatsapp.svg';
  // --------------------
  static const String whatsappColor = 'assets/whatsapp_color.svg';
  static const String googleColor = 'assets/google_color.svg';
  static const String googleSheetsColor = 'assets/sheets_color.svg';
  static const String googleCalendarColor = 'assets/google_calendar_color.svg';
  // --------------------
  static const String menu = 'assets/menu.svg';
  static const String clock = 'assets/clock.svg';
  static const String company = 'assets/company.svg';
  static const String email = 'assets/email.svg';
  static const String facebook = 'assets/facebook.svg';
  static const String instagram = 'assets/instagram.svg';
  static const String user = 'assets/user.svg';
  static const String createAccount = 'assets/create_account.svg';
  static const String viewsIcon = 'assets/views.svg';
  static const String settings = 'assets/settings.svg';
  static const String plan = 'assets/plan.svg';
  static const String brain = 'assets/brain.svg';
  static const String info = 'assets/info.svg';
  static const String scholar = 'assets/scholar.svg';
  // -----------------------------------------------------------------------------
}
