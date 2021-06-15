import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/views/sign_up_page_password.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPageAllergies extends StatefulWidget {
  SignUpPageAllergies({Key? key}) : super(key: key);

  @override
  _SignUpPageAllergiesState createState() => _SignUpPageAllergiesState();
}

class _SignUpPageAllergiesState extends State<SignUpPageAllergies> {
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
                    child: Column(
                      children: [
                        Text('Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            )),
                        FormSpacing(),
                        Text(
                          'Allergies',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        Container(
                          height: displayHeight(context) * 0.4,
                        ),
                        FormTextField(
                          labelText: "Input your allergies if any...",
                          maxLine: 4,
                          // validatorFunction: null,
                          fieldKeyboardType: TextInputType.visiblePassword,
                        ),
                        FormSpacing(),
                        Column(
                          children: [
                            PrimaryButton(
                                buttonText: 'Next',
                                btnFunction: () {
                                  Get.to(() => SignUpPagePassword());
                                }),
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
    );
  }
}
