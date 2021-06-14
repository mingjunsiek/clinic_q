import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/views/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spendy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Nunito',
            ),
        primaryTextTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Nunito',
            ),
        accentTextTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Nunito',
            ),
        scaffoldBackgroundColor: kPrimaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: 10)),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
        ),
        cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        cardColor: kPrimaryColor,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: kTextFieldColor,
        ),
      ),
      home: LoginPage(),
    );
  }
}
