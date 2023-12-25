import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_craft/Homepage.dart';
import 'package:uni_craft/auth-page.dart';

import 'LoginPage.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void login() {
    Navigator.pop(context);
  }

  void wrongCred() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 51,
            shadowColor: Colors.black26,
            icon: Icon(Icons.warning_amber),
            iconColor: Colors.red,
            backgroundColor: Colors.blueGrey,
            title: Text(
              "Password don't match",
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  Future<void> Signin() async {
    bool t = true;
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (confirmPassString.text == passString.text) {
        t = false;

        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailString.text,
          password: passString.text,
        );
      } else {
        Navigator.pop(context);

        t = true;

        wrongCred();
      }
      if (!t) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      t = false;
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 51,
              shadowColor: Colors.black26,
              icon: Icon(Icons.warning_amber),
              iconColor: Colors.red,
              backgroundColor: Colors.blueGrey,
              title: Text(e.code),
            );
          });
    }
  }

  var confirmPassString = TextEditingController();
  var emailString = TextEditingController();

  var passString = TextEditingController();

  bool is_obs = true;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/LogIn.jpeg"), fit: BoxFit.cover),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: (30 / 872.72) * screenH),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, ((50 / 392.72) * screenW), 0),
              child: Image.asset(
                "assets/images/logo.png",
                height: (200 / 872.72) * screenH,
                width: (200 / 392.72) * screenW,
              ),
            ),

            //Gmail portion

            Center(
              child: Container(
                width: (350 / 392.72) * screenW,
                margin:
                    EdgeInsets.fromLTRB(0, ((120 / 872.72) * screenH), 0, 0),
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
                  controller: emailString,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your Email...",
                    hintStyle: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(
                          ((14 / 392.72) * screenW),
                          ((8 / 872.72) * screenH),
                          (5 / 392.72) * screenW,
                          (((8 / 872.72) * screenH))),
                      child: Icon(Icons.email, color: Colors.black),
                    ),
                    filled: true,
                    fillColor: const Color(0xff70ade6),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.white60,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.lightBlueAccent,
                        )),
                  ),
                ),
              ),
            ),
            // ),
            //for some gap
            Container(
              height: (23 / 872.72) * screenH,
            ),
            //Password section
            Center(
              child: Container(
                width: (350 / 392.72) * screenW,
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
                  controller: passString,
                  obscureText: is_obs,
                  decoration: InputDecoration(
                    hintText: "Enter Password...",
                    hintStyle: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB((10 / 392.72) * screenW, 0,
                          (3 / 392.72) * screenW, 0),
                      child: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(0, (4 / 872.72) * screenH,
                          (11 / 392.72) * screenW, (4 / 872.72) * screenH),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (is_obs)
                                is_obs = false;
                              else
                                is_obs = true;
                            });
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.black38,
                          )),
                    ),
                    filled: true,
                    fillColor: const Color(0xff70ade6),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.white60,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.lightBlueAccent,
                        )),
                  ),
                ),
              ),
            ),
            Container(
              height: (23 / 872.72) * screenH,
            ),
            Center(
              child: Container(
                width: (350 / 392.72) * screenW,
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
                  controller: confirmPassString,
                  obscureText: is_obs,
                  decoration: InputDecoration(
                    hintText: "Confirm Password...",
                    hintStyle: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB((10 / 392.72) * screenW, 0,
                          (3 / 392.72) * screenW, 0),
                      child: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(0, (4 / 872.72) * screenH,
                          (11 / 392.72) * screenW, (4 / 872.72) * screenH),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (is_obs)
                                is_obs = false;
                              else
                                is_obs = true;
                            });
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.black38,
                          )),
                    ),
                    filled: true,
                    fillColor: const Color(0xff70ade6),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.white60,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.lightBlueAccent,
                        )),
                  ),
                ),
              ),
            ),
            //for some gap
            Container(
              height: (16 / 872.72) * screenH,
            ),
            //forgot password

            //sign in button

            GestureDetector(
              onTap: Signin,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, (15 / 872.72) * screenH, 0, 0),
                padding: EdgeInsets.fromLTRB(
                    (32 / 392.72) * screenW,
                    (12 / 872.72) * screenH,
                    (32 / 392.72) * screenW,
                    (12 / 872.72) * screenH),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, (8 / 872.72) * screenH),
                    )
                  ],
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //for gap
            Container(
              height: (40 / 872.72) * screenH,
            ),
            //or continue with

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.white70,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (7 / 392.72) * screenW),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: Colors.white70,
                  )),
                  //google button
                ],
              ),
            ),
            //google,apple button
            Container(
              height: (10 / 872.72) * screenH,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      await signInWithGoogle();
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/images/google.png",
                      height: (80 / 872.72) * screenH,
                      width: (80 / 392.72) * screenW,
                    )),
                SizedBox(
                  width: (0 / 392.72) * screenW,
                ),
                // Image.asset("assets/images/apple.png",height: (50/872.72)*screenH,width: (50/392.72)*screenW,),
              ],
            ),
            Container(
              height: (30 / 872.72) * screenH,
            ),
            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have a Account?",
                  style: TextStyle(color: Colors.white70),
                ),
                GestureDetector(
                    onTap: login,
                    child: const Text(
                      "login Now",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
