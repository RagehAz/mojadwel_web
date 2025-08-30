import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';

class HomePageFAQTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageFAQTile({
    required this.width,
    required this.question,
    required this.answer,
    super.key
  });
  // --------------------
  final double width;
  final String question;
  final String answer;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: width,
      height: 100,
      color: Colorz.dark2,
      margin: const EdgeInsets.all(5),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
