import 'package:clinic_q/controllers/clinic_controller.dart';
import 'package:clinic_q/model/clinic.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:get/get.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final clinicController = Get.find<ClinicController>();

  PanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Clinic> clinicList = clinicController.clinicList;

    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        Container(
          height: 5.0,
          width: 30.0,
          color: kPrimaryBtnColor,
        ),
        Expanded(
          child: ListView.builder(
              controller: controller,
              itemCount: clinicList.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  onTap: () {},
                  // leading: Text(
                  //   'Leading',
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  leading: FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      width: displayWidth(context) * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${clinicList[index].clinicName}',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            '${clinicList[index].streetName}',
                            style: TextStyle(color: kUnselectedColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  trailing: Column(
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
                ));
              }),
        ),
      ],
    );
  }
}
