import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/views/sign_up_page_allergies.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text('Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                            FormSpacing(),
                            Text('Personal Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 25,
                                )),
                            FormSpacing(),
                            FormTextField(
                              labelText: "NRIC",
                              fieldKeyboardType: TextInputType.visiblePassword,
                              validatorFunction: (value) => !isNRIC(value)
                                  ? "Please enter a valid NRIC"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              labelText: "First Name",
                              fieldKeyboardType: TextInputType.text,
                              validatorFunction: (value) => value.length == 0
                                  ? "Please enter your first name"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              labelText: "Last Name",
                              fieldKeyboardType: TextInputType.text,
                              validatorFunction: (value) => value.length == 0
                                  ? "Please enter your last name"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              labelText: "Phone",
                              fieldKeyboardType: TextInputType.phone,
                              validatorFunction: (value) => !isPhoneNum(value)
                                  ? "Please enter a valid phone number"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              labelText: "Date of Birth",
                              fieldKeyboardType: TextInputType.datetime,
                              validatorFunction: (value) => value.length <= 6
                                  ? "Please enter a your date of birth"
                                  : null,
                            ),
                            FormSpacing(),
                            PrimaryButton(
                              buttonText: 'Next',
                              btnFunction: () {
                                if (!_formKey.currentState!.validate()) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //       content: Text('Processing Data')),
                                  // );
                                  Get.to(() => SignUpPageAllergies());
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
    );
  }
}
