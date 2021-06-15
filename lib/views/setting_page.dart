import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clinic_q/views/profile_page.dart';

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
          body: ListView(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
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
          ),
        ),
      ),
    );
  }
}
