import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await userController.logout();
                    Get.offAll(LoginPage());
                  },
                  child: Text("Log Out"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
