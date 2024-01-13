import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni_craft/Homepage.dart';
import 'package:uni_craft/auth-page.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/LoginPage.dart';

class Forgot_pass extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  var Email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Forgot password"),
          backgroundColor: Color.fromARGB(
              255, 108, 167, 215), // Set the background color here
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/forgot_pass.jpeg"),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: (360 / 392) * screenW,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(0, (13 / 872.72) * screenH),
                        ),
                      ]),
                  child: TextField(
                    controller: Email,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff70ade6),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(
                            color: Colors.white60,
                          )),
                      hintText: "Email that you have logged in",
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: Size(0, (50 / 872) * screenH),
              ),
              GestureDetector(
                onTap: () {
                  var e = Email.text;
                  auth
                      .sendPasswordResetEmail(email: Email.text.toString())
                      .then((value) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Expanded(
                            child: AlertDialog(
                              title: Text("We have sent you a link at $e"),
                            ),
                          );
                        });
                  }).onError((error, stackTrace) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Expanded(
                              child: AlertDialog(
                            title: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            content: Text("An error occured!"),
                          ));
                        });
                  });
                },
                child: Container(
                    width: (110 / 392) * screenW,
                    height: (40 / 872) * screenH,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(0, (7 / 872.72) * screenH),
                        )
                      ],
                    ),
                    child: Center(
                        child: Text(
                      "Send Link",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ))),
              ),
            ],
          ),
        ));
  }
}