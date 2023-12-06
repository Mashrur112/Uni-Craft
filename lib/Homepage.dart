import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_craft/LoginPage.dart';
import 'package:uni_craft/dashboard.dart';
import 'package:uni_craft/resources/data.dart';
import 'package:uni_craft/utils.dart';

final formKey = GlobalKey<FormState>();

class Homepage extends StatefulWidget {
  Homepage({super.key});
  //final user=FirebaseAuth.instance.currentUser!;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final user=FirebaseAuth.instance.currentUser!;
  var name = TextEditingController();
  var age = TextEditingController();
  var roll = TextEditingController();
  var email = TextEditingController();
  var count = 0;
  final currentUser = FirebaseAuth.instance;
  bool check_for_save = false;
  var data = 1;
  Uint8List? _image;

  String email1 = FirebaseAuth.instance.currentUser!.email.toString();

  Future<void> signout() async {
    final GoogleSignIn googleSign = GoogleSignIn();
    await googleSign.signOut();
    FirebaseAuth.instance.signOut();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() {}

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          actions: [
            IconButton(
                onPressed: () {
                  signout();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 0,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("userProfile")
                    .where('uid', isEqualTo: currentUser.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  data = snapshot.data!.docs.length;

                  if (snapshot.hasData) {
                    return Text("SUCCESS");
                  } else {
                    check_for_save = false;
                    return Text("failed");
                  }
                },
              ),
            ),
            SizedBox.fromSize(size: Size(0, (15 / 872) * screenH)),
            Text(
              "Set up you profile!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
            SizedBox.fromSize(size: Size(0, 21/ 872) * screenH),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 51,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 51,
                        backgroundImage:
                            AssetImage("assets/images/profile.png"),
                        backgroundColor: Colors.grey,
                      ),
                Positioned(
                    bottom: -5,
                    right: -7,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ))),
              ],
            ),
            SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: name,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        label: Text(
                          "Name",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'[a-zA-Z]').hasMatch(value!)) {
                          return "Enter Your name ";
                        } else
                          return null;
                      },
                    ),
                  ),
                  SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: age,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        label: Text("Age: ",
                            style: TextStyle(color: Colors.white70)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'[0-9]').hasMatch(value!)) {
                          return "Enter Your age ";
                        } else
                          return null;
                      },
                    ),
                  ),
                  SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: email,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        label: Text("Enter your Email address",
                            style: TextStyle(color: Colors.white70)),
                        hintText: email1,
                        hintStyle:
                            TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'[@]*[.]').hasMatch(value!)) {
                          return "Enter Your Email address ";
                        } else
                          return null;
                      },
                    ),
                  ),
                  SizedBox.fromSize(size: Size(0, (21 / 872) * screenH)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: (10 / 372) * screenW),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: roll,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                            borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                        label: Text("Roll Number",
                            style: TextStyle(color: Colors.white70)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'[0-9]').hasMatch(value!)) {
                          return "Enter Your roll number ";
                        } else
                          return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox.fromSize(size: Size(0, (31 / 872) * screenH)),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    )),
                onPressed: () async {
                  if (formKey.currentState!.validate() && _image != null)
                    count++;
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text(
                  //           "sdfsdf",
                  //         ),
                  //       );
                  //     });
                  // Navigator.pop(context);
                  // Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()) );

count=1;
                  print(count);
                  print(data);
                  if (data == 0 && count == 1) {
                    var name1 = name.text;
                    var age1 = age.text;
                    var roll1 = roll.text;
                    var email1 = email.text;

                    String resp = await StoreData().savedData(
                        name: name1,
                        age: age1,
                        file: _image!,
                        roll: roll1,
                        email: email1);
                  }
                },
                child: Text(
                  "Save Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
          ],
        ));
  }
}
