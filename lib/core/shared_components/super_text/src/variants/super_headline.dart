part of super_text;

class SuperHeadline extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SuperHeadline({
    required this.text,
    this.width,
    this.color = Colorz.black255,
    this.textHeight = 30,
    this.margin = 20,
    super.key
  });
  // -----------------------------------------------------------------------------
  final String text;
  final double? width;
  final Color color;
  final double textHeight;
  final dynamic margin;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperText(
      text: text,
      boxWidth: width,
      textHeight: textHeight,
      maxLines: 2,
      textColor: color,
      centered: false,
      margins: margin,
      italic: true,
      font: MojadwelFonts.montreal,
    );

  }
  // -----------------------------------------------------------------------------
}
