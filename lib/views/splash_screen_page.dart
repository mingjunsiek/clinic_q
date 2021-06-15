import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/views/login_page.dart';
import 'package:clinic_q/views/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/size_helpers.dart';

class SplashScreenPage extends StatelessWidget {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: './assets/images/Login_Background.jpg',
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 2000,
      screenFunction: () async {
        bool isLoggedIn = userController.isLogin();
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await permissionController.checkPermissionStatus();
        // if (permissionController.locationPermissionGranted.value == false ||
        //     permissionController.bluetoothStatus.value == false)
        //   return PermissionPage();
        // else {
        //   if (prefs.getBool('initial') == true)
        //     return SelectionPage();
        //   else
        //     return OnboardingPage();
        // }
        if (isLoggedIn) {
          return TaskBarScreen();
        } else {
          return LoginPage();
        }
      },
      splashIconSize: displayWidth(context),
    );
  }
}
