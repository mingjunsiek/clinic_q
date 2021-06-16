import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/model/clinic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  final flutterFireController = Get.find<FlutterFireController>();
  List<Clinic> initialClinicList = [];
  final clinicList = List<Clinic>.empty().obs;

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
      initialClinicList = List.from(clinicList);
      // clinicList.forEach((element) {
      //   print(element.toString());
      // });
    });
  }

  void filterClinicList(String clinicName) {
    print("CHANGE: $clinicName");

    if (clinicName == "") {
      resetFilter();
    } else {
      clinicList.value = clinicList
          .where((clinic) => clinic.clinicName
              .toLowerCase()
              .contains(clinicName.toLowerCase()))
          .toList();
    }

    print(clinicList.length);
  }

  Clinic getClinicDetails(String clinicID) {
    return clinicList.firstWhere((clinic) => clinic.clinicID == clinicID);
  }

  void resetFilter() {
    clinicList.value = initialClinicList;
  }
}
