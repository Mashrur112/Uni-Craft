import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_craft/LoginPage.dart';
import 'package:uni_craft/auth2.dart';
import 'package:uni_craft/dashboard.dart';
import 'package:uni_craft/main.dart';

import 'Homepage.dart';
class Authpage extends StatefulWidget{
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {








  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(

        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context,snapshot){
          //user logged in
          if(snapshot.hasData ) {



            return Authpage2();
          }
          else
            {

            return Login();}
        },
      ),
    );
  }
}
