import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  String nric = '';
  String firstName = '';
  String lastName = '';
  String phone = '';
  late DateTime dob;
  String email = '';
  String password = '';
  String allergies = '';
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
      {required String inputNRIC,
      required String inputFirstName,
      required String inputLastName,
      required String inputPhone,
      required DateTime inputDate}) {
    nric = inputNRIC;
    firstName = inputFirstName;
    lastName = inputLastName;
    phone = inputPhone;
    dob = inputDate;
  }

  void setAllergies(String inputAllergy) {
    allergies = inputAllergy;
    print(allergies);
  }

  Future<String> createAccount({
    required String inputEmail,
    required String inputPassword,
  }) async {
    email = inputEmail;
    password = inputPassword;
    UserCredential userCredential;

    try {
      userCredential = await flutterFireController.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      }
      return e.message!;
    } catch (e) {
      return "An unexpected error occured while adding user to firestore";
    }

    await flutterFireController.firestore
        .collection("users")
        .doc(userCredential.user?.uid)
        .set({
          "nric": nric,
          "firstName": firstName,
          "lastName": lastName,
          "phone": phone,
          "dob": Timestamp.fromDate(dob),
          "email": email,
          "allergies": allergies
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
  }
}
