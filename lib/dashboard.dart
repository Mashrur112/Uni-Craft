



import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_craft/chat.dart';
import 'package:uni_craft/study_Materials.dart';
import 'package:uni_craft/widget/uploadFile.dart';

import 'Homepage.dart';
import 'calendar.dart';
import 'edit_Profile.dart';
import 'members.dart';
import 'notice.dart';

class Dashboard extends StatefulWidget {
  var role;
  Dashboard(this.role, {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final currentUser = FirebaseAuth.instance;
  var view_more = false;
  var c = 0;
  var check = true;

  var profile_info = [];

  Future<void> signout() async {
    final GoogleSignIn googleSign = GoogleSignIn();
    await googleSign.signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          SizedBox.fromSize(
            size: Size(0, ((20 / 872) * screenH)),
          ),
          widget.role == "Administrator"
          /* Button 01*/     ? GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  uploadFile()));
            },
            child: Center(
              child: Container(
                height: (70 / 872) * screenH,
                width: (380 / 392) * screenW,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 7),
                        spreadRadius: 0,
                        blurRadius: 2,
                      )
                    ]),
                child: const Center(
                    child: Text(
                      "Upload file",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ),
          )
              : Container(
            height: (70 / 872) * screenH,
            width: (380 / 392) * screenW,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 7),
                    spreadRadius: 0,
                    blurRadius: 2,
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock),
                SizedBox.fromSize(size: Size(((10 / 392) * screenW), 0)),
                const Text(
                  "Upload file",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox.fromSize(
            size: Size(0, ((20 / 872) * screenH)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  study_Materials()));
            },
            child: Center(
              child: Container(
                height: (70 / 872) * screenH,
                width: (380 / 392) * screenW,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 7),
                        spreadRadius: 0,
                        blurRadius: 2,
                      )
                    ]),
                child: const Center(
                    child: Text(
                      "Study Materials",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size(0, ((20 / 872) * screenH)),
          ),
          //Chat Button
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatApp()));
            },
            child: Center(
              child: Container(
                height: (70 / 872) * screenH,
                width: (380 / 392) * screenW,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 7),
                        spreadRadius: 0,
                        blurRadius: 2,
                      )
                    ]),
                child: const Center(
                    child: Text(
                      "Chat",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size(0, ((20 / 872) * screenH)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Calendar()));
            },
            child: Center(
              child: Container(
                height: (70 / 872) * screenH,
                width: (380 / 392) * screenW,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 7),
                        spreadRadius: 0,
                        blurRadius: 2,
                      )
                    ]),
                child: const Center(
                    child: Text(
                      "Calendar",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size(0, ((20 / 872) * screenH)),
          ),



          widget.role != "General member"
              ? GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => members()));
            },
            child: Center(
              child: Container(
                height: (70 / 872) * screenH,
                width: (380 / 392) * screenW,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 7),
                        spreadRadius: 0,
                        blurRadius: 2,
                      )
                    ]),
                child: const Center(
                    child: Text(
                      "Members",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ),
          )
              : Container(
            height: (70 / 872) * screenH,
            width: (380 / 392) * screenW,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 7),
                    spreadRadius: 0,
                    blurRadius: 2,
                  )
                ]),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                Text(
                  "Members",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox.fromSize(
            size: Size(0, ((20 / 872) * screenH)),
          ),


          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  notice()));
            },
            child: Center(
              child: Container(
                height: (70 / 872) * screenH,
                width: (380 / 392) * screenW,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 7),
                        spreadRadius: 0,
                        blurRadius: 2,
                      )
                    ]),
                child: const Center(
                    child: Text(
                      "Notice",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade300,
        child: Column(
          children: [
            // SizedBox.fromSize(
            //   size: Size(200, 100),
            // ),
            SizedBox(
              height: (659 / 872) * screenH,
              width: screenW,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Profile')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //var data= snapshot.data!.docs[0];
                  // print(widget.role);

                  if (snapshot.hasData) {
                    c = 0;
                    final res = snapshot.data!.docs.toList();
                    for (var r in res) {
                      c++;

                      if (r['uid'] == currentUser.currentUser!.uid) {
                        break;
                      }
                    }
                    profile_info.insert(
                        0, snapshot.data!.docs[c - 1]['imageLink']);
                    profile_info.insert(1, snapshot.data!.docs[c - 1]['name1']);
                    profile_info.insert(2, snapshot.data!.docs[c - 1]['age1']);
                    profile_info.insert(3, snapshot.data!.docs[c - 1]['roll']);
                    profile_info.insert(4, snapshot.data!.docs[c - 1]['email']);
                    profile_info.insert(5, snapshot.data!.docs[c - 1]['role']);
                    profile_info.insert(6, snapshot.data!.docs[c - 1]['code']);

                    return Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset("assets/images/p_bg.jpg"),
                              Positioned(
                                bottom: (100 / 872) * screenH,
                                left: (12 / 392) * screenW,
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      profile_info[0]),
                                  radius: 42,
                                ),
                              ),
                              Positioned(
                                bottom: (60 / 872) * screenH,
                                left: (17 / 392) * screenW,
                                child: Text(
                                  profile_info[1],
                                  style: const TextStyle(
                                      fontSize: 21,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                  bottom: (40 / 872) * screenH,
                                  left: (17 / 392) * screenW,
                                  child: Text(
                                    profile_info[3],
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              Positioned(
                                bottom: (120 / 872) * screenH,
                                left: (120 / 392) * screenW,
                                child: Text(
                                  profile_info[5],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyanAccent,
                                      fontSize: 20),
                                ),
                              ),
                              Positioned(
                                bottom: (0 / 872) * screenH,
                                left: (255 / 392) * screenW,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      view_more = !view_more;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_red_eye_rounded),
                                  color: Colors.white,
                                ),
                              ),
                              view_more == true
                                  ? Positioned(
                                bottom: (90 / 872) * screenH,
                                left: (160 / 392) * screenW,
                                child: Text(
                                  "Age: " + profile_info[2],
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              )
                                  : const Center(),
                              view_more == true
                                  ? Positioned(
                                bottom: (60 / 872) * screenH,
                                left: (90 / 392) * screenW,
                                child: Text(
                                  "Joining code: " + profile_info[6],
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              )
                                  : const Center(),
                              view_more == true
                                  ? Positioned(
                                bottom: (18 / 872) * screenH,
                                left: (16 / 392) * screenW,
                                child: Text(profile_info[4],
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              )
                                  : const Center(),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return  Homepage();
                  }
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // profile_info[0]="sdf";
                  //print(profile_info.length);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => edit_profile(profile_info)));
                },
                child: const Text("Edit Profile")),
            ElevatedButton(
                onPressed: () {
                  signout();
                },
                child: const Text("Log Out")),
          ],
        ),
      ),
    );
  }
}

