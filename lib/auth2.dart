import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/dashboard.dart';

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
  var role;

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



            SizedBox(
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

                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty ) {

                    final res=snapshot.data!.docs.toList();
                    for(var r in res)
                      {
                        if(r['uid']==currentUser.currentUser!.uid)
                          {
                            role=r['role'];
                            break;
                          }
                      }


                    return Dashboard(role);
                  } else {



                    return const Homepage();

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
