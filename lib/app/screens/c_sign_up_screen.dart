import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';

class SignupScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SignupScreen({super.key});
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SuperBox(
            height: 100,
            // width: 100,
            icon: Iconz.logoPng,
            text: 'Sign up screen',
            // iconColor: Colorz.googleRed,
            // color: Colorz.white255,
            // iconSizeFactor: 1,
            // corners: 50,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            onTap: () async {



            },
          ),


        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
