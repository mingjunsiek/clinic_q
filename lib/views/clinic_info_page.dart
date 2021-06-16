import 'package:clinic_q/controllers/clinic_controller.dart';
import 'package:clinic_q/controllers/clinic_info_controller.dart';
import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicInfoPage extends StatefulWidget {
  final clinicID;
  const ClinicInfoPage({
    Key? key,
    required this.clinicID,
  }) : super(key: key);
  @override
  _ClinicInfoPageState createState() => _ClinicInfoPageState();
}

class _ClinicInfoPageState extends State<ClinicInfoPage> {
  final taskbarController = Get.find<TaskbarController>();
  final flutterFireController = Get.find<FlutterFireController>();
  final userController = Get.find<UserController>();
  final clinicController = Get.find<ClinicController>();
  final clinicInfoController = Get.find<ClinicInfoController>();

  @override
  Widget build(BuildContext context) {
    final clinic = clinicController.getClinicDetails(widget.clinicID);

    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            clinic.clinicID,
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            clinic.clinicName,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Current Queue",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Obx(() => Text(
                                clinicInfoController.currentQueue.value
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        PrimaryButton(
                          btnFunction: () {},
                          buttonText: "Directions",
                          color: kDirectionBtnColor,
                        ),
                        FormSpacing(),
                        Obx(
                          () => userController.hasAppointment.value
                              ? PrimaryButton(
                                  btnFunction: () async {
                                    await flutterFireController
                                        .deleteAppointment(clinic.clinicID);
                                  },
                                  buttonText: "Cancel Appointment",
                                  color: kCancelBtnColor,
                                )
                              : PrimaryButton(
                                  btnFunction: () async {
                                    await flutterFireController.makeAppointment(
                                      clinic.clinicID,
                                      clinic.clinicName,
                                    );
                                  },
                                  buttonText: "Book Appointment",
                                  color: kPrimaryBtnColor,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if (!userController.hasAppointment.value) {
            taskbarController.updateToMapPage();
            return false;
          }
          return true;
        });
  }
}
