import 'package:clinic_q/controllers/signup_controller.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/views/sign_up_page_allergies.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpPagePersonal extends StatefulWidget {
  const SignUpPagePersonal({Key? key}) : super(key: key);

  @override
  _SignUpPagePersonalState createState() => _SignUpPagePersonalState();
}

class _SignUpPagePersonalState extends State<SignUpPagePersonal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nricController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime currentDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    _nricController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());

    void _presentDatePicker() async {
      FocusScope.of(context).requestFocus(new FocusNode());
      await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now())
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
        // print(_dateController.text);
        currentDate = pickedDate;
        print(currentDate);
      });
    }

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
                              controller: _nricController,
                              fieldKeyboardType: TextInputType.visiblePassword,
                              validatorFunction: (value) => !isNRIC(value)
                                  ? "Please enter a valid NRIC"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              labelText: "First Name",
                              controller: _firstNameController,
                              fieldKeyboardType: TextInputType.text,
                              validatorFunction: (value) => value.length == 0
                                  ? "Please enter your first name"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              labelText: "Last Name",
                              controller: _lastNameController,
                              fieldKeyboardType: TextInputType.text,
                              validatorFunction: (value) => value.length == 0
                                  ? "Please enter your last name"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              labelText: "Phone",
                              controller: _phoneController,
                              fieldKeyboardType: TextInputType.phone,
                              validatorFunction: (value) => !isPhoneNum(value)
                                  ? "Please enter a valid phone number"
                                  : null,
                            ),
                            FormSpacing(),
                            FormTextField(
                              controller: _dateController,
                              labelText: "Date of Birth",
                              textFormFieldTapped: _presentDatePicker,
                              fieldKeyboardType: TextInputType.datetime,
                              validatorFunction: (value) => value ==
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.now())
                                  ? "Please enter a valid date of birth"
                                  : null,
                            ),
                            FormSpacing(),
                            PrimaryButton(
                              buttonText: 'Next',
                              btnFunction: () {
                                if (_formKey.currentState!.validate()) {
                                  signUpController.setPersonal(
                                    ic: _nricController.text,
                                    fName: _firstNameController.text,
                                    lName: _lastNameController.text,
                                    phone: _phoneController.text,
                                    date: currentDate,
                                  );
                                  print(_nricController.text);
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
