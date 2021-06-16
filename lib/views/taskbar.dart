import 'package:clinic_q/controllers/taskbar_controller.dart';

import 'package:clinic_q/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskBarScreen extends StatefulWidget {
  const TaskBarScreen({Key? key}) : super(key: key);

  @override
  _TaskBarScreenState createState() => _TaskBarScreenState();
}

class _TaskBarScreenState extends State<TaskBarScreen> {
  // int pageIndex = 0;

  final taskbarController = Get.find<TaskbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => taskbarController
          .widgetList[taskbarController.pageWidgetIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: taskbarController.currentIndex.value,
            onTap: (value) {
              taskbarController.updatePageIndex(value);
            },
            selectedItemColor: kPrimaryBtnColor,
            // backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          )),
    );
  }
}
