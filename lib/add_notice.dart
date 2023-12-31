import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'Homepage.dart';

class add_notice extends StatefulWidget {
  @override
  State<add_notice> createState() => _add_noticeState();
}

class _add_noticeState extends State<add_notice> {
  var text = TextEditingController();

  var caption = TextEditingController();

  var count = "";
  int c = 0;
  var strm_opn=false;
  String? string;




  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,

            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Profile")
                      .snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.hasData && strm_opn==true) {
                      final res = snapshots.data!.docs.toList();
                      for (var r in res) {
                        if (r['uid'] ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          c = 0;
                          int t = c + 1;
                          int d=t+1;
                          while(true) {
                            try {
                              if (r['notice' + c.toString()]=="" ) {

                                FirebaseFirestore.instance
                                    .collection("Profile")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'notice' + c.toString():caption.text.toString(),
                                  'notice' + t.toString(): text.text.toString(),
                                  'notice' + d.toString(): string,
                                });

                                strm_opn=false;
                                break;
                              }
                              else{

                                c = c + 3;
                                t = c + 1;
                              d=t+1;
                              }

                            } catch (e) {

                              FirebaseFirestore.instance
                                  .collection("Profile")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'notice' + c.toString():caption.text.toString(),
                                'notice' + t.toString(): text.text.toString(),
                                'notice' + d.toString(): string,
                              });
                              strm_opn=false;
                              break;
                            }
                          }
                          break;
                        }

                      }
                    }
                    return Center();
                  }),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox.fromSize(size: Size(0,(100/872)*screenH),),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: caption,
                      minLines: 2,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'[a-zA-Z]').hasMatch(value)) {
                          return "Enter any caption ";
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          count = (80 - value.length).toString();
                        });
                      },
                      maxLength: 80,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                          label: Text(
                            'Caption',
                            style: TextStyle(color: Colors.grey),
                          ),
                          counterStyle: TextStyle(
                            color: Colors.white,
                          ),
                          counterText: 'Remaining: $count',
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          alignLabelWithHint: true,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          ))),
                    ),
                    SizedBox.fromSize(
                      size: Size(0, ((10 / 872)) * screenH),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: text,
                      minLines: 18,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,



                      decoration: InputDecoration(
                          label: Text(
                            'Text..',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          alignLabelWithHint: true,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          ))),
                      validator: (value){
                        if (value!.isEmpty ||
                            !RegExp(r'[a-zA-Z]').hasMatch(value!)) {
                          return "Enter any caption ";
                        } else
                          return null;


                      },
                    ),


                    ElevatedButton(onPressed: () {
                     if(formKey.currentState!.validate()){


                       DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                       string = dateFormat.format(DateTime.now());
                       Navigator.pop(context);
                       setState(() {
                        strm_opn=true;

                      });}



                    }, child: Text("Publish")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
