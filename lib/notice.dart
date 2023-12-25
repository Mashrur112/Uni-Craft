import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_notice.dart';
import 'notice_text.dart';

class notice extends StatefulWidget {
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
  var date=[];


  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => add_notice()));
              },
              icon: Icon(
                Icons.add,
                color: Colors.green,
              )),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Profile").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              l = 0;
              l1 = l + 1;
              int d=l1+1;
             count2 = 0;
              count3 = 0;

              final res = snapshots.data!.docs.toList();
              for (var r in res!) {
                if (r['uid'] ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  join_code = r['code'];
                  role = r['role'];

                  break;
                }
              }
              for (var r in res!) {
                if (r['code'] == join_code.toString() ) {

                  //print(count1);

                  while (true) {
                    try {

                      if (r['notice'+l.toString()] == "")
                        break;
                      else {

                        notice_n.insert(
                            count2,
                            snapshots.data!.docs[count3]['notice'+l.toString()]
                                .toString());
                        notice_t.insert(
                            count2,
                            snapshots.data!.docs[count3]['notice'+l1.toString()]
                                .toString());
                        date.insert(
                            count2,
                            snapshots.data!.docs[count3]['notice'+d.toString()]
                                .toString());

                        count2++;
                        l = l + 3;
                        l1 = l + 1;
                        d=l1+1;
                      }
                    } catch (e) {
                      break;
                    }
                  }
                } else
                  count3++;
              }
            }
            if(del_n==true)
            {
              int idx_link=index1;
              final res=snapshots.data!.docs.toList();
              for(var r in res!) {
                if (r['uid'] == FirebaseAuth.instance.currentUser!.uid) {

                  while(true){
                    // print(widget.index);
                    // print(widget.count1);
                    if(index1==count2)
                      break;
                    else{

                      if(index1==(count2-1)) {
                        FirebaseFirestore.instance.collection("Profile").doc(
                            FirebaseAuth.instance.currentUser!.uid).update({
                          'notice'+(3*index1).toString(): "",
                          'notice'+((3*index1) + 1).toString(): "",
                          'notice'+((3*index1) + 2).toString(): "",
                        });
                        break;
                      }
                      else{
                        idx_link=idx_link+1;

                        FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                          'notice'+ (3*index1).toString():notice_n[idx_link].toString(),
                          'notice'+((3*index1)+1).toString():notice_t[idx_link].toString(),
                          'notice'+((3*index1)+2).toString():date[idx_link].toString(),
                        });

                        index1++;}}
                  }
                }
              }
              del_n=false;
            }

            return ListView.builder(
                itemCount: count2,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          height: (250 / 872) * screenH,
                          child: Card(
                            child: Row(
                              children: [
                                Text(date[index]),
                                FittedBox(
                                    child: Text(
                                  notice_n[index],
                                  style:
                                      TextStyle(color: Colors.black, fontSize: 20),
                                )),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              int total = index;



                              del(total);

                              setState(() {
                                del_n = true;
                              });
                            },
                            child: Text("Delete")),
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
                });
          }),
    );
  }
}
