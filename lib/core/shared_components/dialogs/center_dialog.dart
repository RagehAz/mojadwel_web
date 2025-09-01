// ignore_for_file: unused_element_parameter
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/core/shared_components/bubble/bubble.dart';
import 'package:mojadwel_web/core/shared_components/lists/separator_line.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/shared_components/widget_fader/widget_fader.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

// --------------------------------------------------------------------------

abstract class Dialogs {
  // -----------------------------------------------------------------------------

  /// CLOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeDialog() async {
    await Routing.goBack(
      context: getTheMainContext(),
      invoker: 'closeDialog',
      // addPostFrameCallback: true,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showSuccessDialog({
    String? firstLine,
    String? secondLine,
  }) async {

    await TopDialog.showTopDialog(
      headlineVerse: firstLine ?? 'Success',
      bodyVerse: secondLine,
      color: Colorz.green255,
      // textColor: Colorz.white255,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> stateDialog({
    required bool state,
    String? successVerse,
    String? failVerse,
    String? body,
  }) async {

    final String _success = successVerse ?? 'Success';
    final String _fail = failVerse ?? 'Failure';

    await TopDialog.showTopDialog(
      headlineVerse: state == true ? _success : _fail,
      bodyVerse: body,
      color: state == true ? Colorz.green255 : Colorz.bloodTest,
      // textColor: Colorz.white255,
    );

  }
  // -----------------------------------------------------------------------------

  /// NOTICE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> topNotice({
    required String? headlineVerse,
    Color? color,
    Color? textColor,
    int? milliseconds,
    String? bodyVerse,
  }) async {

    await TopDialog.showTopDialog(
      headlineVerse: headlineVerse,
      color: color ?? Colorz.black50,
      milliseconds: milliseconds,
      bodyVerse: bodyVerse,
      // textColor: Colorz.white255,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> centerNotice({
    required String? headlineVerse,
    String? bodyVerse,
    Color color = Colorz.white50,
    Widget? child,
    String? confirmVerse,
  }) async {

    await CenterDialog.showCenterDialog(
      context: getTheMainContext(),
      headlineVerse: headlineVerse,
      color: color,
      bodyVerse: bodyVerse,
      // boolDialog: false,
      confirmButtonVerse: confirmVerse,
      child: child,
    );

  }
  /// TESTED : WORKS PERFECT
  static void badConnection() {
    asyncInSync(() async {
      await topNotice(
        headlineVerse: 'Something went wrong',
        bodyVerse: 'Check your internet connection',
      );
    });
  }
  // -----------------------------------------------------------------------------

  /// CONFIRMATION DIALOGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> confirmProceed({
    String? headlineVerse,
    String? bodyVerse,
    bool invertButtons = false,
    String? noVerse,
    String? yesVerse,
    Widget? child,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: getTheMainContext(),
      headlineVerse: headlineVerse ?? 'Proceed ?',
      bodyVerse: bodyVerse,
      boolDialog: true,
      invertButtons: invertButtons,
      noVerse: noVerse,
      confirmButtonVerse: yesVerse,
      child: child,
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> goBackDialog({
    String? headlineVerse,
    String? bodyVerse,
    String? confirmButtonVerse,
    bool goBackOnConfirm = false,
  }) async {

    final bool _result = await CenterDialog.showCenterDialog(
      context: getTheMainContext(),
      invertButtons: true,
      headlineVerse: headlineVerse ?? 'Go back ?',
      bodyVerse: bodyVerse,
      boolDialog: true,
      confirmButtonVerse: confirmButtonVerse ?? 'Go back',
    );

    if (goBackOnConfirm == true && _result == true){
      await Routing.goBack(
        context: getTheMainContext(),
        invoker: 'goBackDialog : $headlineVerse',
      );
    }

    return _result;

  }
  // -----------------------------------------------------------------------------

  /// ERRORS DIALOGS


  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> tryAgainDialog() async {

    await CenterDialog.showCenterDialog(
      context: getTheMainContext(),
      headlineVerse: 'Something went wrong',
      bodyVerse: 'Please try again',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> errorDialog({
    String? headlineVerse,
    String? bodyVerse,
  }) async {

    await CenterDialog.showCenterDialog(
      context: getTheMainContext(),
      headlineVerse: headlineVerse ?? 'Something went wrong',
      bodyVerse: bodyVerse,
      color: Colorz.googleRed,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool?> paragraphDialog({
    required String paragraph,
    bool paragraphCentered = true,
    String? title,
    String? body,
    bool invertButtons = false,
    bool boolDialog = true,
    String? confirmButtonVerse,
    String? noVerse,
  }) async {

    final BuildContext context = getTheMainContext();
    final double _dialogWidth = CenterDialog.clearWidth(context);
    const double _margin = 10;
    final double _paragraphWidth = _dialogWidth - (_margin * 2);

    return CenterDialog.showCenterDialog(
      context: getTheMainContext(),
      headlineVerse: title,
      bodyVerse: body,
      confirmButtonVerse: confirmButtonVerse,
      invertButtons: invertButtons,
      boolDialog: boolDialog,
      noVerse: noVerse,
      // bodyCentered: true,
      height: context.screenHeight * 0.8,
      child: Center(
        child: SuperText(
          margins: const EdgeInsets.symmetric(
            vertical: _margin,
          ),
          boxWidth: _paragraphWidth,
          text: paragraph,
          maxLines: 1000,
          // weight: VerseWeight.regular,
          // appIsLTR: UiProvider.checkAppIsLeftToRight(),
          // textDirection: UiProvider.getAppTextDir(),
          centered: paragraphCentered,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}

// --------------------------------------------------------------------------

///
// class CenterDialog extends StatelessWidget {
//   // --------------------------------------------------------------------------
//   const CenterDialog({
//     required this.bubble,
//     required this.backgroundColor,
//     super.key
//   });
//   final Widget bubble;
//   final Color? backgroundColor;
//   // -----------------------------------------------------------------------------
//
//   /// SIZES
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static double getWidth(BuildContext context) {
//     return Scale.screenShortestSide(context) * 0.85;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static double clearWidth(BuildContext context){
//     return getWidth(context) - (2 * 10);
//   }
//   // --------------------
//   static const double dialogCornerValue = 20;
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static BorderRadius dialogBorders() {
//     return _Borderers.cornerAll(dialogCornerValue);
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static double getHeight({
//     required BuildContext context,
//     double? heightOverride,
//   }) {
//     final double _screenHeight = Scale.screenHeight(context);
//     final double _height = heightOverride ?? _screenHeight * 0.4;
//     return _height;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// COLORS
//
//   // --------------------
//   static const Color activeButtonColor = Colorz.black255;
//   static const Color defaultButtonColor = Colorz.white50;
//   // -----------------------------------------------------------------------------
//
//   /// LAUNCHERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> showCenterDialog({
//     required BuildContext context,
//     required Widget bubble,
//     Function(BuildContext ctx)? onDialogContextCreated,
//     Color? backgroundColor,
//   }) async {
//
//     final bool? _result = await showDialog(
//       context: context,
//       builder: (BuildContext ctx){
//
//         if (onDialogContextCreated != null) {
//           onDialogContextCreated(ctx);
//         }
//
//         return CenterDialog(
//           backgroundColor: backgroundColor,
//           bubble: bubble,
//         );
//       },
//     );
//
//     return _Booler.boolIsTrue(_result);
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> closeCenterDialog(BuildContext dialogContext) async {
//
//     await Future.delayed(Duration.zero, (){
//       Navigator.pop(dialogContext);
//     });
//
//   }
//   // --------------------
//   /*
// //   static double dialogVerticalMargin({BuildContext context, double dialogHeight}){
// //     double _screenHeight = Scale.superScreenHeight(context);
// //     return (_screenHeight - dialogHeight) / 2;
// //   }
// // // -----------------------------------------------------------------------------
// //   static double dialogHorizontalMargin({BuildContext context, double dialogWidth}){
// //     double _screenWidth = Scale.superScreenWidth(context);
// //     return (_screenWidth - dialogWidth) / 2;
// //   }
//    */
//   // -----------------------------------------------------------------------------
//
//   /// BUTTONS
//
//   // --------------------
//   ///
//   static Widget yesNoButtons({
//     required BuildContext context,
//     String? textFont,
//     bool appIsLTR = true,
//     TextDirection textDirection = TextDirection.ltr,
//     Function? onOk,
//     String yesText = 'yes',
//     String noText = 'no',
//     bool boolDialog = false,
//     bool invertButtons = false,
//     Color activeButtonColor = Colorz.black255,
//     Color defaultButtonColor = Colorz.white50,
//     Color activeTextColor = Colorz.white255,
//     Color defaultTextColor = Colorz.black255,
//   }){
//     // --------------------
//     final double _dialogWidth = getWidth(context);
//     const double _buttonHeight = _DialogButton.height;
//     const double _buttonZoneHeight = _buttonHeight + (2 * 5);
//
//     final Color _activeButtonColor = activeButtonColor;
//     final Color _defaultButtonColor = defaultButtonColor;
//     // --------------------
//     return SizedBox(
//       width: _dialogWidth,
//       height: _buttonZoneHeight,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//
//           /// NO BUTTON
//           if (boolDialog == true && invertButtons == false)
//             _DialogButton(
//               text: noText,
//               color: _defaultButtonColor,
//               textColor: defaultTextColor,
//               onTap: () => Routing.goBack(
//                 context: context,
//                 invoker: 'CenterDialog.No',
//                 passedData: false,
//               ),
//               font: textFont,
//               appIsLTR: appIsLTR,
//               textDirection: textDirection,
//
//             ),
//
//           /// YES BUTTON
//           _DialogButton(
//             text: yesText,
//             textColor: invertButtons == true ? defaultTextColor : activeTextColor,
//             font: textFont,
//             textDirection: textDirection,
//             appIsLTR: appIsLTR,
//             color: invertButtons == true ? _defaultButtonColor : _activeButtonColor,
//             onTap: () async {
//
//               if (boolDialog == true){
//                 await Routing.goBack(
//                   context: context,
//                   invoker: 'CenterDialog.yes',
//                   passedData: true,
//                   addPostFrameCallback: true,
//                 );
//               }
//
//               else {
//                 if (onOk != null){
//                   onOk();
//                 }
//                 else {
//                   await Routing.goBack(
//                     context: context,
//                     invoker: 'CenterDialog.ok',
//                     addPostFrameCallback: true,
//                   );
//                 }
//
//               }
//
//             },
//           ),
//
//           /// NO BUTTON
//           if (boolDialog == true && invertButtons == true)
//             _DialogButton(
//               text: noText,
//               appIsLTR: appIsLTR,
//               textDirection: textDirection,
//               font: textFont,
//               textColor: activeTextColor,
//               color: _activeButtonColor,
//               onTap: () => Routing.goBack(
//                 context: context,
//                 invoker: 'CenterDialog.No',
//                 passedData: false,
//                 addPostFrameCallback: true,
//               ),
//             ),
//
//         ],
//       ),
//     );
//     // --------------------
//   }
//   // --------------------
//   ///
//   static Widget buildBubble({
//     required BuildContext context,
//     required bool? boolDialog,
//     Widget? buttons,
//     double? height,
//     BorderRadius? borders,
//     bool appIsLTR = true,
//     TextDirection textDirection = TextDirection.ltr,
//     Function? onTap,
//     Color boxColor = Colorz.white255,
//     String? title,
//     Color titleColor = Colorz.black255,
//     String? titleFont,
//     double titleTextHeight = 25,
//     String? body,
//     String? bodyFont,
//     Color bodyColor = Colorz.black255,
//     bool bodyCentered = true,
//     double bodyTextHeight = 20,
//     Widget? child,
//   }){
//
//     // --------------------
//     final BorderRadius _dialogBorders = borders ?? dialogBorders();
//     // --------------------
//     final double _dialogHeight = getHeight(
//       context: context,
//       heightOverride: height,
//     );
//     // --------------------
//     final double _dialogWidth = getWidth(context);
//     // --------------------
//
//     return GestureDetector(
//       onTap: () async {
//         if (onTap != null) {
//           onTap();
//         }
//         /// TO CLOSE OPEN KEYBOARD
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Container(
//         width: _dialogWidth,
//         // height: _dialogHeight,
//         constraints: BoxConstraints(
//           minHeight: _dialogHeight,
//         ),
//         decoration: BoxDecoration(
//           color: boxColor,
//           // boxShadow: Shadower.appBarShadow,
//           borderRadius: _dialogBorders,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//
//             /// TITLE
//             if (title != null)
//               Container(
//                 width: _dialogWidth,
//                 alignment: Alignment.center,
//                 // color: Colorz.BloodTest,
//                 child: SuperText(
//                   boxWidth: _dialogWidth * 0.9,
//                   text: title,
//                   textColor: titleColor,
//                   // shadows: true,
//                   textHeight: titleTextHeight,
//                   italic: true,
//                   maxLines: 2,
//                   // labelColor: Colorz.Yellow,
//                   margins: const EdgeInsets.only(
//                     top: 20,
//                     bottom: 5,
//                     left: 10,
//                     right: 10,
//                   ),
//                   appIsLTR: appIsLTR,
//                   textDirection: textDirection,
//                   font: titleFont,
//                 ),
//               ),
//
//             /// BODY
//             if (_TextCheck.isEmpty(body) == false)
//               SizedBox(
//                 width: _dialogWidth,
//                 // height: _bodyZoneHeight,
//                 child: SuperText(
//                   boxWidth: _dialogWidth * 0.9,
//                   text: body,
//                   textHeight: bodyTextHeight,
//                   maxLines: 20,
//                   margins: const EdgeInsets.symmetric(
//                     vertical: 5,
//                     horizontal: 10 * 2,
//                   ),
//                   centered: bodyCentered,
//                   font: bodyFont,
//                   appIsLTR: appIsLTR,
//                   textDirection: textDirection,
//                   textColor: bodyColor,
//                 ),
//               ),
//
//             /// CHILD
//             if (child != null)
//               Column(
//                 children: <Widget>[
//
//                   SeparatorLine(
//                     width: _dialogWidth,
//                   ),
//
//                   Container(
//                     width: _dialogWidth,
//                     constraints: BoxConstraints(
//                       maxHeight: _dialogHeight * 0.6,
//                     ),
//                     child:
//                     SingleChildScrollView(physics: const BouncingScrollPhysics(), child: child),
//                   ),
//
//                   SeparatorLine(
//                     width: _dialogWidth,
//                   ),
//
//                 ],
//               ),
//
//             /// BUTTONS
//             if (boolDialog != null && buttons != null)
//               buttons,
//
//           ],
//         ),
//       ),
//     );
//   }
//   // -----------------------------------------------------------------------------
//
//   /// DIALOG BUBBLE + CONTENTS
//
//   // --------------------
//   Widget buildDialogScreenTree({
//     required BuildContext context,
//   }){
//
//     // --------------------
//     // final double _screenWidth = Scale.screenWidth(context);
//     // final double _screenHeight = Scale.screenHeight(context);
//     // --------------------
//
//     return SingleChildScrollView(
//       physics: const NeverScrollableScrollPhysics(),
//       child: GestureDetector(
//         onTap: () async {
//           await Routing.goBack(
//             context: context,
//             invoker: 'CenterDialog tapping outside the dialog',
//           );
//         },
//         child: bubble,
//       ),
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     return Popper(
//       key: const ValueKey<String>('Center_dialog'),
//       canGoBack: false,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: backgroundColor ?? Colorz.black80,
//           resizeToAvoidBottomInset: true,
//           body: AlertDialog(
//             backgroundColor: Colorz.nothing,
//             // shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
//             contentPadding: EdgeInsets.zero,
//             elevation: 10,
//             insetPadding: EdgeInsets.zero,
//             content: Builder(
//               builder: (BuildContext xxx) {
//
//                 return WidgetFader(
//                   fadeType: FadeType.fadeIn,
//                   min: 0.7,
//                   duration: const Duration(milliseconds: 150),
//                   curve: Curves.easeInOutCirc,
//                   builder: (double value, Widget? child){
//
//                     return Opacity(
//                       opacity: value,
//                       child: Transform.scale(
//                         scale: value,
//                         child: child,
//                       ),
//                     );
//
//                   },
//                   child: buildDialogScreenTree(context: context),
//                 );
//
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//     // --------------------
//   }
// // --------------------
// }
///

class TopDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TopDialog({
    required this.verse,
    required this.onTap,
    // required this.duration,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String verse;
  final Function(Flushbar<dynamic> flush)? onTap;
  // final int duration;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  // static Future<void> closeTopDialog() async {
  //
  //   final GlobalKey? _key = UiPro.proGetTopDialogKey();
  //
  //   final Flushbar? _flushbar = _key?.currentWidget as Flushbar?;
  //
  //   if (_flushbar?.isDismissed() == false){
  //
  //     SchedulerBinding.instance.addPostFrameCallback((_) async {
  //       // blog('''
  //       // closeTopDialog :
  //       //  _flushbar : $_flushbar
  //       //   isDismissible : ${_flushbar.isDismissible}
  //       //   isDismissed() : ${_flushbar.isDismissed()}
  //       //   message : ${_flushbar.message}
  //       //   dismissDirection : ${_flushbar.dismissDirection}
  //       //   flushbarRoute : ${_flushbar.flushbarRoute}
  //       //   userInputForm : ${_flushbar.userInputForm}
  //       //   key : ${_flushbar.key}
  //       //   isAppearing() : ${_flushbar.isAppearing()}
  //       //   isHiding() : ${_flushbar.isHiding()}
  //       //   isShowing() : ${_flushbar.isShowing()}
  //       // ''');
  //       final dynamic previousDialogDismissed = await _flushbar?.dismiss();
  //       blog('closeTopDialog : previousDialogDismissed ${previousDialogDismissed.runtimeType} : $previousDialogDismissed');
  //     });
  //
  //   }
  //
  // }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showTopDialog({
    required String? headlineVerse,
    String? bodyVerse,
    Color color = Colorz.black255,
    Color textColor = Colorz.white255,
    Function? onTap,
    int? milliseconds = 5000,
    bool isTop = true,
  }) async {

    final BuildContext context = getTheMainContext();
    final double _screenWidth = context.screenWidth;
    final double _bubbleWidth = _BldrsAppBar.width(context);

    // final GlobalKey _key = UiProvider.proGetTopDialogKey(context: getMainContext(), listen: false,);
    // final Flushbar _flushbar = _key?.currentWidget;
    // final dynamic _previousDialogDismissed = await _flushbar?.dismiss();
    // blog('showTopDialog : previousDialogDismissed ${_previousDialogDismissed.runtimeType} : '
    //     '$_previousDialogDismissed : _flushbar : $_flushbar : _key : $_key');

    await Flushbar(
      key: GlobalKey(),

      /// BEHAVIOUR - POSITIONING ----------------------------------------------
      // dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: isTop == true ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      // flushbarStyle: FlushbarStyle.FLOATING,
      // isDismissible: true,
      // blockBackgroundInteraction: false, // prevents gestures on background widgets

      /// SIZING ----------------------------------------------
      maxWidth: _screenWidth,
      borderRadius: _BldrsAppBar.corners,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(10),

      /// COLORING ----------------------------------------------
      // routeColor: null, // SCREEN BACKGROUND COLOR
      backgroundColor: color, // DIALOG BACKGROUND COLOR
      // barBlur: 50,
      // backgroundGradient: null,
      // boxShadows: Shadower.appBarShadow,
      // routeBlur: null,

      /// BORDERS ----------------------------------------------
      // borderColor: Colorz.Black255,
      // borderWidth: 1,

      /// ANIMATION ----------------------------------------------
      forwardAnimationCurve: Curves.easeOutBack,
      duration: Duration(milliseconds: milliseconds ?? 1000),
      animationDuration: const Duration(milliseconds: 150),
      reverseAnimationCurve: Curves.elasticOut,

      ///   LEFT BAR INDICATOR ----------------------------------------------
      // leftBarIndicatorColor: null,

      /// LEADING ----------------------------------------------
      // icon: null,

      /// TITLE ----------------------------------------------
      titleText: Container(
        width: _bubbleWidth,
        constraints: BoxConstraints(
          minHeight: _BldrsAppBar.collapsedHeight() - 5,
        ),
        decoration: const BoxDecoration(
          // color: Colorz.Black255,
          borderRadius: _BldrsAppBar.corners,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// FIRST LINE
            SuperText(
              boxWidth: _bubbleWidth,
              text: headlineVerse,
              textColor: textColor,
              maxLines: 3,
              margins: 5,
            ),

            /// SECOND LINE
            if (bodyVerse != null)
              SuperText(
                boxWidth: _bubbleWidth,
                text: bodyVerse,
                textHeight: 20,
                textColor: textColor,
                // weight: VerseWeight.thin,
                italic: true,
                maxLines: 2,
                margins: 5,
              ),

          ],
        ),
      ),

      /// BODY ----------------------------------------------
      messageText: const SizedBox(),
      // messageColor: null,
      // messageSize: null,

      /// ACTION BUTTON ----------------------------------------------
      // mainButton: null,
      // DreamBox(
      //   height: 40,
      //   width: 100,
      //   verse:  'main button',
      //   verseScaleFactor: 0.5,
      // ),

      /// PROGRESS INDICATOR ----------------------------------------------
      // showProgressIndicator: false,
      progressIndicatorBackgroundColor: Colorz.green255,
      // progressIndicatorController: AnimationController(),
      // progressIndicatorValueColor: ,

      /// INTERACTIONS ----------------------------------------------
      onTap: (Flushbar<dynamic> flushbar) async {

        await flushbar.dismiss();

      },

      onStatusChanged: (FlushbarStatus? status) {

        // switch (status) {
        //   case FlushbarStatus.SHOWING:
        //     {
        //       doSomething();
        //       break;
        //     }
        //   case FlushbarStatus.IS_APPEARING:
        //     {
        //       doSomethingElse();
        //       break;
        //     }
        //   case FlushbarStatus.IS_HIDING:
        //     {
        //       doSomethingElse();
        //       break;
        //     }
        //   case FlushbarStatus.DISMISSED:
        //     {
        //       doSomethingElse();
        //       break;
        //     }
        // }

      },

      /// UNKNOWN ----------------------------------------------
      message: "The Builder's Network",
      title: 'Bldrs.net',
      endOffset: Offset.zero,
      shouldIconPulse: false,
      // positionOffset: 0,
      // userInputForm: ,
    ).show(getTheMainContext());

  }
  // --------------------
  /// BUG THE SHIT OUT OF LIFE
  /*
  static void showUnawaitedTopDialog({
    required BuildContext context,
    required Verse firstVerse,
    Verse secondVerse,
    Color color = Colorz.yellow255,
    Color textColor = Colorz.black255,
    Function onTap,
    int milliseconds = 5000,
  }){

    unawaited(showTopDialog(
      context: context,
      firstVerse: firstVerse,
      secondVerse: secondVerse,
      color: color,
      textColor: textColor,
      onTap: onTap,
      milliseconds: milliseconds,
    ));

  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = context.screenWidth;

    return Flushbar(
      message: verse,
      onTap: onTap == null ? null : (Flushbar<dynamic> flush) => onTap?.call(flush),
      duration: const Duration(milliseconds: 5000),
      // title: 'wtf',
      // padding: EdgeInsets.zero,
      // margin: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      animationDuration: const Duration(milliseconds: 5000),
      backgroundColor: Colorz.black10,
      barBlur: 5,
      // backgroundGradient: null,
      blockBackgroundInteraction: true,
      // borderColor: null,
      borderWidth: _screenWidth,
      // dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      boxShadows: const <BoxShadow>[],
      endOffset: Offset.zero,
      // flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.easeInOut,
      // isDismissible: true,
      leftBarIndicatorColor: Colorz.green255,
      // mainButton: const DreamBox(
      //   height: 40,
      //   width: 100,
      //   verse:  'main button',
      //   verseScaleFactor: 0.5,
      // ),
      maxWidth: _screenWidth,
      messageColor: Colorz.white255,
      messageSize: 20,
      // messageText: const SuperVerse(
      //   verse:  'Message text',
      //   size: 1,
      // ),
      // onStatusChanged: (FlushbarStatus status) {
      //   blog('status is : $status');
      // },
      // positionOffset: 0,
      progressIndicatorBackgroundColor: Colorz.green255,
      // progressIndicatorController: AnimationController(),
      // progressIndicatorValueColor: ,
      reverseAnimationCurve: Curves.easeInOut,
      routeBlur: 0,
      routeColor: Colorz.black255,
      // shouldIconPulse: true,
      showProgressIndicator: true,
      titleColor: Colorz.bloodTest,
      titleSize: 15,
      // titleText: const SuperVerse(
      //   verse:  'title text',
      //   size: 1,
      // ),
      // userInputForm: ,
      icon: const SuperBox(
        width: 40,
        height: 40,
        icon: Iconz.logoSvg,
        color: Colorz.black255,
        margins: EdgeInsets.zero,
      ),
    )..show(context);

  }
// --------------------
}

class CenterDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CenterDialog({
    required this.bodyVerse,
    required this.title,
    required this.boolDialog,
    required this.height,
    required this.invertButtons,
    required this.confirmButtonVerse,
    required this.child,
    required this.onOk,
    required this.color,
    required this.copyOnTap,
    this.bodyCentered = true,
    this.noVerse,
    this.canExit = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? bodyVerse;
  final bool bodyCentered;
  final String? title;
  final bool? boolDialog;
  final double? height;
  final Widget? child;
  final String? confirmButtonVerse;
  final Color color;
  final Function? onOk;
  final bool invertButtons;
  final bool copyOnTap;
  final String? noVerse;
  final bool canExit;
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  static double getWidth(BuildContext context) {

    return context.responsive(
      landscape: context.screenShortestSide * 0.85,
      portrait: context.screenWidth * 0.85,
    );

  }
  // --------------------
  static double clearWidth(BuildContext context){
    return getWidth(context) - (2 * 10);
  }
  // --------------------
  static const double dialogCornerValue = 20;
  // --------------------
  static BorderRadius dialogBorders() {
    return _Borderers.cornerAll(dialogCornerValue);
  }
  // --------------------
  static double getHeight({
    required BuildContext context,
    double? heightOverride,
  }) {
    final double _screenHeight = context.screenHeight;
    final double _height = heightOverride ?? _screenHeight * 0.4;
    return _height;
  }
  // -----------------------------------------------------------------------------

  /// COLORS

  // --------------------
  static const Color activeButtonColor = Colorz.black255;
  static const Color defaultButtonColor = Colorz.light2;
  // -----------------------------------------------------------------------------

  /// LAUNCHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> showCenterDialog({
    required BuildContext context,
    String? bodyVerse,
    String? headlineVerse,
    bool? boolDialog = false,
    double? height,
    Widget? child,
    String? confirmButtonVerse,
    String? noVerse,
    Color color = Colorz.white50,
    Function? onOk,
    bool invertButtons = false,
    bool copyOnTap = false,
    bool bodyCentered = true,
    bool canExit = true,
  }) async {

    final bool? _result = await Routing.push(
      context: context,
      // pageTransitionType: PageTransitionType.fade,
      screen: CenterDialog(
        bodyVerse: bodyVerse,
        title: headlineVerse,
        height: height,
        boolDialog: boolDialog,
        confirmButtonVerse: confirmButtonVerse,
        noVerse: noVerse,
        color: color,
        onOk: onOk,
        invertButtons: invertButtons,
        copyOnTap: copyOnTap,
        bodyCentered: bodyCentered,
        canExit: canExit,
        child: child,
      ),
    );

    // final bool? _result = await showDialog(
    //   context: getTheMainContext(),
    //   builder: (BuildContext ctx) => ,
    // );

    await Routing.wait();

    return _Booler.boolIsTrue(_result);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeCenterDialog() async {
    await Routing.goBack(
      invoker: 'closeCenterDialog',
      context: getTheMainContext(),
    );
  }
  // --------------------
  /*
//   static double dialogVerticalMargin({BuildContext context, double dialogHeight}){
//     double _screenHeight = Scale.superScreenHeight(context);
//     return (_screenHeight - dialogHeight) / 2;
//   }
// // -----------------------------------------------------------------------------
//   static double dialogHorizontalMargin({BuildContext context, double dialogWidth}){
//     double _screenWidth = Scale.superScreenWidth(context);
//     return (_screenWidth - dialogWidth) / 2;
//   }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  String? _getConfirmButtonVerse(){

    String? _verse = _Booler.boolIsTrue(boolDialog) ?
    'Yes'
        :
    'No';

    if (confirmButtonVerse != null){
      _verse = confirmButtonVerse;
    }

    return _verse;
  }
  // --------------------
  static double getButtonZoneHeight = _DialogButton.height + (2 * 5);
  // --------------------
  Future<void> exit({
    required bool isButton,
    dynamic passedData,
  }) async {

    if ((canExit || _Booler.boolIsTrue(boolDialog)) && isButton){

      await Routing.goBack(
        context: getTheMainContext(),
        invoker: 'CenterDialog exit',
        passedData: passedData,
      );

    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = context.screenWidth;
    final double _screenHeight = context.screenHeight;
    // --------------------
    final BorderRadius _dialogBorders = dialogBorders();
    // --------------------
    final double _dialogHeight = getHeight(
      context: context,
      heightOverride: height,
    );
    // --------------------
    final double _dialogWidth = getWidth(context);
    // --------------------
    const String? _noVerse = 'No';
    // --------------------
    final bool _hasLeftNoButton = _Booler.boolIsTrue(boolDialog) == true && invertButtons == false;
    final bool _hasRightNoButton = _Booler.boolIsTrue(boolDialog) == true && invertButtons == true;
    final bool _hasOnlyOneButton = _hasLeftNoButton == false && _hasRightNoButton == false;

    final double? _yesButtonWidth = _hasOnlyOneButton == true ? clearWidth(context)
        :
    invertButtons == true ? 80
        :
    120;

    final double _noButtonWidth = invertButtons == true ? 120 : 80;
    // --------------------
    // const double _keyboardHeight =  0;
    // --------------------
    return BldrsPage(
      canGoBack: true,
      onBack: () => exit(isButton: true,),
      color: _BottomDialogScale.backgroundColor,
      child: WidgetFader(
        fadeType: FadeType.fadeIn,
        min: 0.7,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOutCirc,
        builder: (double value, Widget? child){

          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: value,
              child: child,
            ),
          );

        },
        child: SingleChildScrollViewX(
          physics: const NeverScrollableScrollPhysics(),
          child: GestureDetector(
            onTap: () => exit(
              isButton: false,
            ),
            onLongPress: () async {

              if (kDebugMode){
                await Routing.goBack(context: context);
              }

            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: _screenWidth,
              // height: ,
              constraints: BoxConstraints(
                minHeight: _screenHeight,
              ),
              alignment: Alignment.center,
              color: Colorz.black0, // to let parent gesture detector detect this container
              child: GestureDetector(
                onTap: () async {

                  // if (copyOnTap == true){
                  //   unawaited(KeyboardModel.copyToClipboardAndNotify(context: context, copy: title?.id));
                  // }
                  //
                  // await UiPro.closeKeyboard();

                  FocusManager.instance.primaryFocus?.unfocus();

                },
                child: Container(
                  width: _dialogWidth,
                  // height: _dialogHeight,
                  constraints: BoxConstraints(
                    minHeight: _dialogHeight,
                  ),
                  decoration: BoxDecoration(
                    color: color.withAlpha(255),
                    // boxShadow: Shadower.appBarShadow,
                    borderRadius: _dialogBorders,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// TITLE
                      Container(
                        width: _dialogWidth,
                        alignment: Alignment.center,
                        // color: Colorz.BloodTest,
                        child: title == null ? Container()
                            :
                        SuperText(
                          boxWidth: _dialogWidth * 0.9,
                          text: title,
                          // textColor: Colorz.white255,
                          // textHeight: 50,
                          italic: true,
                          maxLines: 2,
                          textColor: Colorz.black,
                          font: MojadwelFonts.headline,
                          // textHeight: 50,
                          // labelColor: Colorz.Yellow,
                          margins: const EdgeInsets.only(
                            top: 20,
                            bottom: 5,
                            left: 10,
                            right: 10,
                          ),
                        ),
                      ),

                      /// BODY
                      if (_TextCheck.isEmpty(bodyVerse) == false)
                        SizedBox(
                          width: _dialogWidth,
                          // height: _bodyZoneHeight,
                          child: SuperText(
                            boxWidth: _dialogWidth * 0.9,
                            text: bodyVerse,
                            font: MojadwelFonts.body,
                            textHeight: 27,
                            maxLines: 20,
                            // weight: VerseWeight.thin,
                            textColor: Colorz.black,
                            margins: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10 * 2,
                            ),
                            centered: bodyCentered,
                          ),
                        ),

                      /// child
                      if (child != null)
                        Column(
                          children: <Widget>[

                            SeparatorLine(
                              width: _dialogWidth,
                              color: Colorz.white255,
                            ),

                            Container(
                              width: _dialogWidth,
                              constraints: BoxConstraints(
                                maxHeight: _dialogHeight * 0.7,
                              ),
                              child: SingleChildScrollViewX(
                                physics: const BouncingScrollPhysics(),
                                child: child!,
                              ),
                            ),

                            SeparatorLine(
                              width: _dialogWidth,
                            ),

                          ],
                        ),

                      /// BUTTONS
                      if (boolDialog != null)
                      // SizedBox(
                      //   width: _dialogWidth,
                      //   height: getButtonZoneHeight,
                      //   child: UiPro.checkAppIsLeftToRight() == true ?
                      //
                      //   /// ENGLISH ( LTR )
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //
                      //       /// NO BUTTON
                      //       if (_hasLeftNoButton == true)
                      //         DialogButton(
                      //           width: 80,
                      //           verse: noVerse ?? _noVerse,
                      //           color: defaultButtonColor,
                      //           onTap: () => exit(
                      //             passedData: false,
                      //             isButton: true,
                      //           ),
                      //         ),
                      //
                      //       /// YES BUTTON
                      //       DialogButton(
                      //         width: _yesButtonWidth,
                      //         verse: _getConfirmButtonVerse(),
                      //         verseColor: invertButtons == true ? Colorz.white255 : Colorz.black230,
                      //         color: invertButtons == true ? defaultButtonColor : activeButtonColor,
                      //         onTap: () async {
                      //
                      //           onOk?.call();
                      //
                      //           if (Booler.boolIsTrue(boolDialog) == true){
                      //             await exit(
                      //               passedData: true,
                      //               isButton: true,
                      //             );
                      //           }
                      //
                      //           else {
                      //             await exit(
                      //               isButton: true,
                      //             );
                      //           }
                      //
                      //         },
                      //       ),
                      //
                      //       /// NO BUTTON
                      //       if (_hasRightNoButton == true)
                      //         DialogButton(
                      //           width: _noButtonWidth,
                      //           verse: noVerse ?? _noVerse,
                      //           verseColor: Colorz.black230,
                      //           color: activeButtonColor,
                      //           onTap: () => exit(
                      //             passedData: false,
                      //             isButton: true,
                      //           ),
                      //         ),
                      //
                      //     ],
                      //   )
                      //
                      //       :
                      //   /// ARABIC ( RTL )
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //
                      //       /// NO BUTTON
                      //       if (_hasRightNoButton == true)
                      //         DialogButton(
                      //           width: _noButtonWidth,
                      //           verse: noVerse ?? _noVerse,
                      //           verseColor: Colorz.black230,
                      //           color: activeButtonColor,
                      //           onTap: () => exit(
                      //             isButton: true,
                      //             passedData: false,
                      //           ),
                      //         ),
                      //
                      //       /// YES BUTTON
                      //       DialogButton(
                      //         width: _yesButtonWidth,
                      //         verse: _getConfirmButtonVerse(),
                      //         verseColor: invertButtons == true ? Colorz.white255 : Colorz.black230,
                      //         color: invertButtons == true ? defaultButtonColor : activeButtonColor,
                      //         onTap: () async {
                      //           onOk?.call();
                      //           if (Booler.boolIsTrue(boolDialog) == true){
                      //             await exit(
                      //               isButton: true,
                      //               passedData: true,
                      //             );
                      //           }
                      //           else {
                      //             await exit(
                      //               isButton: true,
                      //             );
                      //           }
                      //         },
                      //       ),
                      //
                      //       /// NO BUTTON
                      //       if (_hasLeftNoButton == true)
                      //         DialogButton(
                      //           width: 80,
                      //           verse: noVerse ?? _noVerse,
                      //           color: defaultButtonColor,
                      //           onTap: () => exit(
                      //             isButton: true,
                      //             passedData: false,
                      //           ),
                      //         ),
                      //
                      //     ],
                      //   ),
                      //
                      // ),

                        if (boolDialog != null)
                          _DialogBoolStrip(
                            dialogWidth: _dialogWidth,
                            getButtonZoneHeight: getButtonZoneHeight,
                            hasLeftNoButton: _hasLeftNoButton,
                            hasRightNoButton: _hasRightNoButton,
                            noVerse: noVerse ?? _noVerse,
                            defaultButtonColor: defaultButtonColor,
                            invertButtons: invertButtons,
                            yesButtonWidth: _yesButtonWidth,
                            confirmButtonVerse: _getConfirmButtonVerse(),
                            activeButtonColor: activeButtonColor,
                            onYes: () async {
                              onOk?.call();
                              if (_Booler.boolIsTrue(boolDialog) == true){
                                await exit(
                                  isButton: true,
                                  passedData: true,
                                );
                              }
                              else {
                                await exit(
                                  isButton: true,
                                );
                              }
                            },
                            noButtonWidth: _noButtonWidth,
                            onNo:  () => exit(
                              isButton: true,
                              passedData: false,
                            ),
                          ),

                    ],
                  ),
                ),
              ),

            ),
          ),
        ),
      ),
    );
    // --------------------
  }
// --------------------
}

class Popper extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Popper({
    required this.canGoBack,
    required this.child,
    this.onBack,
    super.key,
  });
  // -------------------------
  final bool canGoBack;
  final Function? onBack;
  final Widget child;
  // --------------------------------------------------------------------------
  static Future<void> _onPopInvoked({
    required BuildContext context,
    required Function? onBack,
    required bool canGoBack,
    required bool didPop,
  }) async {

    if (didPop == true){
      // blog('==> DID POP ALREADY');
    }

    else if (onBack != null){
      // blog('==> BACK IS OVERRIDEN : didPop : $didPop');
      await onBack.call();
    }

    else {

      if (canGoBack == true){
        // blog('==> GOING BACK : didPop : $didPop');
        await Routing.goBack(
          context: context,
          invoker: 'Popper.onGoBack',
        );
      }
      else {
        // blog('==> BACK IS BLOCKED : didPop : $didPop');
      }

    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// I NEED
    /// if can go back = can press the back buttons
    /// back buttons : [ app bar back - android device back ]
    ///
    /// if onBack is defined = it overrides everything
    /// so when tapping any of those buttons
    /// it calls the overriding function
    ///
    /// that's it
    // --------------------
    /// DEPRECATED
    // return WillPopScope(
    //   key: const ValueKey<String>('Popper'),
    //   onWillPop: () async {
    //
    //     blog('on will pop aho');
    //
    //     await onGoBack(
    //       context: context,
    //       canGoBack: canGoBack,
    //       onBack: onBack,
    //     );
    //
    //     return false;
    //   },
    //   child: child,
    // );
    /// WORKS GOOD
    return PopScope(
      key: const ValueKey<String>('Popper'),
      canPop: false,
      // onPopInvoked: (bool value) => _onPopInvoked(
      //   context: context,
      //   canGoBack: canGoBack,
      //   onBack: onBack,
      //   didPop: value,
      // ),
      onPopInvokedWithResult: (bool value, dynamic result) => _onPopInvoked(
        context: context,
        canGoBack: canGoBack,
        onBack: onBack,
        didPop: value,
      ),
      child: child,
    );

    // return NavigatorPopHandler(
    //   key: const ValueKey<String>('Popper'),
    //   enabled: true,
    //   onPop: () async {
    //
    //     blog('on pop aho');
    //
    //     await onGoBack(
    //       context: context,
    //       canGoBack: canGoBack,
    //       onBack: onBack,
    //     );
    //
    //   },
    //   child: child,
    // );

  }
// --------------------------------------------------------------------------
}

class BldrsPage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BldrsPage({
    required this.canGoBack,
    required this.color,
    required this.child,
    this.onBack,
    super.key
  });
  // --------------------
  final bool canGoBack;
  final Function? onBack;
  final Color color;
  final Widget child;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Material(
      child: Popper(
        canGoBack: canGoBack,
        onBack: onBack,
        child: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          color: color,
          child: child,
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

// --------------------------------------------------------------------------

class _DialogButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _DialogButton({
    required this.text,
    this.textColor = Colorz.white255,
    this.width = 100,
    this.color = Colorz.nothing,
    this.onTap,
    this.italic = true,
    this.appIsLTR = true,
    this.textDirection = TextDirection.ltr,
    this.isDisabled = false,
    this.font,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? text;
  final Color textColor;
  final double width;
  final Color color;
  final Function? onTap;
  final bool italic;
  final bool appIsLTR;
  final TextDirection textDirection;
  final String? font;
  final bool isDisabled;
  /// --------------------------------------------------------------------------
  static const double height = 50;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperBox(
      isDisabled: isDisabled,
      height: height,
      width: width,
      margins: const EdgeInsets.all(5),
      text: text,
      textWeight: FontWeight.w600,
      textItalic: true,
      textMaxLines: 2,
      textColor: textColor,
      color: color,
      textScaleFactor: 0.6,
      appIsLTR: appIsLTR,
      textDirection: textDirection,
      textFont: font,
      onTap: onTap,
    );
  }
/// --------------------------------------------------------------------------
}

class _DialogBoolStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _DialogBoolStrip({
    required this.dialogWidth,
    required this.getButtonZoneHeight,
    required this.hasLeftNoButton,
    required this.hasRightNoButton,
    required this.noVerse,
    required this.defaultButtonColor,
    required this.invertButtons,
    required this.yesButtonWidth,
    required this.confirmButtonVerse,
    required this.activeButtonColor,
    required this.onYes,
    required this.noButtonWidth,
    required this.onNo,
    this.confirmDisabled = false,
    super.key
  });
  // --------------------
  final double dialogWidth;
  final double getButtonZoneHeight;
  final bool hasLeftNoButton;
  final bool hasRightNoButton;
  final String noVerse;
  final Color defaultButtonColor;
  final bool invertButtons;
  final double? yesButtonWidth;
  final String? confirmButtonVerse;
  final Color activeButtonColor;
  final Function onYes;
  final double noButtonWidth;
  final Function onNo;
  final bool confirmDisabled;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SizedBox(
      width: dialogWidth,
      height: getButtonZoneHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// NO BUTTON
          if (hasLeftNoButton == true)
            _DialogButton(
              width: 80,
              text: noVerse,
              color: defaultButtonColor,
              textColor: activeButtonColor,
              onTap: onNo,
            ),

          /// YES BUTTON
          _DialogButton(
            width: yesButtonWidth ?? 80,
            text: confirmButtonVerse,
            textColor: invertButtons == true ? activeButtonColor : defaultButtonColor,
            color: invertButtons == true ? defaultButtonColor : activeButtonColor,
            isDisabled: confirmDisabled,
            onTap: onYes,
          ),

          /// NO BUTTON
          if (hasRightNoButton == true)
            _DialogButton(
              width: noButtonWidth,
              text: noVerse,
              textColor: defaultButtonColor,
              color: activeButtonColor,
              onTap: onNo,
            ),

        ],
      ),

    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

// --------------------------------------------------------------------------

abstract class _Booler {
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool boolIsTrue(dynamic value){
    bool _output = false;

    if (value != null && value is bool){
      _output = value;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}

abstract class _Borderers {
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  // -----------------------------------------------------------------------------
}

abstract class _TextCheck {
  // --------------------
  /// AI TESTED
  static bool isEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
// -----------------------------------------------------------------------------
}

abstract class _BottomDialogScale {
  // --------------------
  static const Color backgroundColor = Colorz.black150;
// -----------------------------------------------------------------------------
}

abstract class _BldrsAppBar {
  // -----------------------------------------------------------------------------

  /// SCALE

  // --------------------
  static double width(BuildContext context) {
    return context.screenWidth - (2 * 10);
  }
  // --------------------
  static double collapsedHeight() {

    // if (appBarType == AppBarType.search){
    //   return Ratioz.appBarBigHeight;
    // }
    // else if (appBarType == AppBarType.non){
    return 0;
    // }
    // else {
    //   return Ratioz.appBarSmallHeight;
    // }

  }
  // --------------------
  static const BorderRadius corners = BorderRadius.all(Radius.circular(10));
  // -----------------------------------------------------------------------------
}
