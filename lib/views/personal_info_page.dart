import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/model/user.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:get/get.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formEditKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();
  final taskbarController = Get.find<TaskbarController>();

  TextEditingController _nricController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nricController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
  }

  TextEditingController _updateText(
      TextEditingController controller, String text) {
    controller.text = text;
    return controller;
  }

  User cu = new User(
      nric: " ",
      email: " ",
      firstName: " ",
      lastName: " ",
      phone: " ",
      dob: DateTime.now(),
      allergies: " ");

  Future<User> currentUser() async {
    await userController.getUserDetails().whenComplete(() => cu = User(
        nric: userController.user.nric,
        email: userController.user.email,
        firstName: userController.user.firstName,
        lastName: userController.user.lastName,
        phone: userController.user.phone,
        dob: userController.user.dob,
        allergies: userController.user.allergies));
    return cu;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Personal Information',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
                child: Container(
                  color: Colors.grey,
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
          ),
          body: FutureBuilder(
            future: currentUser(),
            builder: (BuildContext context, AsyncSnapshot<User> curr) => curr
                    .hasData
                ? SingleChildScrollView(
                    child: Container(
                        margin:
                            const EdgeInsets.only(right: 20, left: 20, top: 30),
                        child: Form(
                          key: _formEditKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: _updateText(
                                    _nricController, curr.data!.nric),
                                //initialValue: curr.data!.nric,
                                decoration: InputDecoration(
                                  labelText: 'NRIC',
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                validator: (value) => !isNRIC(value as String)
                                    ? "Please enter a valid NRIC"
                                    : null,
                              ),
                              FormSpacing(),
                              TextFormField(
                                controller: _updateText(
                                    _firstNameController, curr.data!.firstName),
                                //initialValue: curr.data?.firstName,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'First name cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                              FormSpacing(),
                              TextFormField(
                                controller: _updateText(
                                    _lastNameController, curr.data!.lastName),
                                //initialValue: curr.data?.lastName,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Last name cannot be empty!';
                                  }
                                  return null;
                                },
                              ),
                              FormSpacing(),
                              TextFormField(
                                controller: _updateText(
                                    _phoneController, curr.data!.phone),
                                //initialValue: curr.data?.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone No.',
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                validator: (value) =>
                                    !isPhoneNum(value as String)
                                        ? "Please enter a valid phone number"
                                        : null,
                              ),
                              FormSpacing(),
                              PrimaryButton(
                                btnFunction: () {
                                  if (_formEditKey.currentState!.validate()) {
                                    userController.updateUserDetails(
                                      _nricController.text.trim(),
                                      _firstNameController.text.trim(),
                                      _lastNameController.text.trim(),
                                      _phoneController.text.trim(),
                                    );
                                    taskbarController.updatePageIndex(
                                        Navigation.settingEnum.index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('User Details Updated')));
                                  }
                                },
                                buttonText: "Confirm",
                                color: kPrimaryBtnColor,
                              ),
                              FormSpacing(),
                              PrimaryButton(
                                btnFunction: () {
                                  taskbarController.updatePageIndex(
                                      Navigation.settingEnum.index);
                                },
                                buttonText: "Cancel",
                                color: kCancelBtnColor,
                              ),
                            ],
                          ),
                        )))
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }
}
