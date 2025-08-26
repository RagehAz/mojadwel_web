// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
/// => TAMAM
abstract class Rest {
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response?> postMap({
    required Map<String, dynamic> map,
    required String rawLink,
    Map<String, String>? headers,
    Encoding? encoding,
    String invoker = 'Rest.postMap',
  }) async {

    http.Response? _response;

    await tryAndCatch(
      invoker: 'REST : postMap : $invoker',
      functions: () async {

        /// POST REQUEST
        _response = await http.post(
          Uri.parse(rawLink),
          body: json.encode(map),
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _response;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response?> putBytes({
    required Uint8List? bytes,
    required String? rawLink,
    Map<String, String>? headers,
    Encoding? encoding,
    int timeoutSeconds = 30,
    String invoker = 'Rest.putBytes',
  }) async {
    http.Response? _response;

    if (bytes != null && rawLink != null){

      await tryAndCatch(
        invoker: 'REST : put : $invoker',
        functions: () async {

          /// POST REQUEST
          _response = await http.put(
            Uri.parse(rawLink),
            body: bytes,
            headers: headers,
            encoding: encoding,
          ).timeout(
              Duration(seconds: timeoutSeconds),
              onTimeout: () async {
                blog('Rest.putBytes timeout occurred');
                return http.Response('Rest.putBytes timeout occurred', 408);
              }
          );

        },
      );

    }

    return _response;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response?> get({
    required String rawLink,
    required String invoker,
    Map<String, String>? headers,
    int timeoutSeconds = 30,
  }) async {

    http.Response? _response;

    try {

      /// GET REQUEST
      _response = await http.get(
        Uri.parse(rawLink),
        headers: headers,
      ).timeout(
          Duration(seconds: timeoutSeconds),
          onTimeout: () async {
            blog('Rest.get timeout occurred');
            return http.Response('Rest.get timeout occurred', 408);
          }
      );

      // blog('rest.get : _response : ${_response?.body}');

    }
    on TimeoutException catch (error) {
      blog('Rest.get.TimeoutException : $invoker : error.message : ${error.message}');
    }
    on Exception catch (error) {
      blog('Rest.get.Exception : $invoker : error.message : $error');
    }

    // if (_response != null){
    // final response = await request.close().timeout(const Duration(seconds: 10));
    // }

    return _response;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> readBytes({
    required String rawLink,
    String invoker = '',
    int timeoutSeconds = 30,
    Map<String, String>? headers,
  }) async {
    Uint8List? _uInts;

    await tryAndCatch(
      // context: context,
      invoker: 'REST : get : $invoker',
      functions: () async {

        /// GET REQUEST
        _uInts = await http.readBytes(
          Uri.parse(rawLink),
          headers: headers,
        ).timeout(
            Duration(seconds: timeoutSeconds),
            onTimeout: () async {
              blog('Rest.get timeout occurred');
              return Uint8List(0);
            }
        );

      },
    );

    /// ANOTHER SOLUTION
    /*
    final http.Response? _response = await Rest.get(
      rawLink: rawLink,
      // timeout: 60,
      invoker: 'readBytes',
    );
    if (_response != null && _response.statusCode == 200){
      _uInts = _response.bodyBytes;
    }
     */

    return _uInts;

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response?> patchMap({
    required Map<String, dynamic> input,
    required String rawLink,
    Map<String, String>? headers,
    Encoding? encoding,
    String invoker = '',
  }) async {

    http.Response? _response;

    await tryAndCatch(
      invoker: 'Rest : patch : $invoker',
      functions: () async {

        /// PATCH REQUEST
        _response = await http.patch(
          Uri.parse(rawLink),
          body: json.encode(input),
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _response;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response?> delete({
    required String rawLink,
    Object? body,
    Map<String, String>? headers,
    Encoding? encoding,
    String invoker = '',
  }) async {

    http.Response? _response;

    await tryAndCatch(
      invoker: 'Rest : delete : $invoker',
      functions: () async {

        /// DELETE REQUEST
        _response = await http.delete(
          Uri.parse(rawLink),
          body: body,
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _response;

  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogURI({
    required Uri? uri,
    String invoker = ':',
  }){

    if (uri == null){
      blog('blogURI $invoker : uri is null');
    }
    else {
      blog('blogURI $invoker : uri : $uri');
      blog('blogURI $invoker : uri.toString : $uri');
      blog('blogURI $invoker : uri.path : ${uri.path}');
      blog('blogURI $invoker : uri.hashCode : ${uri.hashCode}');
      blog('blogURI $invoker : uri.data : ${uri.data}');
      blog('blogURI $invoker : uri.queryParameters : ${uri.queryParameters}');
      blog('blogURI $invoker : uri.authority : ${uri.authority}');
      blog('blogURI $invoker : uri.fragment : ${uri.fragment}');
      blog('blogURI $invoker : uri.hasAbsolutePath : ${uri.hasAbsolutePath}');
      blog('blogURI $invoker : uri.hasAuthority : ${uri.hasAuthority}');
      blog('blogURI $invoker : uri.hasEmptyPath : ${uri.hasEmptyPath}');
      blog('blogURI $invoker : uri.hasFragment : ${uri.hasFragment}');
      blog('blogURI $invoker : uri.hasPort : ${uri.hasPort}');
      blog('blogURI $invoker : uri.hasQuery : ${uri.hasQuery}');
      blog('blogURI $invoker : uri.hasScheme : ${uri.hasScheme}');
      blog('blogURI $invoker : uri.query : ${uri.query}');
      blog('blogURI $invoker : uri.host : ${uri.host}');
      blog('blogURI $invoker : uri.isAbsolute : ${uri.isAbsolute}');
      blog('blogURI $invoker : uri.pathSegments : ${uri.pathSegments}');
      blog('blogURI $invoker : uri.port : ${uri.port}');
      blog('blogURI $invoker : uri.scheme : ${uri.scheme}');
      blog('blogURI $invoker : uri.userInfo : ${uri.userInfo}');
      blog('blogURI $invoker : uri.queryParametersAll : ${uri.queryParametersAll}');
      // blog('blogURI $invoker : link.origin : ${uri?.origin}'); // Unhandled Exception: Bad state: Origin is only applicable schemes http and https:
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogResponse({
    required http.Response? response,
    bool blogBody = true,
  }){

    if (response == null){
      blog('blogResponse : response in null');
    }
    else {

      if (blogBody){
        blog('response.body : ${response.body}');
      }
      blog('response.bodyBytes.length : ${response.bodyBytes.length}');
      blog('response.statusCode : ${response.statusCode}');
      blog('response.request : ${response.request}');
      blog('response.headers : ${response.headers}');
      blog('response.isRedirect : ${response.isRedirect}');
      blog('response.persistentConnection : ${response.persistentConnection}');
      blog('response.reasonPhrase : ${response.reasonPhrase}');
      blog('response.contentLength : ${response.contentLength}');

    }

  }
  // -----------------------------------------------------------------------------

  /// ERROR HANDLING

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<http.Response> _checkUpResponse({
    required http.Response response,
    required String invoker,
    Function(http.Response response) onError,
  }) async {

    http.Response _output;

    /// RESPONSE IS NULL
    if (response == null){
      blog('REST : _checkUpResponse : response is null');
    }

    /// RESPONSE RECEIVED
    else {

      if (response.statusCode == 200){
        _output = response;
      }

      else if (response.statusCode >= 400){

        if (onError != null){
          onError(response);
        }

      }

    }

    return _output;
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> _onHttpError({
    required BuildContext context,
    required String error,
    required String invoker,
  }) async {

    blog('onHttpError : $invoker : error : $error');

  }
   */
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///TESTED : WORKS PERFECT
  static bool checkResponseBodyIsGood(http.Response? res){
    return res?.statusCode == 200 && res?.body != null;
  }
  // -----------------------------------------------------------------------------

  /// HELPERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> tryAndCatch({
    required Future<void> Function() functions,
    required String invoker,
    ValueChanged<String>? onError,
    Function? onTimeout,
    int? timeout,
  }) async {

    try {

      ///  WITHOUT TIMEOUT
      if (timeout == null) {
        await functions();
      }

      /// WITH TIMEOUT
      else {
        await functions().timeout(
            Duration(seconds: timeout),
            onTimeout: () async {

              if (onError != null){
                onError('Timeout ( $invoker ) after ( $timeout) seconds');
              }

              onTimeout?.call();

            });
      }


    }
    // on Exception : this does not work on web
    catch (error) {

      if (onError == null){
        blog('$invoker : tryAndCatch ERROR : $error');
      }

      else {
        onError(error.toString());
      }

      // throw(error);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blog(dynamic msg, {String? invoker}){

    assert((){
      if (kDebugMode) {
        debugPrint(msg?.toString());
      }
      return true;
    }(), '_');

  }
  // -----------------------------------------------------------------------------
}
