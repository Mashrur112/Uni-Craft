import 'package:firebase_core/firebase_core.dart';
import 'package:uni_craft/Homepage.dart';
import 'package:uni_craft/auth-page.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Craft());
}

class Craft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return const MaterialApp(
      title: "Uni Craft",
      debugShowCheckedModeBanner: false,
      home: Authpage(),
    );
  }
}
