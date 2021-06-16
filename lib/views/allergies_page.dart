import 'package:clinic_q/model/user.dart';
import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:clinic_q/controllers/user_controller.dart';
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

  @override
  void dispose() {
    super.dispose();
    _allergiesController.dispose();
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
                          margin: const EdgeInsets.only(
                              right: 20, left: 20, top: 30),
                          child: Form(
                            key: _formEditKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  //initialValue: curr.data!.allergies,
                                  decoration: InputDecoration(
                                    hintText: curr.data!.allergies,
                                  ),
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
                                FormSpacing(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onPressed: () {
                                    if (_formEditKey.currentState!.validate()) {
                                      userController.updateUserAllergies(
                                          _allergiesController.text.trim());
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Allergies Details Updated')));
                                    }
                                  },
                                  child: Text('Confirm'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                )
                              ],
                            ),
                          )))
                  : NoConnectionLayout(),
            )),
      ),
    );
  }
}

class NoConnectionLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _refreshView(context);
  }
}

Widget _refreshView(BuildContext context) {
  return Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
              Navigator.pop(context); // pop current page
              Navigator.pushNamed(context, "AllergiesPage"); // push it back in
            },
            child: Text('Refresh'),
          ),
        ),
      ],
    ),
  );
}
