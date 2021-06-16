import 'package:clinic_q/controllers/signup_controller.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/views/sign_up_page_account.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPageAllergies extends StatefulWidget {
  @override
  _SignUpPageAllergiesState createState() => _SignUpPageAllergiesState();
}

class _SignUpPageAllergiesState extends State<SignUpPageAllergies> {
  final signUpController = Get.find<SignUpController>();

  TextEditingController _allergiesController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _allergiesController.dispose();
  }

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
                          controller: _allergiesController,
                          fieldKeyboardType: TextInputType.visiblePassword,
                        ),
                        FormSpacing(),
                        Column(
                          children: [
                            PrimaryButton(
                                buttonText: 'Next',
                                color: kPrimaryBtnColor,
                                btnFunction: () {
                                  signUpController.setAllergies(
                                      _allergiesController.text.trim());
                                  Get.to(() => SignUpPageAccount());
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
