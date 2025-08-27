// ignore_for_file: avoid_catches_without_on_clauses, unused_catch_stack
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/shared_components/bubble/bubble.dart';
import 'package:mojadwel_web/core/shared_components/lists/dot_separator.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/dimensions.dart';
import 'package:mojadwel_web/core/utilities/scale.dart';
import 'package:mojadwel_web/core/utilities/wire.dart';

class TestButton extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const TestButton({
    required this.text,
    required this.function,
    this.result,
    this.addNotes,
    this.showsImage = false,
    this.forceOneLiner = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final String text;
  final Function function;
  final Function(dynamic result)? result;
  final List<String>? addNotes;
  final bool showsImage;
  final bool forceOneLiner;
  // -----------------------------------------------------------------------------
  @override
  State<TestButton> createState() => _TestButtonState();
  // -----------------------------------------------------------------------------
}

class _TestButtonState extends State<TestButton> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  bool? _success;
  List<String> _reports = [];
  dynamic _image;
  Dimensions? _imageDims;
  dynamic _theResult;
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _addInitialNotes();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {


        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(TestButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (
        oldWidget.forceOneLiner != widget.forceOneLiner ||
        _Helpers.checkListsAreIdentical(list1: oldWidget.addNotes, list2: widget.addNotes) == false ||
        oldWidget.showsImage != widget.showsImage
    ){
      setState(() {});
    }

    if (
    oldWidget.text != widget.text
    // ||
    // oldWidget.function != widget.function
    ) {
      setState(() {
        _success = null;
      });
    }
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  static const String _startTestText = 'Firing Test . . .';
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onAction() async {

    _report(_startTestText);

    await _triggerLoading(setTo: true);

    await _Helpers.tryAndCatch(
      invoker: 'TestButton : ${widget.text}',
      functions: () async {

        final dynamic _result = await widget.function();

        final bool _expectation = await widget.result?.call(_result);

        if (widget.showsImage == true) {
          _image = _result;
          // blog('TestButton : _image : $_image');
          // _imageDims = await DimensionsGetter.fromDynamic(
          //   object: _result,
          //   invoker: '_onAction',
          //   isVideo: false,
          // );
          // blog('TestButton : _imageDims : $_imageDims');
        }

        setState(() {
          _success = _expectation;
        });

        _report(_Helpers.boolIsTrue(_success) == true ? 'Success' : 'Failure');

        _report('This function returns :-');
        // _report('$_result');

        await _showResult(_result);
      },
      onError: (String? error) async {

        setState(() {
          _success = false;
          _theResult = error;
        });

        if (kDebugMode == false){
          await _Helpers.throwText(
            text: error ?? 'some error',
            invoker: 'TestButton : ${widget.text}',
          );
        }

      },
    );

    await _triggerLoading(setTo: false);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _report(String text) {

    _Helpers.blog(text);

    setState(() {

      _reports = _Helpers.removeStringsFromStrings(
          removeFrom: _reports,
          removeThis: [_startTestText],
      );

      _reports = _Helpers.addStringsToStringsIfDoNotContainThem(
        listToTake: _reports,
        listToAdd: [text],
      );
    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _addInitialNotes(){
    if (_Helpers.checkCanLoop(widget.addNotes) == true){
      _reports = _Helpers.addStringsToStringsIfDoNotContainThem(
        listToTake: _reports,
        listToAdd: widget.addNotes,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _showResult(dynamic result) async {

      if (result is Map){
        _theResult = result;
      }
      // else if (result is XFile){
      //   final XFile file = result;
      //   final int _length = await file.length();
      //   final DateTime _time = await file.lastModified();
      //   final Dimensions? _dims = await file.readDimensions(
      //     isVideo: false,
      //     // bytesIfThere: null,
      //   );
      //   final double? _mb = await file.readSize();
      //   _theResult = {
      //     'path' : file.path,
      //     'name' : file.name,
      //     'length': _length,
      //     'Mb': _mb,
      //     'dimensions': _dims,
      //     'lastModified': _time,
      //   };
      // }
      else if (result is File){
        // final File file = result;
        // final String? _fileName = _Helpers.getNameFromFile(file: file, withExtension: true);
        // final int _length = await file.length();
        // final DateTime _time = await file.lastModified();
        // final Dimensions? _dims = await DimensionsGetter.fromFile(
        //   file: file,
        //   isVideo: false,
        //   bytesIfThere: null,
        // );
        // final double? _mb = _Helpers.getFileSizeInMb(file);
        // _theResult = {
        //   'path' : file.path,
        //   'name' : _fileName,
        //   'length': _length,
        //   'Mb': _mb,
        //   'dimensions': _dims,
        //   'lastModified': _time,
        // };
      }
      else {
        _theResult = result.toString();
      }

      setState(() {});
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Scale.screenWidth(context) - _WideButton.height - 25;
    final double _clearBubbleWidth = _bubbleWidth - 50;
    final double _resultBoxHeight = _theResult == 'true' ? 20 : 150;
    final bool _isMap = _theResult is Map;
    // final bool _isXFile = _theResult is XFile;
    final Color _resultBoxColor = _Helpers.boolIsTrue(_success) == true ? Colorz.green125 : Colorz.black150;

    final bool _showDetails = widget.forceOneLiner == false;

    return ValueListenableBuilder(
      key: ValueKey(widget.text),
      valueListenable: _loading,
      builder: (_, bool loading, Widget? child) {
        return Padding  (
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// CHECK - X
              SuperBox(
                width: _WideButton.height,
                height: _WideButton.height * 0.7,
                loading: loading,
                loadingIsPulse: true,
                icon: _success == null ? Iconz.power : _Helpers.boolIsTrue(_success) == true ? Iconz.check : Iconz.xSmall,
                iconColor: _success == null ? Colorz.white10 : _Helpers.boolIsTrue(_success) == true ? Colorz.green255 : Colorz.bloodTest,
                iconSizeFactor: 0.7,
                color: Colorz.white20,
                bubble: false,
              ),

              /// BUBBLE
              TileBubble(
                bubbleHeaderVM: BubbleHeaderVM(
                  headlineText: widget.text,
                  headlineHeight: 25,
                ),
                bubbleWidth: _bubbleWidth,
                onTileTap: _onAction,
                bubbleColor: _success == false ? Colorz.bloodTest : Colorz.dark1,
                bulletPoints: _showDetails == false ? null : _reports,
                bulletPointsMaxLines: 100,
                textColor: Colorz.black255,
                child: Column(
                  children: <Widget>[

                    /// RESULT TEXT
                    if (_showDetails && _theResult != null && _isMap == false)
                    Container(
                      width: _clearBubbleWidth,
                      height: _resultBoxHeight,
                      decoration: BoxDecoration(
                        color: _resultBoxColor,
                        borderRadius: _Helpers.constantCornersAll5,
                      ),
                      child: ClipRRect(
                        borderRadius: _Helpers.constantCornersAll5,
                        child: VerticalFloatingList(
                          mainAxisAlignment: MainAxisAlignment.start,
                          height: _resultBoxHeight,
                          width: _clearBubbleWidth,
                          boxCorners: _Helpers.constantCornersAll5,
                          columnChildren: <Widget>[

                            SuperText(
                              boxWidth: _clearBubbleWidth,
                              text: _theResult,
                              maxLines: 500,
                              centered: _theResult == 'true',
                              textHeight: 25,

                              // weight: VerseWeight.thin,
                            ),

                            const DotSeparator(
                              color: Colorz.black255,
                            ),

                          ],
                        ),
                      ),
                    ),

                    // /// RESULT MAP
                    // if (_showDetails && _theResult != null && _isMap == true)
                    //   SizedBox(
                    //     width: _clearBubbleWidth,
                    //     height: _resultBoxHeight,
                    //     child: VerticalFloatingList(
                    //       width: _clearBubbleWidth,
                    //       height: _resultBoxHeight,
                    //       boxColor: _resultBoxColor,
                    //       columnChildren: [
                    //
                    //         MapTree(
                    //           width: _clearBubbleWidth,
                    //           map: _theResult as Map<String, dynamic>,
                    //           onExpandableNodeTap: (String path) => KeyboardModel.copyToClipboardAndNotify(
                    //             context: context,
                    //             copy: Pathing.getLastPathNode(path),
                    //           ),
                    //           onLastNodeTap: (String path) => KeyboardModel.copyToClipboardAndNotify(
                    //             context: context,
                    //             copy: MapPathing.getNodeValue(path: path, map: _theResult)?.toString(),
                    //           ),
                    //           selectedPaths: const [],
                    //           initiallyExpanded: true,
                    //           keyWidth: _clearBubbleWidth * 0.5,
                    //           // searchValue: ,
                    //         ),
                    //
                    //       ],
                    //     ),
                    //   ),

                    /// IMAGE
                    if (_showDetails && widget.showsImage == true && _image != null) // && _imageDims != null)
                      SuperBox(
                        width: _clearBubbleWidth,
                        // width: 100, // _imageDims?.width ?? 0,
                        height: 100, // _imageDims?.height ?? 0,
                        icon: _image,
                        text: '${_imageDims?.width} x ${_imageDims?.height}',
                        textCentered: false,
                        iconBackgroundColor: Colorz.white10,
                      ),

                  ],
                ),
              ),

            ],
          ),
        );
      },
    );

  }
  // -----------------------------------------------------------------------------
}

abstract class _Helpers {
  // --------------------
  static const BorderRadius constantCornersAll5 = BorderRadius.all(Radius.circular(5));
  // --------------------
  /// AI TESTED
  static List<String> addStringsToStringsIfDoNotContainThem({
    required List<String>? listToTake,
    required List<String>? listToAdd,
  }){

    List<String> _output = <String>[];

    if (checkCanLoop(listToTake) == true){
      _output = listToTake!;
    }

    if (checkCanLoop(listToAdd) == true){

      for (final String string in listToAdd!){

        _output = addStringToListIfDoesNotContainIt(
            strings: _output,
            stringToAdd: string
        );

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<String> addStringToListIfDoesNotContainIt({
    required List<String>? strings,
    required String? stringToAdd,
  }) {

    List<String> _output = <String>[];

    if (checkCanLoop(strings) == true){
      _output = <String>[...strings!];
    }

    if (stringToAdd != null){

      final bool _containsIt = checkStringsContainString(
        strings: _output,
        string: stringToAdd,
      );

      if (_containsIt == false) {
        _output.add(stringToAdd);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blog(dynamic msg){

    assert((){
      if (kDebugMode) {
        debugPrint(msg?.toString());
      }
      return true;
    }(), '_');

  }
  // --------------------
  /// AI TESTED
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// AI TESTED
  static bool checkListsAreIdentical({
    required List<dynamic>? list1,
    required List<dynamic>? list2
  }) {
    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1 != null && list1.isEmpty == true && list2 != null && list2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (checkCanLoop(list1) == true && checkCanLoop(list2) == true){

      if (list1!.length != list2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( $list1 )');
        // blog(' ---> lis2 is ( $list2 )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          if (list1[i] != list2[i]) {
            // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');

            if (list1[i].toString() == list2[i].toString()){
              // blog('but they are equal when converted to string');
              _listsAreIdentical = true;
            }
            else {
              // blog('and they are not equal when converted to string');
              _listsAreIdentical = false;
              break;
            }

          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool boolIsTrue(dynamic value){
    bool _output = false;

    if (value != null && value is bool){
      _output = value;
    }

    return _output;
  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static Future<void> throwText({
    required String text,
    required String invoker,
  }) async {

    final String _text = '''
Errorized : Invoker : [ $invoker ]
          : text :- 
            $text
    ''';

    await _throwAndCaptureException(_text);

  }
  // ----------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _throwAndCaptureException(String text) async {

    try {
      throw Exception(text);
    }

    on Exception catch (error, stackTrace) {
      // await Sentry.captureException(
      //   error,
      //   stackTrace: stackTrace,
      // );
      blog('_throwAndCaptureException : $error');
    }

  }
  // --------------------
  /// AI TESTED
  static List<String> removeStringsFromStrings({
    required List<String>? removeFrom,
    required List<String>? removeThis,
  }){

    final List<String> _output = <String>[];

    if (checkCanLoop(removeFrom) == true){

      for (final String string in removeFrom!){

        final bool _canRemove = checkStringsContainString(
            strings: removeThis,
            string: string
        );

        if (_canRemove == true){
          // blog('removeStringsFromStrings : removing : $string');
        }
        else {
          _output.add(string);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static bool checkStringsContainString({
    required List<String?>? strings,
    required String? string,
  }) {
    bool _containsIt = false;

    if (checkCanLoop(strings) == true && string != null) {
      _containsIt = strings!.contains(string);
    }

    return _containsIt;
  }
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
  // -----------------------------------------------------------------------------
}

class _WideButton {
  // --------------------------------------------------------------------------
  static const double height = 50;
  // --------------------------------------------------------------------------
}
