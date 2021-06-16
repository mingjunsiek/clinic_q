import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/model/appointment.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                "History",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                      itemCount: userController.appointmentHistory.length,
                      itemBuilder: (context, index) {
                        Appointment appt =
                            userController.appointmentHistory[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              appt.clinicName,
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(appt.appointmentDate),
                              style: TextStyle(color: kUnselectedColor),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Queue No.",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Container(
                                  width: displayWidth(context) * 0.05,
                                ),
                                Text(
                                  appt.queueNo.toString(),
                                  style: TextStyle(color: kUnselectedColor),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
