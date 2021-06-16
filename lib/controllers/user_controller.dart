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
          clinicID: '',
          queueNo: -1,
          userID: '',
          appointmentDate: DateTime.now())
      .obs;
  final flutterFireController = Get.find<FlutterFireController>();
  final taskbarController = Get.find<TaskbarController>();

  bool isLogin() {
    if (flutterFireController.auth.currentUser != null) {
      print("Current User: ${flutterFireController.auth.currentUser}");
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
      print("There is a current appointment...");
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
