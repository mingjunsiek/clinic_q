import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/views/allergies_page.dart';
import 'package:clinic_q/views/personal_info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
                child: Container(
                  color: Colors.grey,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
          ),
          body: ProfileLayout(),
        ),
      ),
    );
  }
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _profileView(context);
  }
}

Widget _profileView(BuildContext context) {
  final taskbarController = Get.find<TaskbarController>();
  return ListView(
    children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          leading: Icon(Icons.person),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            'Person Information',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            taskbarController.updatePageIndex(Navigation.personalEnum.index);
          },
        ),
        ListTile(
          leading: Icon(Icons.sick),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            'Allergies',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            taskbarController.updatePageIndex(Navigation.allergiesEnum.index);
          },
        ),
      ],
    ).toList(),
  );
}
