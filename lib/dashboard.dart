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
      backgroundColor: Color(0xff4f6367),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight((170 / 872) * screenH),
        child: AppBar(
          flexibleSpace: Image.asset(
            "assets/images/logo1.png",
            fit: BoxFit.cover,
          ),

          // leading: Builder(
          //   builder: (context) => GestureDetector(
          //     child: Stack(
          //       children: [
          //         Positioned(
          //           bottom: (5/872)*screenH,
          //           left: (5/391)*screenW,
          //           child: CircleAvatar(
          //             radius: 17,
          //             backgroundColor: Color(0xffBFC8C9),
          //
          //             child: Icon(Icons.person,size: 33,color: Color(0xff3352ff),),
          //           ),
          //         )
          //       ],
          //     ),
          //     onTap: () => Scaffold.of(context).openDrawer(),
          //   ),
          // ),
          backgroundColor: Color(0xff7a9e9f),
          elevation: 4,
          shadowColor: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 1000,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, ((30 / 872) * screenH), 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox.fromSize(
                      size: Size(0, ((0 / 872) * screenH)),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        study_Materials(widget.role)));
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                (35 / 392) * screenW, 0, 0, 0),
                            child: Container(
                                height: (150 / 872) * screenH,
                                width: (140 / 392) * screenW,
                                decoration: BoxDecoration(
                                    color: Color(0xffb8d8d8),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(0, 7),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                      )
                                    ]),
                                child: Stack(children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        (20 / 392) * screenW,
                                        (14 / 872) * screenH,
                                        0,
                                        0),
                                    child: Image.asset(
                                      "assets/images/material.png",
                                      height: (100 / 872) * screenH,
                                      width: (100 / 392) * screenW,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        (30 / 392) * screenW,
                                        (115 / 872) * screenH,
                                        0,
                                        0),
                                    child: Text(
                                      " Materials",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.grey.shade900),
                                    ),
                                  ),
                                ])),
                          ),
                        ),

                        //Chat Button

                        SizedBox.fromSize(
                          size: Size(
                              (40 / 392) * screenW, ((20 / 872) * screenH)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Calendar()));
                          },
                          child: Container(
                            height: (150 / 872) * screenH,
                            width: (140 / 392) * screenW,
                            decoration: BoxDecoration(
                                color: Color(0xffb8d8d8),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 7),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                  )
                                ]),
                            child: Stack(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    (27 / 392) * screenW,
                                    (17 / 872) * screenH,
                                    0,
                                    0),
                                child: Image.asset(
                                  "assets/images/calendar.png",
                                  height: (100 / 872) * screenH,
                                  width: (100/ 392) * screenW,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    (35 / 392) * screenW,
                                    (115 / 872) * screenH,
                                    0,
                                    0),
                                child: Text(
                                  "Calendar",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox.fromSize(
                      size: Size(0, ((40 / 872) * screenH)),
                    ),
                    widget.role !="General member"
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => members()));
                            },
                            child: Row(
                              children: [
                                SizedBox.fromSize(
                                  size: Size((40 / 392) * screenW,
                                      ((20 / 872) * screenH)),
                                ),
                                Container(
                                  height: (150 / 872) * screenH,
                                  width: (140 / 392) * screenW,
                                  decoration: BoxDecoration(
                                      color: Color(0xffb8d8d8),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black54,
                                          offset: Offset(0, 7),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                        )
                                      ]),
                                  child: Stack(children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          (0 / 392) * screenW,
                                          (0 / 872) * screenH,
                                          (12 / 392) * screenW,
                                          0),
                                      child: Image.asset(
                                        "assets/images/members.png",
                                        height: (140 / 872) * screenH,
                                        width: (140 / 392) * screenW,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          (35 / 392) * screenW,
                                          (115 / 872) * screenH,
                                          0,
                                          0),
                                      child: Text(
                                        "Members",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox.fromSize(
                                  size: Size((40 / 392) * screenW,
                                      ((20 / 872) * screenH)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => notice()));
                                  },
                                  child: Center(
                                    child: Container(
                                      height: (150 / 872) * screenH,
                                      width: (140 / 392) * screenW,
                                      decoration: BoxDecoration(
                                          color: Color(0xffb8d8d8),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black54,
                                              offset: Offset(0, 7),
                                              spreadRadius: 0,
                                              blurRadius: 2,
                                            )
                                          ]),
                                      child: Stack(children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              (10 / 392) * screenW,
                                              (2 / 872) * screenH,
                                              0,
                                              0),
                                          child: Image.asset(
                                            "assets/images/Notice.png",
                                            height: (115 / 872) * screenH,
                                            width: (115 / 392) * screenW,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              (45 / 392) * screenW,
                                              (115 / 872) * screenH,
                                              0,
                                              0),
                                          child: Text(
                                            "Notice",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              SizedBox.fromSize(
                                size: Size((40 / 392) * screenW,
                                    ((20 / 872) * screenH)),
                              ),
                              Container(
                                height: (150 / 872) * screenH,
                                width: (140 / 392) * screenW,
                                decoration: BoxDecoration(
                                    color: Color(0xffb8d8d8),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(0, 7),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                      )
                                    ]),
                                child: Stack(children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        (0 / 392) * screenW,
                                        (0 / 872) * screenH,
                                        (12 / 392) * screenW,
                                        0),
                                    child: Image.asset(
                                      "assets/images/members.png",
                                      height: (140 / 872) * screenH,
                                      width: (140 / 392) * screenW,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        (25 / 392) * screenW,
                                        (115 / 872) * screenH,
                                        0,
                                        0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Members",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        SizedBox.fromSize(
                                          size: Size((10 / 392) * screenW,
                                              (0)),
                                        ),
                                        Icon(Icons.lock,size: 20,),
                                      ],
                                    ),

                                  ),
                                ]),
                              ),
                              SizedBox.fromSize(
                                size: Size((40 / 392) * screenW,
                                    ((20 / 872) * screenH)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => notice()));
                                },
                                child: Center(
                                  child: Container(
                                    height: (150 / 872) * screenH,
                                    width: (140 / 392) * screenW,
                                    decoration: BoxDecoration(
                                        color: Color(0xffb8d8d8),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black54,
                                            offset: Offset(0, 7),
                                            spreadRadius: 0,
                                            blurRadius: 2,
                                          )
                                        ]),
                                    child: Stack(children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            (10 / 392) * screenW,
                                            (2 / 872) * screenH,
                                            0,
                                            0),
                                        child: Image.asset(
                                          "assets/images/Notice.png",
                                          height: (115 / 872) * screenH,
                                          width: (115 / 392) * screenW,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            (45 / 392) * screenW,
                                            (115 / 872) * screenH,
                                            0,
                                            0),
                                        child: Text(
                                          "Notice",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: (30 / 872) * screenH,
            right: (20 / 392) * screenW,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatApp()));
              },
              child: Icon(
                Icons.chat_outlined,
                size: 50,
                color: Color(0xffeef5db),
              ),
            ),
          ),
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
                                bottom: (140 / 872) * screenH,
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
                                  icon:
                                      const Icon(Icons.remove_red_eye_rounded),
                                  color: Colors.white,
                                ),
                              ),
                              view_more == true
                                  ? Positioned(
                                      bottom: (110 / 872) * screenH,
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
                                      bottom: (200 / 872) * screenH,
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
                    return Homepage();
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
