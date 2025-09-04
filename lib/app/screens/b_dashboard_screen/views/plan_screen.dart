import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/router/routing.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/plan_card.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/controllers/dashboard_controller.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/services/fire/fire.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class PlanView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PlanView({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _spacing = 10;
    // --------------------
    return TheLayout(
      backgroundColor: Colorz.light1.withAlpha(230),
      hasAppBar: false,
      title: 'Pricing',
      showMenu: false,
      child: (ScreenDim screen) => TapLayer(
        width: screen.screenWidth,
        height: screen.screenHeight,
        splashColor: Colorz.greyDark,
        onTap: () async {
          await Routing.goBack(context: context);
        },
        child: VerticalFloatingList(
          width: screen.bodyWidth,
          height: screen.screenHeight,
          boxColor: Colorz.nothing,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Spacing(size: 20),

            /// CARDS
            Container(
              width: screen.bodyWidth,
              alignment: Alignment.center,
              child: Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                children: <Widget>[

                  /// STARTED
                  PlanCard(
                    bodyWidth: screen.bodyWidth,
                    headline: 'Starter',
                    secondLine: 'Perfect for small clinics or doctors starting out. Everything you need to connect WhatsApp, Calendar, and Sheets in one simple package.',
                    bullets: const <String>[
                      '✅ Connect 1 WhatsApp number',
                      '✅ Google Calendar control',
                      '✅ Google Sheets control',
                      '✅ Ai Booking & reminders',
                      '✅ Analytics dashboard',
                    ],
                    price: '500 EGP / month',
                    // onTap: controller.onSelectStarterPlan,
                  ),

                  /// PRO
                  PlanCard(
                    bodyWidth: screen.bodyWidth,
                    headline: 'Professional',
                    secondLine: 'For growing clinics that need more control, deeper insights, and advanced automation.',
                    bullets: const <String>[
                      '✅ Everything in Starter',
                      '✅ 3 WhatsApp numbers',
                      '✅ Detailed performance & cost analytics',
                    ],
                    price: '2000 EGP / month',
                    // onTap: controller.onSelectProPlan,
                  ),

                ],
              ),
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

class TheCards extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheCards({
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
    blog('_zoneWidth($_zoneWidth)');
    const double _spacing = 10;
    // --------------------
    return Container(
      width: _zoneWidth,
      alignment: Alignment.center,
      child: Wrap(
        spacing: _spacing,
        runSpacing: _spacing,
        children: <Widget>[

          /// STARTED
          PlanCard(
            bodyWidth: _zoneWidth,
            headline: 'Starter',
            secondLine: 'Perfect for small clinics or doctors starting out. Everything you need to connect WhatsApp, Calendar, and Sheets in one simple package.',
            bullets: const <String>[
              '✅ Connect 1 WhatsApp number',
              '✅ Google Calendar control',
              '✅ Google Sheets control',
              '✅ Ai Booking & reminders',
              '✅ Analytics dashboard',
            ],
            price: '500 EGP / month',
            onTap: controller.onSelectStarterPlan,
          ),

          /// PRO
          PlanCard(
            bodyWidth: _zoneWidth,
            headline: 'Professional',
            secondLine: 'For growing clinics that need more control, deeper insights, and advanced automation.',
            bullets: const <String>[
              '✅ Everything in Starter',
              '✅ 3 WhatsApp numbers',
              '✅ Detailed performance & cost analytics',
            ],
            price: '2000 EGP / month',
            onTap: controller.onSelectProPlan,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
