import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback btnFunction;
  final String buttonText;

  const PrimaryButton({
    Key? key,
    required this.btnFunction,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFC08E5F),
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
