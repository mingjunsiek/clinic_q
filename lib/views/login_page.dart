import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/utils/size_helpers.dart';
import 'package:flutter/material.dart';

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Text('Welcome to',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25,
                      )),
                  Text('ClinicQ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 30,
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
                              labelText: "Email",
                              validatorFunction: (value) => !isEmail(value)
                                  ? "Sorry, we do not recognize this email address"
                                  : null,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.03,
                            ),

                            FormTextField(
                              labelText: "Password",
                              isPassword: true,
                              validatorFunction: (value) => value.length <= 6
                                  ? "Password must be 6 or more characters in length"
                                  : null,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.03,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFC08E5F),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Processing Data')));
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
                              onPressed: () {},
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

bool isEmail(String value) {
  String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(regex);

  return value.isNotEmpty && regExp.hasMatch(value);
}

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    this.labelText,
    this.isPassword = false,
    this.validatorFunction,
    this.controller,
  }) : super(key: key);

  final labelText;
  final isPassword;
  final validatorFunction;
  final controller;

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
        validator: validatorFunction,
        obscureText: isPassword ? true : false,
        style: TextStyle(color: Colors.black),
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
            fontSize: 20,
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
