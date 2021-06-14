import 'package:clinic_q/utils/size_helpers.dart';
import 'package:flutter/material.dart';

class FormSpacing extends StatelessWidget {
  const FormSpacing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.03,
    );
  }
}
