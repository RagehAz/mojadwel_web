part of super_text;

class BulletPoints extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BulletPoints({
    required this.bulletPoints,
    required this.boxWidth,
    required this.textHeight,
    this.centered = false,
    this.textColor = const Color.fromARGB(255, 133, 203, 218),
    this.showBottomLine = true,
    this.appIsLTR = true,
    this.textDirection = TextDirection.ltr,
    this.font,
    this.maxLines = 10,
    this.showDots = true,
    super.key,
  });
  /// --------------------------------------------------------------------------
  final List<String>? bulletPoints;
  final double textHeight;
  final double? boxWidth;
  final bool centered;
  final Color? textColor;
  final bool showBottomLine;
  final bool appIsLTR;
  final TextDirection textDirection;
  final String? font;
  final int maxLines;
  final bool showDots;
  // --------------------
  /// AI TESTED
  static bool _checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double _screenWidth(BuildContext context) {
    return context.mounted == true ? MediaQuery.sizeOf(context).width : 0;
    // return MediaQuery.of(context).size.width;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (_checkCanLoop(bulletPoints) == false){
      return const SizedBox();
    }

    else {

      final double screenWidth = _screenWidth(context);
      final double _boxWidth = boxWidth ?? (screenWidth - 20);

      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: centered == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: <Widget>[

            /// TEXTS

            ...List.generate(bulletPoints!.length, (index){

              return SizedBox(
                width: _boxWidth,
                child: SuperText(
                  text: bulletPoints![index],
                  margins: 0,
                  textHeight: textHeight,
                  maxLines: maxLines,
                  centered: centered,
                  textColor: textColor,
                  italic: true,
                  weight: FontWeight.w100,
                  leadingDot: showDots,
                  appIsLTR: appIsLTR,
                  textDirection: textDirection,
                  font: font,
                ),
              );

            }),

            /// BOTTOM LINE
            if (showBottomLine == true)
              Container(
                width: _boxWidth - 20,
                height: 0.5,
                color: textColor,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),

          ],
        ),
      );

    }

  }
/// --------------------------------------------------------------------------
}
