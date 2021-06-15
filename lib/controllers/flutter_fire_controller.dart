import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class FlutterFireController extends GetxController {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  var isInitialized = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Firebase.initializeApp();
    isInitialized = true;
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }
}
