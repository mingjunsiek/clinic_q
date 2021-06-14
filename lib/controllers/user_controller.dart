import 'package:get/get.dart';

class UserController extends GetxController {
  var email = ''.obs;
  var username = ''.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> logout() async {
    return false;
  }
}
