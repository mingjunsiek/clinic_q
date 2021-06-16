import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClinicInfoController extends GetxController {
  final flutterFireController = Get.find<FlutterFireController>();

  final currentQueue = 0.obs;
  final totalQueue = 0.obs;

  Future<void> autoRefresh(String clinicID) async {
    String currDate = DateFormat('ddMMyyyy').format(DateTime.now());
    DocumentSnapshot snapshot = await flutterFireController.firestore
        .collection('clinics')
        .doc(clinicID)
        .collection('Queues')
        .doc(currDate)
        .get();

    if (snapshot.exists) {
      currentQueue.value = (snapshot.data() as dynamic)['currentQueue'];
      totalQueue.value = (snapshot.data() as dynamic)['totalInQueue'];

      final Stream<DocumentSnapshot> _queueStream = flutterFireController
          .firestore
          .collection('clinics')
          .doc(clinicID)
          .collection('Queues')
          .doc(currDate)
          .snapshots();

      _queueStream.listen((DocumentSnapshot doc) {
        int queue = (doc.data() as dynamic)['currentQueue'];
        int totalQ = (doc.data() as dynamic)['totalInQueue'];
        if (queue != currentQueue.value) {
          currentQueue.value = queue;
          totalQueue.value = totalQ;
        }
      });
    } else {
      currentQueue.value = 0;
      totalQueue.value = 0;
    }
  }

  // Future<void> autoRefresh(String clinicID) async {
  //   String currDate = DateFormat('ddMMyyyy').format(DateTime.now());
  //   final Stream<DocumentSnapshot> _queueStream = flutterFireController
  //       .firestore
  //       .collection('clinics')
  //       .doc(clinicID)
  //       .collection('Queues')
  //       .doc(currDate)
  //       .snapshots();

  //   _queueStream.listen((DocumentSnapshot doc) {
  //     int queue = (doc.data() as dynamic)['currentQueue'];
  //     if (queue != currentQueue.value) {
  //       currentQueue.value = queue;
  //     }
  //   });
  // }
}
