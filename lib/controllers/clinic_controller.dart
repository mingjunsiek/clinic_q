import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/model/clinic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  final flutterFireController = Get.find<FlutterFireController>();

  late List<Clinic> clinicList = <Clinic>[];

  void getClinicList() async {
    await flutterFireController.firestore
        .collection('clinics')
        .limit(10)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Clinic clinic = Clinic.fromMap(doc['clinicInfo']);
        clinic.clinicID = doc.id;
        clinicList.add(clinic);
      });

      clinicList.forEach((element) {
        print(element.toString());
      });
    });
  }
}
