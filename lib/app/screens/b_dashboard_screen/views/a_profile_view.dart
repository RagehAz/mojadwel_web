import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/page_headline.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/components/profile_tile.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/controllers/dashboard_controller.dart';
import 'package:mojadwel_web/core/models/bz_model/bz_model.dart';
import 'package:mojadwel_web/core/shared_components/lists/vertical_floating_list.dart';
import 'package:mojadwel_web/core/shared_components/super_box/super_box.dart';
import 'package:mojadwel_web/core/shared_components/super_pop_menu/super_pop_menu.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/theme/iconz.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

import '../b_dash_board_screen.dart' show DashboardScreen;

class ProfileView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ProfileView({
    required this.controller,
    super.key
  });
  // --------------------
  final DashboardController controller;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return VerticalFloatingList(
      width: context.screenWidth - DashboardScreen.menuWidth,
      height: context.screenHeight,
      boxColor: Colorz.light2,
      boxAlignment: Alignment.topLeft,
      mainAxisAlignment: MainAxisAlignment.start,
      children: controller.canBuild == false ? [] : <Widget>[

        /// GOOGLE SIGN IN BOX
        if (controller.authModel == null)
          Builder(
              builder: (context) {

                final double boxWidth = context.screenWidth * 0.5;
                const double boxHeight = 500;

                return Container(
                  width: context.screenWidth - DashboardScreen.menuWidth,
                  height: context.screenHeight,
                  alignment: Alignment.center,
                  child: Container(
                    width: boxWidth,
                    height: boxHeight,
                    decoration: BoxDecoration(
                      borderRadius: HelpersPop.cornerAll(10),
                      color: Colorz.light1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SuperText(
                          boxWidth: boxWidth * 0.9,
                          text: 'Sign in to create an account\nconnect your system',
                          textHeight: 60,
                          font: MojadwelFonts.headline,
                          textColor: Colorz.black255,
                          maxLines: 3,
                          lineSpacingFactor: 0.6,
                        ),

                        const Spacing(size: 30),

                        SuperBox(
                          height: 80,
                          width: boxWidth * 0.9,
                          text: 'Continue by google',
                          iconSizeFactor: 0.6,
                          icon: Iconz.googleColor,
                          onTap: controller.onGoogleAuth,
                          textMaxLines: 2,
                          color: Colorz.black,
                          splashColor: Colorz.googleRed,
                        ),
                        const Spacing(size: 30),
                        SuperText(
                          boxWidth: boxWidth * 0.7,
                          text: "By continuing, you agree to Mojadwel's Terms of Service\nRead our Privacy Policy.",
                          textHeight: 27,
                          font: MojadwelFonts.body,
                          textColor: Colorz.black255,
                          maxLines: 5,
                          lineSpacingFactor: 0.8,
                          margins: 5,
                        )
                      ],
                    ),
                  ),
                );
              }
              ),

        /// ADD ACCOUNT BUTTON
        if (controller.authModel != null && controller.userModel == null)
          ProfileTile(
            headline: '',
            value: 'Create account',
            icon: Iconz.createAccount,
            onTap: controller.onCreateAccount,
            redDot: false,
          ),

        /// THE FIELDS
        if (controller.authModel != null && controller.userModel != null)
          Builder(
            builder: (context) {

              final UserModel? _userModel = controller.userModel;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// PAGE HEADLINE
                  const PageHeadline(
                    text: 'Profile',
                  ),

                  /// NAME
                  ProfileTile(
                    headline: 'Owner name',
                    value: _userModel?.ownerName,
                    icon: Iconz.user,
                    redDot: _userModel?.ownerName == null,
                    onTap: controller.onOwnerNameTap,
                  ),

                  /// COMPANY NAME
                  ProfileTile(
                    headline: 'Company name',
                    value: _userModel?.businessName,
                    icon: Iconz.company,
                    redDot: _userModel?.businessName == null,
                    onTap: controller.onBusinessNameTap,
                  ),

                  /// Email
                  ProfileTile(
                    headline: 'Email',
                    value: _userModel?.email,
                    icon: Iconz.email,
                    redDot: _userModel?.email == null,
                    // onTap: controller.onEmailTap,
                  ),

                  /// PHONE
                  ProfileTile(
                    headline: 'Phone',
                    value: _userModel?.phone,
                    icon: Iconz.whatsapp,
                    redDot: _userModel?.phone == null,
                    onTap: controller.onPhoneTap,
                  ),

                  /// PLAN
                  ProfileTile(
                    headline: 'Plan',
                    value: _userModel?.plan,
                    icon: Iconz.plan,
                    redDot: _userModel?.plan == null,
                    onTap: controller.onPlanTileTap,
                  ),

                  /// EXTRA BZ INFO
                  ProfileTile(
                    headline: 'Extra Business info',
                    value: _userModel?.extraBzInfo,
                    icon: Iconz.info,
                    redDot: _userModel?.extraBzInfo == null,
                    onTap: controller.onExtraBzInfoTap,
                  ),

                  /// GOOGLE SHEET
                  ProfileTile(
                    headline: 'Google sheet',
                    value: null,
                    icon: Iconz.sheets,
                    redDot: true,
                    onTap: controller.onSheetsTileTap,
                  ),

                  /// GOOGLE CALENDAR
                  ProfileTile(
                    headline: 'Google Calendar',
                    value: null,
                    icon: Iconz.calendar,
                    redDot: true,
                    onTap: controller.onCalendarTileTap,
                  ),

                  /// REMINDERS
                  ProfileTile(
                    headline: 'Auto-reminders',
                    value: null,
                    icon: Iconz.notification,
                    redDot: true,
                    onTap: controller.onRemindersTileTap,
                  ),

                  /// AI INSTRUCTIONS
                  ProfileTile(
                    headline: 'Ai Instructions',
                    value: null,
                    icon: Iconz.scholar,
                    redDot: true,
                    onTap: controller.onAiInstructionsTap,
                  ),

                  /// SPACING
                  const Spacing(size: 100),

                ],
              );
            }
          ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
