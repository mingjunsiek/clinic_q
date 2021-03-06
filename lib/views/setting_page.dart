import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final userController = Get.find<UserController>();
  final taskbarController = Get.find<TaskbarController>();
  @override
  Widget build(BuildContext context) {
    userController.getUserInfo();

    return Container(
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Settings',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.grey,
                    height: 1.0,
                  ),
                  preferredSize: Size.fromHeight(1.0)),
            ),
            // body: _settingsView(),
            body: SettingsView()),
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _settingsView(context);
  }
}

Widget _settingsView(BuildContext context) {
  final userController = Get.find<UserController>();
  final taskbarController = Get.find<TaskbarController>();
  return ListView(
    children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          leading: Icon(Icons.person),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            taskbarController.updatePageIndex(Navigation.profileEnum.index);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () async {
            await userController.logout();
            Get.offAll(LoginPage());
          },
        ),
      ],
    ).toList(),
  );
}
