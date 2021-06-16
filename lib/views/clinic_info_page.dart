import 'package:clinic_q/controllers/clinic_controller.dart';
import 'package:clinic_q/controllers/clinic_info_controller.dart';
import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/widgets/GoogleMapWidget.dart';
import 'package:clinic_q/widgets/OverviewCard.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  clinic.clinicName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FormSpacing(),
                Container(
                  height: 300.0,
                  child: Container(
                    child: GoogleMapWidget(
                      clinicId: clinic.clinicID,
                      clinicName: clinic.clinicName.toString(),
                      streetName: clinic.streetName.toString(),
                      lat: clinic.lat,
                      lng: clinic.lng,
                    ),
                  ),
                ),
                Obx(
                  () => OverviewCard({
                    'Current Queue Number':
                        clinicInfoController.currentQueue.value.toString(),
                  }),
                ),
                Obx(
                  () => userController.hasAppointment.value
                      ? OverviewCard({
                          'Your Queue Number': userController
                              .currentAppointment.value.queueNo
                              .toString(),
                        })
                      : Container(),
                ),
                OverviewCard({
                  'Contact': clinic.clinicTelNo,
                  'Address':
                      'Block ${clinic.blkHseNo} ${clinic.streetName}, ${clinic.floorNo}-${clinic.unitNo}\nSingapore ${clinic.postalCode}'
                          .toUpperCase(),
                }),
                FormSpacing(),
                PrimaryButton(
                  btnFunction: () async {
                    final availableMaps = await MapLauncher.installedMaps;
                    print(
                        availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
                    await availableMaps.first.showDirections(
                        destination: Coords(clinic.lat, clinic.lng),
                        destinationTitle: clinic.clinicName);
                  },
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
          ),
        ),
      ),
      onWillPop: () async {
        if (!userController.hasAppointment.value) {
          taskbarController.updateToMapPage();
          return false;
        }
        return true;
      },
    );
  }
}

// onWillPop: () async {
//           if (!userController.hasAppointment.value) {
//             taskbarController.updateToMapPage();
//             return false;
//           }
//           return true;
//         });