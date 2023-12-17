import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_craft/LoginPage.dart';
import 'package:uni_craft/dashboard.dart';
import 'package:uni_craft/main.dart';

import 'Homepage.dart';

class Authpage2 extends StatefulWidget {
  const Authpage2({super.key});



  @override
  State<Authpage2> createState() => _AuthpageState2();
}

class _AuthpageState2 extends State<Authpage2> {
  final currentUser = FirebaseAuth.instance;
  var role1="Administrator",role2="Co-Administrator",role3="General member";
  var c1=false,c2=false,c3=false;
  String collect1=" ";

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      SingleChildScrollView(
        child: Column(
          children: [



            Container(
              height: screenH,
              width: screenW,

              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Profile' )
                    .where('uid', isEqualTo: currentUser.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //var data= snapshot.data!.docs[0];
                 //print(collect1);

                  if (snapshot.hasData && snapshot.data!.docs.length >= 1 ) {


                    return Dashboard();
                  } else {



                    return Homepage();

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
