import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';

class FireTestingScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const FireTestingScreen({super.key});
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: (double bodyWidth) =>Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SuperBox(
            height: 100,
            // width: 100,
            icon: Iconz.logoPng,
            text: 'Fire Testing screen',
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
