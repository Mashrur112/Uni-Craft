import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uni_craft/Homepage.dart';
import 'package:uni_craft/auth-page.dart';
import 'package:uni_craft/dependency_injection.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/LoginPage.dart';

import 'main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Authpage()),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff000000), Color(0xff222325), Color(0xff3c3941), Color(0xff4e4a4f)],
          stops: [0.25, 0.75, 0.87, 0.93],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )

        ,
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent, // Set scaffold background to transparent
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                //color: Colors.blue,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/splash.png'), // Replace with the path to your image asset
                    fit: BoxFit.cover, // Adjust the BoxFit property as needed
                  ),
                ),
              ),
              Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [Colors.blue, Colors.purple],
                //     begin: Alignment.topRight,
                //     end: Alignment.bottomLeft,
                //  ),
                //),
                child: const Text(
                  'UniCraft',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



