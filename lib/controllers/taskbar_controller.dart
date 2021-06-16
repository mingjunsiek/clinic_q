import 'package:clinic_q/views/clinic_info_page.dart';
import 'package:clinic_q/views/mapscreen_page.dart';
import 'package:clinic_q/views/profile_page.dart';
import 'package:clinic_q/views/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskbarController extends GetxController {
  final currentIndex = 0.obs;
  final pageWidgetIndex = 0.obs;
  List<Widget> widgetList = <Widget>[
    MapScreen(),
    SettingPage(),
    ProfilePage(),
  ].obs;

  Map<int, int> pageList = {
    0: 0,
    1: 1,
    2: 1,
  };

  void updatePageIndex(int updatedIndex) {
    currentIndex.value = pageList[updatedIndex]!;
    pageWidgetIndex.value = updatedIndex;
  }

  void updateToClinicInfo(String selectedID) {
    widgetList[0] = ClinicInfoPage(
      clinicID: selectedID,
    );
  }

  void updateToMapPage() {
    widgetList[0] = MapScreen();
  }
}
