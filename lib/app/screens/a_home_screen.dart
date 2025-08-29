import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/lists/separator_line.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';

class HomeScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomeScreen({super.key});
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: (double bodyWidth){

        final double _tileWidth = bodyWidth * 0.6;

        return SizedBox(
          width: bodyWidth,
          child: VerticalFloatingList(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              /// MAIN
              Column(
                children: <Widget>[

                  /// LOGO
                  Container(
                    width: 120,
                    height: 120,
                    alignment: Alignment.centerRight,
                    child: SuperBox(
                      height: 50,
                      width: 50,
                      margins: 20,
                      icon: Iconz.logoPng,
                      textCentered: false,
                      // corners: 50,
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
                  ),

                  /// HEADLINE
                  const HomePageHeadline(
                    text: 'Ai serves your schedule',
                  ),

                  /// DESCRIPTION
                  const HomePageSecondLine(
                    text: 'Transform your scheduling system to an advanced ai chat agent\nconnected to your calendar and customers sheet',
                  ),

                  /// VIDEO
                  Builder(
                      builder: (context) {

                        final double _width = bodyWidth * 0.8;
                        final double _height = _width * 9 / 16;

                        return Container(
                          width: _width,
                          height: _height,
                          color: Colorz.black50,
                          margin: const EdgeInsets.all(10),
                        );
                      }
                  ),

                ],
              ),

              /// SPACING
              const HomePageSpacer(),

              /// HOW IT WORKS
              const Column(
                children: <Widget>[

                  /// HEADLINE
                  HomePageHeadline(
                    text: 'How it works',
                  ),

                  /// SECOND LINE
                  HomePageSecondLine(
                    text: 'Simple steps for the Ai to be your personal receptionist',
                  ),

                  /// BOTTOM SPACING
                  Spacing(size: 30),

                  /// HOW IT WORKS
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: <Widget>[

                      HowItWorksCard(
                        headline: 'Ai-Powered Chat',
                        text: 'Customers chat with Mojadwel on Whatsapp like a real person',
                        icon: Iconz.whatsapp,
                      ),

                      HowItWorksCard(
                        headline: 'Smart Scheduling',
                        text: 'Your Calendar is automatically updated with new appointments',
                        icon: Iconz.calendar,
                      ),

                      HowItWorksCard(
                        headline: 'Auto-Reminders',
                        text: 'Both you and your customer get booking confirmations & reminders',
                        icon: Iconz.notification,
                      ),

                    ],
                  ),

                ],
              ),

              /// SPACING
              const HomePageSpacer(),

              /// FAQS
              Column(
                children: <Widget>[

                  /// HEADLINE
                  const HomePageHeadline(
                    text: 'Frequently Asked Questions',
                  ),

                  /// SECOND LINE
                  const HomePageSecondLine(
                    text: 'Find answers to common questions about our ai receptionist system',
                  ),

                  /// BOTTOM SPACING
                  const Spacing(size: 30),

                  /// FAQ TILES
                  Builder(
                    builder: (_){

                      final double _tileWidth = bodyWidth * 0.6;

                      return Column(
                        children: <Widget>[

                          Container(
                            width: _tileWidth,
                            height: 100,
                            color: Colorz.dark2,
                            margin: const EdgeInsets.all(5),
                          ),
                          Container(
                            width: _tileWidth,
                            height: 100,
                            color: Colorz.dark2,
                            margin: const EdgeInsets.all(5),
                          ),
                          Container(
                            width: _tileWidth,
                            height: 100,
                            color: Colorz.dark2,
                            margin: const EdgeInsets.all(5),
                          ),
                          Container(
                            width: _tileWidth,
                            height: 100,
                            color: Colorz.dark2,
                            margin: const EdgeInsets.all(5),
                          ),

                        ],
                      );

                    },
                  ),

                ],
              ),

              /// SPACING
              const HomePageSpacer(),

              /// JOIN THE WAITING LIST
              Column(
                children: <Widget>[

                  /// HEADLINE
                  const HomePageHeadline(
                    text: 'Ready to transform your business ?',
                  ),

                  /// HEADLINE
                  const HomePageSecondLine(
                    text: 'Join the waiting list and get a 50% discount on product release',
                  ),

                  /// BOTTOM SPACING
                  const Spacing(size: 30),

                  /// FAQ TILES
                  HomePageJoinWaitListTile(
                    width: _tileWidth,
                  ),

                ],
              ),

              /// SPACING
              const HomePageSpacer(),

              /// FOOTER
              HomePageFooter(
                width: bodyWidth,
              ),

            ],
          ),
        );

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class HomePageHeadline extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageHeadline({
    required this.text,
    super.key
  });
  // --------------------
  final String text;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperText(
      text: text,
      textHeight: 100,
      font: MojadwelFonts.headline,
      textColor: Colorz.black255,
      maxLines: 2,
      lineSpacingFactor: 0.6,
      margins: 5,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class HomePageSecondLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageSecondLine({
    required this.text,
    super.key
  });
  // --------------------
  final String text;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperText(
      text: text,
      textHeight: 35,
      font: MojadwelFonts.body,
      textColor: Colorz.black255,
      maxLines: 2,
      lineSpacingFactor: 0.8,
      margins: 5,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class HowItWorksCard extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HowItWorksCard({
    required this.headline,
    required this.text,
    required this.icon,
    super.key
  });
  // --------------------
  final String headline;
  final String text;
  final String icon;
  // -----------------------------------------------------------------------------
  Border? borderThick(Color? color, double thickness){
    return color == null || color == Colorz.nothing ? null : Border.all(
      width: thickness,
      color: color,
      strokeAlign: BorderSide.strokeAlignOutside,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colorz.light1,
        border: borderThick(Colorz.light3, 2),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[

          /// ICON
          SuperBox(
            height: 50,
            width: 50,
            margins: 20,
            icon: icon,
            iconSizeFactor: 0.9,
            textCentered: false,
          ),

          /// HEADLINE
          SuperText(
            boxWidth: 250,
            text: headline,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            textHeight: 30,
            font: MojadwelFonts.body,
            weight: FontWeight.w900,
            textColor: Colorz.black255,
            lineSpacingFactor: 0.8,
          ),

          /// DESCRIPTION
          SuperText(
            boxWidth: 250,
            text: text,
            maxLines: 5,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            textHeight: 25,
            font: MojadwelFonts.body,
            weight: FontWeight.w500,
            textColor: Colorz.black255,
            lineSpacingFactor: 0.8,
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

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

class HomePageJoinWaitListTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageJoinWaitListTile({
    required this.width,
    super.key
  });
  // --------------------
  final double width;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: width,
      height: 200,
      color: Colorz.light2,
      margin: const EdgeInsets.all(5),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class HomePageSpacer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageSpacer({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const Spacing(size: 100);
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class HomePageFooter extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePageFooter({
    required this.width,
    super.key
  });
  // --------------------
  final double width;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Column(
      children: [

        /// LINE
        SeparatorLine(
          width: width,
          color: Colorz.light3,
        ),

        Container(
          width: width,
          height: 200,
          color: Colorz.light1,
        ),
      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
