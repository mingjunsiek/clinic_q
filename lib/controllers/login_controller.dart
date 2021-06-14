import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLogin();
  }

  void isLogin() {}

  Future<bool> login() async {
    return false;
  }
}
