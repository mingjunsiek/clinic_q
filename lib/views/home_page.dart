import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent, //should be transparent
        body: SafeArea(
          child: Column(
            children: [
              Text(
                'home',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
