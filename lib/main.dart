import 'package:clinic_q/controllers/clinic_info_controller.dart';
import 'package:clinic_q/controllers/flutter_fire_controller.dart';
import 'package:clinic_q/controllers/taskbar_controller.dart';
import 'package:clinic_q/controllers/user_controller.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/views/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Get.putAsync(() => InitializeService().init());
  runApp(MyApp());
}

class InitializeService extends GetxService {
  Future<InitializeService> init() async {
    Get.put(FlutterFireController());
    Get.put(ClinicInfoController());
    Get.put(TaskbarController());
    Get.put(UserController());

    return this;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Image loginImage;

  @override
  void initState() {
    super.initState();
    loginImage = Image.asset('assets/images/Login_Background.jpg');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(loginImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ClinicQ',
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
      home: SplashScreenPage(),
    );
  }
}
