import 'package:get/get.dart';

class TaskbarController extends GetxController {
  final currentIndex = 0.obs;
  final pageWidgetIndex = 0.obs;

  Map<int, int> pageList = {
    0: 0,
    1: 1,
    2: 1,
  };

  void updatePageIndex(int updatedIndex) {
    currentIndex.value = pageList[updatedIndex]!;
    pageWidgetIndex.value = updatedIndex;
  }
}
