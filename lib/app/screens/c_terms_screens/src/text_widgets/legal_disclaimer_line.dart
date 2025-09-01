part of legalizer;

class LegalDisclaimerLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LegalDisclaimerLine({
    required this.onPolicyTap,
    required this.onTermsTap,
    this.textHeight = 20,
    this.textColor = Colorz.black,
    this.textBoxesColor = Colorz.light2,
    this.disclaimerLine = 'By using this platform, you agree to our',
    this.termsLine = ' Terms of service ',
    this.andLine = ' & ',
    this.policyLine = ' Privacy policy ',
    this.textDirection = TextDirection.ltr,
      super.key
  });  // --------------------------------------------------------------------------
  final Function onTermsTap;
  final Function onPolicyTap;
  final double textHeight;
  final Color textColor;
  final Color textBoxesColor;
  final String disclaimerLine;
  final String termsLine;
  final String andLine;
  final String policyLine;
  final TextDirection textDirection;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.screenWidth(context),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SuperText(
            text: disclaimerLine,
            textHeight: textHeight,
            font: MojadwelFonts.body,
            textColor: textColor,
            textDirection: textDirection,
            maxLines: 4,
          ),

          Wrap(
            textDirection: textDirection,
            children: <Widget>[

              SuperText(
                text: termsLine,
                centered: false,
                boxColor: textBoxesColor,
                textColor: textColor,
                textHeight: textHeight,
                font: MojadwelFonts.body,
                margins: const EdgeInsets.symmetric(horizontal: 5),
                onTap: onTermsTap,
              ),

              SuperText(
                text: andLine,
                centered: false,
                textHeight: textHeight - 2,
                font: MojadwelFonts.body,
                textColor: textColor,
              ),

              SuperText(
                text: policyLine,
                centered: false,
                boxColor: textBoxesColor,
                textHeight: textHeight,
                font: MojadwelFonts.body,
                textColor: textColor,
                onTap: onPolicyTap,
                margins: const EdgeInsets.symmetric(horizontal: 5),
              ),

            ],
          ),

        ],
      ),
    );

  }
  // --------------------------------------------------------------------------
}
