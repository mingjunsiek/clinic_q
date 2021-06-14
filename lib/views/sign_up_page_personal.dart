import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPagePersonal extends StatefulWidget {
  const SignUpPagePersonal({Key? key}) : super(key: key);

  @override
  _SignUpPagePersonalState createState() => _SignUpPagePersonalState();
}

class _SignUpPagePersonalState extends State<SignUpPagePersonal> {
  final _formKey = GlobalKey<FormState>();

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
                    Text('Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25,
                        )),
                    Text('Personal Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                        )),
                    Expanded(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.none,
                        child: Form(
                          child: Column(
                            children: [
                              Container(
                                height: displayHeight(context) * 0.4,
                              ),
                              FormTextField(
                                labelText: "NRIC",
                                fieldKeyboardType:
                                    TextInputType.visiblePassword,
                                validatorFunction: (value) => !isEmail(value)
                                    ? "Sorry, we do not recognize this email address"
                                    : null,
                              ),
                              FormSpacing(),
                              FormTextField(
                                labelText: "Password",
                                fieldKeyboardType:
                                    TextInputType.visiblePassword,
                                isPassword: true,
                                validatorFunction: (value) => value.length <= 6
                                    ? "Password must be 6 or more characters in length"
                                    : null,
                              ),
                              FormSpacing(),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFC08E5F),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Processing Data')));
                                    }
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              // Spacer(),
                              TextButton(
                                onPressed: () => Get.back(),
                                child: Text(
                                  "Back",
                                ),
                              ),
                              // TextField(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
