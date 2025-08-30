import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/app/screens/a_home_screen/parts/home_it_works_part.dart';
import 'package:mojadwel_web/app/screens/a_home_screen/parts/home_page_footer.dart';
import 'package:mojadwel_web/app/screens/a_home_screen/parts/home_page_headline.dart';
import 'package:mojadwel_web/app/screens/a_home_screen/parts/home_page_second_line.dart';
import 'package:mojadwel_web/app/screens/a_home_screen/parts/home_page_spacer.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
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

        // final double _tileWidth = bodyWidth * 0.6;

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

                        // await Routing.push(
                        //   screen: const SuperLayoutExample(),
                        //   context: context,
                        // );


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

                  /// START
                  SuperBox(
                    height: 90,
                    width: bodyWidth * 0.4,
                    text: 'Start ..',
                    color: Colorz.black255,
                    textFont: MojadwelFonts.headline,
                    margins: 20,
                    splashColor: Colorz.green255,
                    onTap: () => Routing.goTo(route: Routing.routeDashboard),
                  ),

                  /// VIDEO
                  Builder(
                      builder: (context) {

                        final double _width = bodyWidth * 0.7;
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
