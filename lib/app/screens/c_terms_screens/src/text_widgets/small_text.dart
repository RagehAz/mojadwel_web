part of legalizer;

class SmallText extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SmallText(
      this.text,
      {
  super.key
  });  // -----------------------------------------------------------------------------
  final String text;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperText(
      text: text,
      weight: FontWeight.w100,
      italic: true,
      maxLines: 10,
      margins: const EdgeInsets.symmetric(horizontal: 25),
      textHeight: 30,
      textColor: Colorz.black255,
      // appIsLTR: true,
      // textDirection: TextDirection.ltr,
      font: MojadwelFonts.body,
    );

  }
// -----------------------------------------------------------------------------
}
