import 'package:clinic_q/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/widgets/GoogleMapWidget.dart';
import 'package:clinic_q/widgets/OverviewCard.dart';
import 'package:get/get.dart';

class ClinicInfoPage extends StatelessWidget {
  const ClinicInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBooked = false.obs;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Clinic Title',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 300.0,
              padding: EdgeInsets.all(defaultPadding),
              child: Container(
                child: GoogleMapWidget(
                  clinicId: 1,
                  clinicName: 'clinic ABC',
                  streetName: 'Marsling 748',
                  lat: 1.4256814230789063,
                  lng: 103.83264571014811,
                ),
              ),
            ),
            OverviewCard({
              'Current Queue Number': 5.toString(),
              'Your Number': 10.toString(),
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
            (isBooked())
                ? SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(15)),
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
                : SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryBtnColor),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(15)),
                        ),
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
