import 'package:clinic_q/controllers/clinic_info_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/model/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FlutterFireController extends GetxController {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  var isInitialized = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Firebase.initializeApp();
    isInitialized = true;
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }

  Future<int> makeAppointment(String clinicID, String clinicName) async {
    String currDate = DateFormat('ddMMyyyy').format(DateTime.now());
    String? userID = auth.currentUser?.uid;
    DocumentReference queueDocRef = firestore
        .collection('clinics')
        .doc(clinicID)
        .collection('Queues')
        .doc(currDate);

    DocumentReference clinicQueueDocRef = firestore
        .collection('clinics')
        .doc(clinicID)
        .collection('Queues')
        .doc(currDate)
        .collection("QueueInfos")
        .doc(userID);

    DocumentReference userDocRef = firestore
        .collection('users')
        .doc(userID)
        .collection('Queues')
        .doc(currDate);

    firestore.runTransaction((transaction) async {
      DocumentSnapshot queueSnapshot = await transaction.get(queueDocRef);
      DocumentSnapshot clinicQsnapshot =
          await transaction.get(clinicQueueDocRef);
      DocumentSnapshot userSnapshot = await transaction.get(userDocRef);

      int newTotalInQueue = 0;
      if (!queueSnapshot.exists) {
        print("Current Date's Queue does not exist");
        newTotalInQueue = 1;
        transaction.set(queueDocRef, {
          "currentQueue": 1,
          "totalInQueue": newTotalInQueue,
        });
      } else {
        newTotalInQueue = (queueSnapshot.data() as dynamic)['totalInQueue'] + 1;
        transaction.update(queueDocRef, {'totalInQueue': newTotalInQueue});

        print("Current Date's current totalInQueue: $newTotalInQueue");
      }

      Appointment newAppt = Appointment(
        clinicID: clinicID,
        clinicName: clinicName,
        queueNo: newTotalInQueue,
        userID: userID!,
        appointmentDate: DateTime.now(),
      );

      if (!clinicQsnapshot.exists) {
        transaction.set(
          clinicQueueDocRef,
          newAppt.toMap(),
        );
      }

      if (!userSnapshot.exists) {
        transaction.set(
          userDocRef,
          newAppt.toMap(),
        );
      }
      final userController = Get.find<UserController>();
      final clinicInfoController = Get.find<ClinicInfoController>();
      clinicInfoController.autoRefresh(clinicID);
      userController.createAppointment(newAppt);
    });

    return 0;
  }

  Future<int> deleteAppointment(String clinicID) async {
    String currDate = DateFormat('ddMMyyyy').format(DateTime.now());
    String? userID = auth.currentUser?.uid;

    DocumentReference clinicQueueDocRef = firestore
        .collection('clinics')
        .doc(clinicID)
        .collection('Queues')
        .doc(currDate)
        .collection("QueueInfos")
        .doc(userID);

    DocumentReference userDocRef = firestore
        .collection('users')
        .doc(userID)
        .collection('Queues')
        .doc(currDate);

    firestore.runTransaction((transaction) async {
      transaction.delete(clinicQueueDocRef);
      transaction.delete(userDocRef);

      final userController = Get.find<UserController>();

      userController.deleteAppointment(DateTime.now());
    });

    return 0;
  }
}
