import 'package:flutter/material.dart';
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
      children: <Widget>[

        if (controller.authModel == null)
          Builder(
              builder: (context) {
                final double boxWidth = context.screenWidth * 0.5;
                const double boxHeight = 500;
                return Container(
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
                );
              }
              ),

        if (controller.authModel != null)
          Builder(
            builder: (context) {

              final UserModel? _userModel = controller.userModel;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (controller.userModel == null)
                    ProfileTile(
                      text: 'Create account',
                      icon: Iconz.createAccount,
                      onTap: controller.onCreateAccount,
                    ),

                  /// NAME
                  ProfileTile(
                    text: _userModel?.ownerName ?? 'Owner name',
                    icon: Iconz.user,
                  ),

                  /// COMPANY NAME
                  ProfileTile(
                    text: _userModel?.businessName ?? 'Company name ...',
                    icon: Iconz.company,
                  ),

                  /// Email
                  ProfileTile(
                    text: _userModel?.email ?? 'Email ...',
                    icon: Iconz.email,
                  ),

                  /// PHONE
                  ProfileTile(
                    text: _userModel?.phone ?? 'Phone ...',
                    icon: Iconz.whatsapp,
                  ),


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

class ProfileTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ProfileTile({
    required this.text,
    required this.icon,
    this.onTap,
    super.key
  });
  // --------------------
  final String text;
  final dynamic icon;
  final Function? onTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// --------------------
    final double tileWidth = context.screenWidth * 0.7;
    // --------------------
    return SuperBox(
      height: 80,
      width: tileWidth,
      text: text,
      icon: icon,
      iconColor: Colorz.black255,
      iconSizeFactor: 0.5,
      color: Colorz.light1,
      textCentered: false,
      textColor: Colorz.black255,
      margins: const EdgeInsets.only(bottom: 10),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
