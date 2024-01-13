import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

 class Forgot_pass extends StatelessWidget{
   final auth=FirebaseAuth.instance;

   var Email=TextEditingController();

  Forgot_pass({super.key});
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
      ),
      body: Container(
        decoration:
            const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/forgot_pass.jpeg"),fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: (360/392)*screenW,

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

                  controller:Email ,
                  style: const TextStyle(color:Colors.white),



                  decoration: InputDecoration(

                    filled: true,
                    fillColor: const Color(0xff70ade6),
                    prefixIcon: const Icon(Icons.email_outlined,color: Colors.red,),
                    enabledBorder: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(
                        color: Colors.lightBlueAccent,

                      ),
                    ),


                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(
                        color: Colors.white60,
                      )

                    ),
                    hintText: "Email that you have logged in",
                    hintStyle: const TextStyle(color: Colors.white70,),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(size: Size(0, (50/872)*screenH),),
            GestureDetector(
              onTap: (){
                var e=Email.text;
                auth.sendPasswordResetEmail(email: Email.text.toString()).then((value){
                  showDialog(context: context,
                      builder: (BuildContext context){
                    return Expanded(
                        child:AlertDialog(
                          title: Text("We have sent you a link at $e"),

                        ) ,
                    );

                      }


                  );


                  
                }).onError((error, stackTrace) {
                  showDialog(context: context, builder: (BuildContext context){
                    return const Expanded(
                        child:AlertDialog(
                          title: Icon(Icons.error,color: Colors.red,),
                          content: Text("An error occured!"),
                        )

                    );
                  });





                });


              },
              child: Container(
                width: (110/392)*screenW,
                  height: (40/872)*screenH,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color:Colors.blue,
                    boxShadow: [BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, (7 / 872.72) * screenH),

                    )],


                  ),

                  child: const Center(child: Text("Send Link",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),))),
            ),
        ],
      ),

      )

    );
  }

}