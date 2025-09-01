import 'package:mojadwel_web/core/shared_components/dialogs/center_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as Launch;

import 'fire/fire.dart';

abstract class URLLaunching {
  // -----------------------------------------------------------------------------

  /// URI

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> launchURI({
    required Uri? uri,
    Launch.LaunchMode launchMode = Launch.LaunchMode.platformDefault,
  }) async {
    bool _success = false;
    bool _retry = true;

    if (uri != null){

      final bool _canLaunch = await Launch.canLaunchUrl(uri);

      if (_canLaunch == true){

        await tryAndCatch(
          invoker: 'launchURI',
          functions: () async {

            _success = await Launch.launchUrl(
              uri,
              mode: launchMode,
              // webOnlyWindowName: ,
              // webViewConfiguration: ,
            );

            if (_success == true){
              _retry = false;
            }

          },
          onError: (String? error) async {

            if (launchMode != Launch.LaunchMode.platformDefault){
              _retry = false;
              _success = await Launch.launchUrl(
                uri,
                // mode: Launch.LaunchMode.platformDefault,
                // webOnlyWindowName: ,
                // webViewConfiguration: ,
              );
            }

          },
        );

        if (_retry == true){
          await tryAndCatch(
            invoker: 'launchURI(retry)',
            functions: () async {
              _success = await Launch.launchUrl(
                uri,
                // mode: Launch.LaunchMode.platformDefault,
                // webOnlyWindowName: ,
                // webViewConfiguration: ,
              );
            },
          );
        }

      }

      else {
        blog('Can Not launch link');
      }

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> launchURL({
    required String? url,
    Launch.LaunchMode launchMode = Launch.LaunchMode.platformDefault,
  }) async {
    bool _success = false;
    if (url != null){
      _success = await launchURI(
        uri: Uri.parse(url),
        launchMode: launchMode,
      );
    }
    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> forceLaunchURI({
    required Uri? uri,
    Launch.LaunchMode launchMode = Launch.LaunchMode.platformDefault,
  }) async {
    bool _success = false;
    // bool _retry = true;

    if (uri != null){

      await tryAndCatch(
        invoker: 'launchURI',
        functions: () async {

          _success = await Launch.launchUrl(
            uri,
            mode: launchMode,
            // webOnlyWindowName: ,
            // webViewConfiguration: ,
          );

          // if (_success == true){
          //   _retry = false;
          // }

        },
        onError: (String? error) async {

          // if (launchMode != Launch.LaunchMode.platformDefault){
          // _retry = false;
          _success = await Launch.launchUrl(
            uri,
            // mode: Launch.LaunchMode.platformDefault,
            // webOnlyWindowName: ,
            // webViewConfiguration: ,
          );
          // }

        },
      );

      // if (_retry == true){
      //   _success = await Launch.launchUrl(
      //     uri,
      //     // mode: Launch.LaunchMode.platformDefault,
      //     // webOnlyWindowName: ,
      //     // webViewConfiguration: ,
      //   );
      // }

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// DIALOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> openURLConfirmationDialog({
    required String? url,
    required bool showDialog,
  }) async {
    bool _go = true;

    if (isEmpty(url) == false && showDialog == true){

      _go = await Dialogs.confirmProceed(
        headlineVerse: 'Open this link ?',
        yesVerse: 'Open',

      );

    }

    return _go;
  }
  // -----------------------------------------------------------------------------
}
