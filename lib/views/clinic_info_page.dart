import 'package:clinic_q/utils/constants.dart';
import 'package:flutter/material.dart';

class ClinicInfoPage extends StatelessWidget {
  const ClinicInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            child: Text(
              "Clinic Info Page",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
