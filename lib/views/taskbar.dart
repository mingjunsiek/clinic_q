import 'package:clinic_q/views/home_page.dart';
import 'package:clinic_q/views/setting_page.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskBarScreen extends StatefulWidget {
  const TaskBarScreen({Key? key}) : super(key: key);

  @override
  _TaskBarScreenState createState() => _TaskBarScreenState();
}

class _TaskBarScreenState extends State<TaskBarScreen> {
  int pageIndex = 0.obs();
  List<Widget> pageList = <Widget>[
    HomePage(),
    SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        selectedItemColor: kPrimaryBtnColor,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
