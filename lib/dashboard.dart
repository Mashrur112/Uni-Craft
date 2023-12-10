import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/edit_Profile.dart';

import 'Homepage.dart';

class Dashboard extends StatelessWidget {
  final currentUser = FirebaseAuth.instance;
  var profile_info =[];

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox.fromSize(
            size: Size(200, 100),
          ),
          Container(
            height: (659 / 872) * screenH,
            width: screenW,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("userProfile")
                  .where('uid', isEqualTo: currentUser.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //var data= snapshot.data!.docs[0];
                profile_info.insert(0,snapshot.data!.docs[0]['imageLink']);
                profile_info.insert(1,snapshot.data!.docs[0]['name1']);
                profile_info.insert(2,snapshot.data!.docs[0]['age1']);
                profile_info.insert(3,snapshot.data!.docs[0]['roll']);
                profile_info.insert(4,snapshot.data!.docs[0]['email']);


                if (snapshot.hasData) {

                  return Container(
                    child: Column(
                      children: [
                        Image.network(
                          snapshot.data!.docs[0]['imageLink'],
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "Name: " + snapshot.data!.docs[0]['name1'],
                        ),
                        Text("Age: " + snapshot.data!.docs[0]['age1']),
                        Text("Roll: " + snapshot.data!.docs[0]['roll']),
                        Text("Email: " + snapshot.data!.docs[0]['email']),
                      ],
                    ),
                  );
                } else {
                  return Homepage();
                }
              },
            ),
          ),
          ElevatedButton(onPressed: () {
           // profile_info[0]="sdf";
            //print(profile_info.length);

            Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_profile(profile_info)));
          }, child: Text("Edit Profile")),
        ],
      ),
    );
  }
}
