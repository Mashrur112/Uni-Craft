import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uni_craft/Homepage.dart';
import 'package:uni_craft/auth-page.dart';
import 'package:uni_craft/dependency_injection.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/LoginPage.dart';
import 'splash.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Craft(),
    ),
  );
  DependencyInjection.init();
}

class Craft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return GetMaterialApp(
      title: "Uni Craft",
      debugShowCheckedModeBanner: true,
      home: Splash(),
    );
  }
}
