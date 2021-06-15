import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:clinic_q/views/sign_up_page_personal.dart';
import 'package:clinic_q/views/taskbar.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late final TextEditingController _emailController;
  // late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   _emailController = TextEditingController();
  //   _passwordController = TextEditingController();

  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _emailController.dispose()
  //   _passwordController.dispose()
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginBackgroundImg),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Text('Welcome to',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  FormSpacing(),
                  Text('ClinicQ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 25,
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              height: displayHeight(context) * 0.4,
                            ),
                            FormTextField(
                              labelText: "NRIC",
                              fieldKeyboardType: TextInputType.visiblePassword,
                              validatorFunction: (value) => !isNRIC(value)
                                  ? "Please enter a valid NRIC"
                                  : null,
                            ),

                            FormSpacing(),
                            FormTextField(
                              labelText: "Password",
                              fieldKeyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              validatorFunction: (value) => value.length <= 6
                                  ? "Password must be 6 or more characters in length"
                                  : null,
                            ),
                            FormSpacing(),
                            PrimaryButton(
                              buttonText: 'Login',
                              btnFunction: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Processing Data')));
                                  Get.to(() => TaskBarScreen());
                                }
                              },
                            ),
                            // Spacer(),
                            TextButton(
                              onPressed: () =>
                                  Get.to(() => SignUpPagePersonal()),
                              child: Text(
                                "Sign Up",
                              ),
                            ),
                            // TextField(),
                          ],
                        ),
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
