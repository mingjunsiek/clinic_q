import 'package:clinic_q/views/personal_info_page.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/views/taskbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
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
          body: BodyLayout(),
        ),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _profileView(context);
  }
}

Widget _profileView(BuildContext context) {
  return ListView(
    children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          leading: Icon(Icons.person),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            'Person Information',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonalInfoPage(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.home_filled),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            'Address',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            print('Address');
          },
        ),
        ListTile(
          leading: Icon(Icons.sick),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            'Allergies',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            print('Allergies');
          },
        ),
      ],
    ).toList(),
  );
}