import 'package:flutter/material.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/widgets/OverviewCard.dart';

class ConfirmationPanel extends StatelessWidget {
  final ScrollController controller;

  const ConfirmationPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        OverviewCard({
          'Queue': '5 people ahead',
        }),
        OverviewCard({
          'Contact': '12345678',
          'Address': '131 MARSLING RISE, #02-313, 784833',
          'Clinic': 'Clinic ABC',
        }),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              ),
              child: Text(
                'Directions',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              ),
              child: Text(
                'Cancel Appointment',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
