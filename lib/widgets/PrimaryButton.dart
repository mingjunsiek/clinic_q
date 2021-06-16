import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback btnFunction;
  final String buttonText;
  final Color color;

  const PrimaryButton({
    Key? key,
    required this.btnFunction,
    required this.buttonText,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        onPressed: btnFunction,
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
