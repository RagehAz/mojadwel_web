import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class HomeScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomeScreen({super.key});
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
            // iconColor: Colorz.googleRed,
            // color: Colorz.white255,
            // iconSizeFactor: 1,
            // corners: 50,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            onTap: () async {

              blog('wtf');

              final String? _id = await OfficialFire.createDoc(
                  coll: 'users',
                  input: {
                    'bro': 'wtf',
                    'fire': 'works man',
                  },
              );

              blog('done._id($_id)');

              final bool _delete = await OfficialFire.deleteDoc(coll: 'users', doc: _id);

              blog('deleted ($_delete)');


            },
          ),

          SuperText(
            boxWidth: context.screenWidth,
            centered: false,
            text: 'Mojadwel',
            maxLines: 4,
            margins: const EdgeInsets.symmetric(horizontal: 20),
            textHeight: 100,
            lineSpacingFactor: 0.6,
            font: MojadwelFonts.montreal,
            textColor: Colorz.light3,
          ),

          SuperText(
            boxWidth: context.screenWidth,
            centered: false,
            text: 'Ai\nyour Whatsapp receptionist',
            maxLines: 5,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            textHeight: 30,
            font: MojadwelFonts.regular,
            textColor: Colorz.black255,
          ),

        ],
      ),
    );
    // --------------------
  }

  // -----------------------------------------------------------------------------
}
