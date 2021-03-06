import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/views/taskbar.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPageAccount extends StatefulWidget {
  SignUpPageAccount({Key? key}) : super(key: key);

  @override
  _SignUpPageAccountState createState() => _SignUpPageAccountState();
}

class _SignUpPageAccountState extends State<SignUpPageAccount> {
  final signUpController = Get.find<SignUpController>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var confirmPass;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

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
                              Text('Account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 25,
                                  )),
                            ],
                          ),
                          Container(
                            height: displayHeight(context) * 0.3,
                            child: Image(
                                image:
                                    AssetImage('./assets/images/Account.jpg')),
                          ),
                          FormSpacing(),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                FormTextField(
                                  labelText: "Email",
                                  controller: _emailController,
                                  validatorFunction: (value) => !isEmail(value)
                                      ? "Please enter a valid Email"
                                      : null,
                                  fieldKeyboardType: TextInputType.emailAddress,
                                ),
                                FormSpacing(),
                                FormTextField(
                                  labelText: "Password",
                                  controller: _passwordController,
                                  isPassword: true,
                                  validatorFunction: (value) {
                                    confirmPass = value;
                                    return value.length < 6
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
                                    if (value.length < 6)
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
                                color: kPrimaryBtnColor,
                                btnFunction: () async {
                                  if (_formKey.currentState!.validate()) {
                                    String result =
                                        await signUpController.createAccount(
                                      inputEmail: _emailController.text.trim(),
                                      inputPassword:
                                          _passwordController.text.trim(),
                                    );
                                    if (result == "") {
                                      Get.to(() => TaskBarScreen());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(result)));
                                    }

                                    // Get.to(() => HomePage());
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
