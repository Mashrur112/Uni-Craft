import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  String email1 = FirebaseAuth.instance.currentUser!.email.toString();

  Future<void> signout() async {
    final GoogleSignIn googleSign = GoogleSignIn();
    await googleSign.signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
            SizedBox.fromSize(size: Size(0, 15)),
            Text(
              "Set up you profile!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox.fromSize(
              size: Size(0, 21),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      label: Text("Name"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'[a-zA-Z]').hasMatch(value!)) {
                        return "Enter Your name ";
                      } else
                        return null;
                    },
                  ),
                  SizedBox.fromSize(
                    size: Size(0, 21),
                  ),
                  TextFormField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Age: "),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'[0-9]').hasMatch(value!)) {
                        return "Enter Your age ";
                      } else
                        return null;
                    },
                  ),
                  SizedBox.fromSize(
                    size: Size(0, 21),
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      label: Text("Enter your Email address"),
                      hintText: email1,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'[@]*[.]').hasMatch(value!)) {
                        return "Enter Your Email address ";
                      } else
                        return null;
                    },
                  ),
                  SizedBox.fromSize(
                    size: Size(0, 21),
                  ),
                  TextFormField(
                    controller: roll,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Roll Number"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'[0-9]').hasMatch(value!)) {
                        return "Enter Your roll number ";
                      } else
                        return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox.fromSize(
              size: Size(0, 31),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 6,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),

                )
              ),
                onPressed: () {
                  formKey.currentState!.validate();
                },
                child: Text(
                  "submit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
          ],
        ));
  }
}
