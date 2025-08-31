import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/page_headline.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/plan_card.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/controllers/dashboard_controller.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class PlanView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PlanView({
    required this.controller,
    super.key
  });
  // --------------------
  final DashboardController controller;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _zoneWidth = context.screenWidth;
    // --------------------
    return Material(
      color: Colorz.light1.withAlpha(230),
      child: TapLayer(
        width: _zoneWidth,
        height: context.screenHeight,
        splashColor: Colorz.greyDark,
        onTap: () async {
          await Routing.goBack(context: context);
        },
        child: VerticalFloatingList(
          width: _zoneWidth,
          height: context.screenHeight,
          boxColor: Colorz.nothing,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// PAGE HEADLINE
            PageHeadline(
              text: 'Pricing',
              width: _zoneWidth,
              centered: true,
            ),

            /// CARDS
            Builder(
                builder: (_){

                  final double _width = _zoneWidth - 100;
                  const double _spacing = 20;

                  return Container(
                    width: _zoneWidth,
                    alignment: Alignment.center,
                    child: Container(
                      width: _width,
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: _spacing,
                        runSpacing: _spacing,
                        children: <Widget>[

                          /// STARTED
                          PlanCard(
                            headline: 'Starter',
                            secondLine: 'Perfect for small clinics or doctors starting out. Everything you need to connect WhatsApp, Calendar, and Sheets in one simple package.',
                            bullets: const <String>[
                              '✅ Connect 1 WhatsApp number',
                              '✅ Google Calendar control',
                              '✅ Google Sheets control',
                              '✅ Ai Booking & reminders',
                              '✅ Analytics dashboard',
                            ],
                            price: '999 EGP / month',
                            onTap: controller.onSelectStarterPlan,
                          ),

                          /// PRO
                          PlanCard(
                            headline: 'Professional',
                            secondLine: 'For growing clinics that need more control, deeper insights, and advanced automation.',
                            bullets: const <String>[
                              '✅ Everything in Starter',
                              '✅ 3 WhatsApp numbers',
                              '✅ Detailed performance & cost analytics',
                            ],
                            price: '1999 EGP / month',
                            onTap: controller.onSelectProPlan,
                          ),

                        ],
                      ),
                    ),
                  );

                },
            ),

            /// SPACING
            const Spacing(size: 100),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
