import 'package:flutter/material.dart';
import 'package:clinic_q/utils/constants.dart';

class OverviewCard extends StatelessWidget {
  var overviewInformation = new Map<String, dynamic>();

  OverviewCard(this.overviewInformation);

  List<Widget> getInformations() {
    List<Widget> widgetList = [];

    overviewInformation.forEach((key, value) {
      widgetList.add(Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 15.0, right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '$key:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ));
    });
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Card(
        child: Column(
          children: getInformations(),
        ),
      ),
    );
  }
}
