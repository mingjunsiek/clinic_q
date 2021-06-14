import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/views/home_page.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPagePassword extends StatefulWidget {
  SignUpPagePassword({Key? key}) : super(key: key);

  @override
  _SignUpPagePasswordState createState() => _SignUpPagePasswordState();
}

class _SignUpPagePasswordState extends State<SignUpPagePassword> {
  final _formKey = GlobalKey<FormState>();
  var confirmPass;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text('Sign Up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                              FormSpacing(),
                              Text('Password',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 25,
                                  )),
                            ],
                          ),
                          Container(
                            height: displayHeight(context) * 0.4,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                FormTextField(
                                  labelText: "Password",
                                  isPassword: true,
                                  validatorFunction: (value) {
                                    confirmPass = value;
                                    return value.length <= 6
                                        ? "Password must be 6 or more characters in length"
                                        : null;
                                  },
                                  fieldKeyboardType:
                                      TextInputType.visiblePassword,
                                ),
                                FormSpacing(),
                                FormTextField(
                                  labelText: "Confirm Password",
                                  isPassword: true,
                                  validatorFunction: (value) {
                                    if (value.length <= 6)
                                      return "Password must be 6 or more characters in length";
                                    else if (value != confirmPass)
                                      return "Password must be the same";
                                    else
                                      return null;
                                  },
                                  fieldKeyboardType:
                                      TextInputType.visiblePassword,
                                ),
                              ],
                            ),
                          ),
                          FormSpacing(),
                          Column(
                            children: [
                              PrimaryButton(
                                buttonText: 'Sign Up',
                                btnFunction: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Processing Data')));
                                    Get.to(() => HomePage());
                                  }
                                },
                              ),
                              // Spacer(),
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  "Back",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
