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
  var strm_opn = false;
  String? string;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffb8d8d8),
      appBar: AppBar(
        title: Text("Add Notice"),
        backgroundColor: Color(0xff7a9e9f),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(height: 0.03*screenH,),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Profile")
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData && strm_opn == true) {
                    final res = snapshots.data!.docs.toList();
                    for (var r in res) {
                      if (r['uid'] ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        c = 0;
                        int t = c + 1;
                        int d = t + 1;
                        while (true) {
                          try {
                            if (r['notice' + c.toString()] == "") {
                              FirebaseFirestore.instance
                                  .collection("Profile")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'notice' + c.toString():
                                    caption.text.toString(),
                                'notice' + t.toString(): text.text.toString(),
                                'notice' + d.toString(): string,
                              });

                              strm_opn = false;
                              break;
                            } else {
                              c = c + 3;
                              t = c + 1;
                              d = t + 1;
                            }
                          } catch (e) {
                            FirebaseFirestore.instance
                                .collection("Profile")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              'notice' + c.toString():
                                  caption.text.toString(),
                              'notice' + t.toString(): text.text.toString(),
                              'notice' + d.toString(): string,
                            });
                            strm_opn = false;
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
                  // SizedBox.fromSize(size: Size(0,(1/872)*screenH),),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.01 * screenW),
                    child: Stack(

                      children:[
                        Container(
                          height: 0.1*screenH,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),


                          color:Color(0xff77a5b5),

                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade600,
                            blurRadius: 3,
                            offset: Offset(0,3),




                          )]
                          ),
                        ),



                        SingleChildScrollView(
                          child: TextFormField(

                          style: TextStyle(color: Colors.white),
                          controller: caption,
                          minLines: 2,
                          maxLines: 2,
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
                            border: InputBorder.none,
                               filled: true,
                               fillColor: Color(0xff77a5b5),
                              hintText: '  Tittle',
                              hintStyle: TextStyle(color: Colors.white70),
                              counterStyle:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              counterText: 'Remaining: $count',
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              alignLabelWithHint: true,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:  Color(0xff32959c),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:Color(0xff1d666b),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xff32959c),
                              ))
                          ),
                                                  ),
                        )

                      ],
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(0, ((5 / 872)) * screenH),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.01 * screenW),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),


                          color:Color(0xff77a5b5),

                          boxShadow: [BoxShadow(
                            color: Colors.grey.shade600,
                            blurRadius: 3,
                            offset: Offset(0,3),




                          )]
                      ),
                      child: TextFormField(

                        style: TextStyle(color: Colors.white),
                        controller: text,
                        minLines: 20,
                        maxLines: 20,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xff77a5b5),
                            hintText: 'Description',
                            hintStyle:
                                TextStyle(color: Colors.white70, fontSize: 18),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            alignLabelWithHint: true,
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff32959c),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff1d666b),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color:Color(0xff32959c),
                            ))),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'[a-zA-Z]').hasMatch(value!)) {
                            return "Enter any caption ";
                          } else
                            return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 0.04*screenH,
                  ),

                  Container(
                    height: 0.05*screenH,
                    width: 0.3*screenW,
                    decoration: BoxDecoration(
                      color: Color(0xff33678a),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            DateFormat dateFormat =
                                DateFormat("yyyy-MM-dd HH:mm:ss");
                            string = dateFormat.format(DateTime.now());
                            Navigator.pop(context);
                            setState(() {
                              strm_opn = true;
                            });
                          }
                        },
                        child: Center(child: const Text("Publish",style: TextStyle(color: Colors.white),))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
