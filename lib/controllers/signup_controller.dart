import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var nric = '';
  var firstName = '';
  var lastName = '';
  var phone = '';
  var dob;
  var email = '';
  var password = '';
  var allergies = '';
  // var blockNo = ''.obs;
  // var streetName = ''.obs;
  // var unitNo = ''.obs;
  // var postalCode = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  final flutterFireController = Get.find<FlutterFireController>();
  final userController = Get.put(UserController());

  void setPersonal(
      {required String ic,
      required String fName,
      required String lName,
      required String phone,
      required DateTime date}) {
    nric = ic.trim();
    firstName = fName.trim();
    lastName = lName.trim();
    phone = phone.trim();
    dob = date;
    print(nric);
    print(fName);
    print(lName);
    print(phone);
    print(date);
  }

  void setAllergies(String allergies) {
    allergies = allergies.trim();
    print(allergies);
  }

  Future<String> createAccount({
    required String email,
    required String password,
  }) async {
    email = email.trim();
    password = password;

    try {
      UserCredential userCredential = await flutterFireController.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.toString());

      await flutterFireController.firestore
          .collection("users")
          .doc(userCredential.user?.uid)
          .set({
            nric: nric,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            dob: dob.millisecondsSinceEpoch,
            email: email,
            allergies: allergies
          })
          .then((value) => print("User's Details Added"))
          .catchError((error) => print("Failed to add user: $error"));

      userController.updateUserInfo(
          nric: nric,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          dob: dob,
          email: email,
          allergies: allergies);

      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      }
      return e.message!;
    } catch (e) {
      return "An unexpected error occured";
    }
  }
}
