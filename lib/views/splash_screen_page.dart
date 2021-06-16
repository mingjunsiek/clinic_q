import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:clinic_q/controllers/clinic_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/views/login_page.dart';
import 'package:clinic_q/views/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/size_helpers.dart';

class SplashScreenPage extends StatelessWidget {
  final userController = Get.find<UserController>();
  final clinicController = Get.put(ClinicController());

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: './assets/images/splash.jpg',
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      screenFunction: () async {
        clinicController.getClinicList();
        bool isLoggedIn = userController.isLogin();

        if (isLoggedIn) {
          await userController.getCurrentAppt();
          return TaskBarScreen();
        } else {
          return LoginPage();
        }
      },
      splashIconSize: displayWidth(context) * 0.7,
    );
  }
}
