import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFFFFFF);
// const kPrimaryLightColor = Color(0xFFFFECDF);
const kTextFieldColor = Color(0xFF000000);
const kTextFormFieldColor = Color(0xFFF0F5FE);
const kPrimaryBtnColor = Color(0xFFC08E5F);
const kDirectionBtnColor = Color(0xFF1B74E8);
const kEditBtnColor = Color(0xFFAB7A76);
const kCancelBtnColor = Color(0xFFF44336);
const kUnselectedColor = Color(0xFFD8D2CF);
// const kUnselectedTextColor = Color(0xFFA7A19E);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
// );
const defaultPadding = 15.00;

const loginBackgroundImg = 'assets/images/Login_Background.jpg';

const profile_page_index = 2;

bool isEmail(String value) {
  String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(regex);

  return value.isNotEmpty && regExp.hasMatch(value);
}

bool isNRIC(String value) {
  String regex = r'[STFG]\d{7}[A-Z]$';
  RegExp regExp = new RegExp(regex);

  return value.isNotEmpty && regExp.hasMatch(value.toUpperCase());
}

bool isPhoneNum(String value) {
  String regex = r'[89]\d{7}$';
  RegExp regExp = new RegExp(regex);

  return value.isNotEmpty && regExp.hasMatch(value);
}
