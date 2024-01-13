import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/LoginPage.dart';

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



            return const Homepage();
          }
          else
            {

            return const Login();}
        },
      ),
    );
  }
}
