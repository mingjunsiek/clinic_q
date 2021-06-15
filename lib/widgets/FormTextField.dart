import 'package:clinic_q/utils/constants.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    this.labelText,
    this.isPassword = false,
    this.validatorFunction,
    this.controller,
    this.fieldKeyboardType,
    this.maxLine = 1,
  }) : super(key: key);

  final labelText;
  final isPassword;
  final validatorFunction;
  final controller;
  final fieldKeyboardType;
  final maxLine;

  @override
  Widget build(BuildContext context) {
    final customInputBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    );
    return
        // Container(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: defaultPadding,
        //   ),
        //   decoration: BoxDecoration(
        //     // color: kTextFormFieldColor,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.3),
        //         spreadRadius: 1,
        //         blurRadius: 5,
        //         offset: Offset(0, 3), // changes position of shadow
        //       ),
        //     ],
        //     // borderRadius: BorderRadius.circular(10),
        //   ),
        Material(
      color: Colors.transparent,
      elevation: 18,
      shadowColor: Colors.grey[50],
      borderRadius: BorderRadius.circular(20),
      child: TextFormField(
        keyboardType: fieldKeyboardType,
        validator: validatorFunction,
        obscureText: isPassword ? true : false,
        style: TextStyle(color: Colors.black),
        maxLines: maxLine,
        decoration: InputDecoration(
          border: customInputBorder,
          focusedBorder: customInputBorder,
          enabledBorder: customInputBorder,
          errorBorder: customInputBorder,
          filled: true,
          fillColor: kTextFormFieldColor,
          labelStyle: TextStyle(
            color: kTextFieldColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
