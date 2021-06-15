import 'package:clinic_q/widgets/FormSpacing.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/views/taskbar.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formEditKey = GlobalKey<FormState>();

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
            body: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20, top: 30),
                    child: Form(
                      key: _formEditKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'NRIC',
                            ),
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'NRIC cannot be empty!';
                              }
                              return null;
                            },
                          ),
                          FormSpacing(),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'First Name',
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
                            decoration: InputDecoration(
                              hintText: 'Last Name',
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
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                            ),
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Phone number cannot be empty!';
                              }
                              return null;
                            },
                          ),
                          FormSpacing(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              if (_formEditKey.currentState!.validate()) {
                                print("Edit");
                              }
                            },
                            child: Text('Edit'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              if (_formEditKey.currentState!.validate()) {
                                print("Cancel");
                              }
                            },
                            child: Text('Cancel'),
                          )
                        ],
                      ),
                    )))),
      ),
    );
  }
}
