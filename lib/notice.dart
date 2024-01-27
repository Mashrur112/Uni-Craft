import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_notice.dart';
import 'notice_text.dart';

class notice extends StatefulWidget {
  var code1,role1;
  notice(this.code1,this.role1);
  @override
  State<notice> createState() => _noticeState();
}

class _noticeState extends State<notice> {
  var index1;
  var index2 = 0;
  var join_code;
  var role;

  void del(idx) {
    index1 = idx;
  }

  var strm_opn = false;

  var notice_n = [];

  var notice_t = [];

  int count1 = 0;
  int current_u = 0;

  var del_n = false;
  int l = 0;
  int l1 = 0;
  int count2 = 0;
  int count3 = 0;
  var date = [];

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffb8d8d8),
      appBar: AppBar(
        title: Text("Notice"),

        // backgroundColor: Color(0xff77a5b5),
        backgroundColor: Color(0xff7a9e9f),
        actions: [
          widget.role1=="Administrator"?
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => add_notice(widget.code1,widget.role1)));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )):Icon(Icons.not_interested),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Profile").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              l = 0;
              l1 = l + 1;
              int d = l1 + 1;
              count2 = 0;
              count3 = 0;

              final res = snapshots.data!.docs.toList();
              for (var r in res!) {
                if (r['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                  join_code = r['code'];
                  role = r['role'];

                  break;
                }
              }
              for (var r in res!) {
                if (r['code'] == join_code.toString()  && r['role']=='Administrator') {
                  //print(count1);

                  while (true) {
                    try {
                      if (r['notice' + l.toString()] == "")
                        break;
                      else {
                        notice_n.insert(
                            count2,
                            snapshots
                                .data!.docs[count3]['notice' + l.toString()]
                                .toString());
                        notice_t.insert(
                            count2,
                            snapshots
                                .data!.docs[count3]['notice' + l1.toString()]
                                .toString());
                        date.insert(
                            count2,
                            snapshots
                                .data!.docs[count3]['notice' + d.toString()]
                                .toString());

                        count2++;
                        l = l + 3;
                        l1 = l + 1;
                        d = l1 + 1;
                      }
                    } catch (e) {
                      break;
                    }
                  }
                } else
                  count3++;
              }
            }
            if (del_n == true) {
              int idx_link = index1;
              final res = snapshots.data!.docs.toList();
              for (var r in res!) {
                if (r['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                  while (true) {
                    // print(widget.index);
                    // print(widget.count1);
                    if (index1 == count2)
                      break;
                    else {
                      if (index1 == (count2 - 1)) {
                        FirebaseFirestore.instance
                            .collection("Profile")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'notice' + (3 * index1).toString(): "",
                          'notice' + ((3 * index1) + 1).toString(): "",
                          'notice' + ((3 * index1) + 2).toString(): "",
                        });
                        break;
                      } else {
                        idx_link = idx_link + 1;

                        FirebaseFirestore.instance
                            .collection("Profile")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'notice' + (3 * index1).toString():
                          notice_n[idx_link].toString(),
                          'notice' + ((3 * index1) + 1).toString():
                          notice_t[idx_link].toString(),
                          'notice' + ((3 * index1) + 2).toString():
                          date[idx_link].toString(),
                        });

                        index1++;
                      }
                    }
                  }
                }
              }
              del_n = false;
            }
            if(count2>0){

            return ListView.builder(
                itemCount: count2,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Column(
                      children: [

                        Container(
                          height: (230 / 872) * screenH,
                          width: screenW,
                          child: Card(
                            margin: EdgeInsets.fromLTRB(0.016*screenW, 0.009*screenH, 0.016*screenW, 0.001*screenH),
                            shadowColor: Colors.black,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color:Color(0xff217096))
                            ),

                            color:  Color(0xff77a5b5),
                            child: Column(
                              children: [

                                Padding(
                                  padding:  EdgeInsets.fromLTRB(0, 0.01*screenH, 0, 0),
                                  child: Text(
                                    date[index],
                                    style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox.fromSize(size: Size(0,screenH*0.02),),
                                Expanded(
                                  child: Padding(
                                    padding:  EdgeInsets.fromLTRB(0.04*screenW, 0.01*screenH, 0.04*screenW, 0.03*screenH),
                                    child: Text(
                                      notice_n[index],
                                      maxLines: 4,
                                      //textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                widget.role1=="Administrator"?
                                Padding(
                                  padding:  EdgeInsets.fromLTRB(0, 0, 0, 0.014*screenH),
                                  child: Container(
                                    height: 0.036*screenH,
                                    width: 0.2*screenW,
                                    decoration: BoxDecoration(
                                      color:  Color(0xffa84747),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: GestureDetector(
                                        onTap: () {
                                          int total = index;

                                          del(total);

                                          setState(() {
                                            del_n = true;
                                          });
                                        },
                                        child:Center(child: Text("Delete",style: TextStyle(color: Colors.white),))),
                                  ),
                                ):Center(child: Text("sdf"),),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  notice_text(notice_t[index])));
                    },
                  );
                });}
            else
              {
                return Center(child:Text("No notice here to show",style: TextStyle(fontSize: 21),));
              }
          }),
    );
  }
}