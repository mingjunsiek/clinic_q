import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/model/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late User user;

  final flutterFireController = Get.find<FlutterFireController>();

  bool isLogin() {
    if (flutterFireController.auth.currentUser != null) {
      print(flutterFireController.auth.currentUser);
      return true;
    } else
      return false;
  }

  void updateUserInfo({
    required String nric,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required DateTime dob,
    required String allergies,
  }) {
    user = User(
      nric: nric,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      dob: dob,
      allergies: allergies,
    );
    print(user.toString());
  }

  Future<void> logout() async {
    await flutterFireController.auth.signOut();
  }
}
