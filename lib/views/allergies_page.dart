import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/model/user.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({Key? key}) : super(key: key);

  @override
  _AllergiesPageState createState() => _AllergiesPageState();
}

class _AllergiesPageState extends State<AllergiesPage> {
  final _formEditKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();

  TextEditingController _allergiesController = TextEditingController();
  final taskbarController = Get.find<TaskbarController>();

  @override
  void dispose() {
    super.dispose();
    _allergiesController.dispose();
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
                'Allergies',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: FutureBuilder(
                future: currentUser(),
                builder: (BuildContext context, AsyncSnapshot<User> curr) =>
                    curr.hasData
                        ? Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Form(
                                  key: _formEditKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.0),
                                          labelText: 'Allergies',
                                        ),
                                        controller: _updateText(
                                            _allergiesController,
                                            curr.data!.allergies),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 10,
                                        //initialValue: curr.data!.allergies,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        validator: (text) {
                                          if (text!.contains(',')) {
                                            return 'Please remove , (comma)';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                FormSpacing(),
                                Column(
                                  children: [
                                    PrimaryButton(
                                      btnFunction: () {
                                        if (_formEditKey.currentState!
                                            .validate()) {
                                          userController.updateUserAllergies(
                                              _allergiesController.text.trim());
                                          taskbarController.updatePageIndex(
                                              Navigation.settingEnum.index);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Allergies Details Updated')));
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
                              ],
                            )),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
              ),
            )),
      ),
    );
  }
}
