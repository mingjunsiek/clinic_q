import 'package:clinic_q/controllers/clinic_info_controller.dart';
import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/model/appointment.dart';
import 'package:clinic_q/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late User user;
  final hasAppointment = false.obs;
  final appointmentHistory = List<Appointment>.empty().obs;
  final currentAppointment = Appointment(
          clinicName: "",
          clinicID: '',
          queueNo: -1,
          userID: '',
          appointmentDate: DateTime.now())
      .obs;

  final flutterFireController = Get.find<FlutterFireController>();
  final taskbarController = Get.find<TaskbarController>();
  final clinicInfoController = Get.find<ClinicInfoController>();

  bool isLogin() {
    if (flutterFireController.auth.currentUser != null) {
      print("Current User: ${flutterFireController.auth.currentUser}");
      return true;
    } else
      return false;
  }

  Future<void> updateUserDetails(
    String nric,
    String firstName,
    String lastName,
    String phone,
  ) {
    var currentUser = flutterFireController.auth.currentUser;
    late String uid;
    if (currentUser != null) {
      uid = currentUser.uid.toString();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
          'nric': nric,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateUserAllergies(
    String allergies,
  ) {
    var currentUser = flutterFireController.auth.currentUser;
    late String uid;
    if (currentUser != null) {
      uid = currentUser.uid.toString();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
          'allergies': allergies,
        })
        .then((value) => print("User Allergies Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> getUserDetails() async {
    String uid = flutterFireController.auth.currentUser!.uid.toString();
    await flutterFireController.firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot userData) {
      List<String> test = userData.data().toString().split(',');
      String allergy = test.elementAt(0);
      String firstName = test.elementAt(1);
      String lastName = test.elementAt(2);
      String phoneNo = test.elementAt(3);
      String dob1 = test.elementAt(4);
      //String dob2 = test.elementAt(5);
      String nric = test.elementAt(6);
      String email = test.elementAt(7);

      allergy = allergy.replaceAll("{", " ");
      allergy = allergy.substring(allergy.indexOf(":") + 1);
      allergy.trim();
      firstName = firstName.substring(firstName.indexOf(":") + 1);
      firstName.trim();
      lastName = lastName.substring(lastName.indexOf(":") + 1);
      lastName.trim();
      phoneNo = phoneNo.substring(phoneNo.indexOf(":") + 1);
      phoneNo.trim();
      dob1 = dob1.substring(dob1.indexOf("=") + 1);
      dob1.trim();
      String dobSec = dob1;
      //dob2 = dob2.substring(dob2.indexOf("=") + 1);
      //dob2.trim();
      //dob2 = dob2.replaceAll(")", " ");
      //String dobNSec = dob2;
      //Timestamp ts = Timestamp(int.parse(dobSec), int.parse(dobNSec));
      DateTime dob = DateTime(int.parse(dobSec));
      nric = nric.substring(nric.indexOf(":") + 1);
      nric.trim();
      email = email.replaceAll("}", " ");
      email = email.substring(email.indexOf(":") + 1);
      email.trim();

      user = User(
          allergies: allergy.trim(),
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          phone: phoneNo.trim(),
          dob: dob,
          nric: nric.trim(),
          email: email.trim());
    });
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

  void getUserInfo() async {
    String? userId = flutterFireController.auth.currentUser?.uid;
    await flutterFireController.firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print("User Info: ${documentSnapshot.data()}");
    });
  }

  Future<void> getCurrentAppt() async {
    String? userId = flutterFireController.auth.currentUser?.uid;
    await flutterFireController.firestore
        .collection('users')
        .doc(userId)
        .collection("Queues")
        .orderBy(
          'appointmentDate',
          descending: true,
        )
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((appt) {
        Appointment newAppt =
            Appointment.fromMap((appt.data() as Map<String, dynamic>));
        appointmentHistory.add(newAppt);
      });
    });

    if (appointmentHistory.length != 0 &&
        compareDate(appointmentHistory[0].appointmentDate, DateTime.now())) {
      hasAppointment.value = true;
      currentAppointment.value = appointmentHistory[0];
      print("Appointment History: ${appointmentHistory.length}");
      clinicInfoController.autoRefresh(currentAppointment.value.clinicID);
      taskbarController.updateToClinicInfo(currentAppointment.value.clinicID);
    } else {
      print("No Appointments Yet...");
    }
  }

  void createAppointment(Appointment newAppt) {
    hasAppointment.value = true;
    currentAppointment.value = newAppt;
    appointmentHistory.add(newAppt);
    print("Created Appointment in User Controller: ${appointmentHistory[0]}");
  }

  void deleteAppointment(DateTime apptDate) {
    hasAppointment.value = false;
    appointmentHistory
        .removeWhere((appt) => compareDate(appt.appointmentDate, apptDate));
    taskbarController.updateToMapPage();
  }

  bool compareDate(DateTime apptDateTime, DateTime selectedDateTime) {
    return apptDateTime.day == selectedDateTime.day &&
        apptDateTime.month == selectedDateTime.month &&
        apptDateTime.year == selectedDateTime.year;
  }

  Future<void> logout() async {
    await flutterFireController.auth.signOut();
  }
}
