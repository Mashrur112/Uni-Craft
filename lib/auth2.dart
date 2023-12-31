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

  var c1=false,c2=false,c3=false;
  String collect1=" ";
  var role,code,uid_admin;
  var snap=false;

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


                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //var data= snapshot.data!.docs[0];
                 //print(collect1);
                  final res=snapshot.data!.docs.toList();
                  for(var r in res)
                  {

                    if(r['uid']==currentUser.currentUser!.uid)
                    {
                      role=r['role'];
                      code=r['code'];
                      snap=true;
                      break;
                    }

                  }
                  for(var i in res)
                  {
                    // print(i['role']);
                    if(code==i['code'] && i['role']=="Administrator")
                    {
                      uid_admin=i['uid'];

                      break;
                    }


                  }

                  if (snapshot.hasData && snapshot.data!.docs.length >= 1 && snap==true ) {
                    snap=false;





                    return Dashboard(role,uid_admin);
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
