import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});
  //final user=FirebaseAuth.instance.currentUser!;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final user=FirebaseAuth.instance.currentUser!;

  Future<void> signout() async {
    final GoogleSignIn googleSign=GoogleSignIn();
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
            IconButton(onPressed:(){
              signout();
            }
                , icon: const Icon(Icons.logout))
          ],

        ),
        body: Center(child: Text("Logged in as: ${user.email!}",))



    );
  }
}
