import 'package:flutter/material.dart';
import 'package:clinic_q/utils/constants.dart';

class NearbyClinicPanel extends StatelessWidget {
  final ScrollController controller;

  const NearbyClinicPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(10, (i) => "Item $i");

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
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  onTap: () {},
                  title: Text(
                    '${items[index]}',
                    style: TextStyle(color: Colors.black),
                  ),
                ));
              }),
        ),
      ],
    );
  }
}
