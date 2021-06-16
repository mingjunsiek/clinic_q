import 'package:clinic_q/controllers/clinic_controller.dart';
import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/model/clinic.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:get/get.dart';

class NearbyClinicPanel extends StatelessWidget {
  final ScrollController controller;
  final clinicController = Get.find<ClinicController>();
  final taskbarController = Get.find<TaskbarController>();

  NearbyClinicPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kUnselectedColor,
          ),
          height: 5.0,
          width: 30.0,
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
                controller: controller,
                itemCount: clinicController.clinicList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          onTap: () {
                            taskbarController.updateToClinicInfo("test");
                          },
                          leading: FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              width: displayWidth(context) * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${clinicController.clinicList[index].clinicName}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    '${clinicController.clinicList[index].streetName}',
                                    style: TextStyle(color: kUnselectedColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Current Queue",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "5/25",
                                style: TextStyle(color: kUnselectedColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}