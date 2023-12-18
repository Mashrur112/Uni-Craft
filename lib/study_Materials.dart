import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'delete_file.dart';

class study_Materials extends StatefulWidget {
  @override
  State<study_Materials> createState() => _study_MaterialsState();
}

class _study_MaterialsState extends State<study_Materials> {
  var join_code;
  var show = false;

  int c = 0;
  int b = 0;
  int count = 0, count1 = 0;
  var link = [];
  var name = [];
  var role;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Profile").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              c = 0;
              b = c + 1;
              count = 0;
              count1 = 0;

              final res = snapshot.data!.docs.toList();
              for (var r in res!) {

                if (r['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                  join_code = r['code'];
                  role=r['role'];

                  break;
                }

              }
              for (var r in res!) {
                if (r['code'] == join_code.toString() &&
                    r['role'] == "Administrator"
                    ) {
                  //print(count1);



                  while (true) {
                    try {
                      if (r[c.toString()]=="") break;
                      else{



                        link.insert(
                            count1,
                            snapshot.data!.docs[count][c.toString()]
                                .toString());
                        name.insert(
                            count1,
                            snapshot.data!.docs[count ][b.toString()]
                                .toString());
                        count1++;
                        c = c + 2;
                        b = c + 1;
                      }
                    } catch (e) {
                      break;


                    }
                  }
                }
                else
                count++;
              }
            }

            return
              Padding(
                padding:  EdgeInsets.fromLTRB(((30/392)*screenW), ((50/872)*screenH),0 , 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  //padding: EdgeInsets.all(21),
                  itemCount: count1,
                  itemBuilder: (BuildContext context, int index) {
                    return  Column(
                      children: [
                        Container(
                          height: (40/872)*screenH,
                          child: GestureDetector(
                              onTap: () async {
                                final url=Uri.parse(link[index]);
                                if(!await launchUrl(url))
                                  throw Exception('Could not launch $url');
                              },


                              child: Text(name[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                        ),
                        role=="Administrator"?
                        ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>delete_file(name,link,index,count1)));}, child: Text("Delete")):Center(),
                      ],
                    );
                  },
                ),
              );


          }),
    );
  }

}
