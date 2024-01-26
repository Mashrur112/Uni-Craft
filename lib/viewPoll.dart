import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_craft/poll_graph.dart';

class ViewPoll extends StatefulWidget {
  var uid;

  ViewPoll(this.uid);

  @override
  State<ViewPoll> createState() => _ViewPollState();
}

class _ViewPollState extends State<ViewPoll> {
  var  option, vote, poll_id, poll_idIdx;
  var caption;
  var option3 = false;

  var poll = false;
  bool v_poll = true,check=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7a9e9f),
        title: Text(" View Poll",
        style: TextStyle(
          //fontSize: 35,
        ),),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Profile")
              .where('uid', isEqualTo: widget.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int i;
              try {
                poll_id = snapshot.data?.docs[0]['poll_id'];
                for (i = 0; i < poll_id.length; i++) {
                  if (snapshot.data?.docs[0]['poll_id'][i] ==
                      FirebaseAuth.instance.currentUser!.uid.toString()) {
                    break;
                  }
                }
                i = 0;
                if (i == poll_id.length) {
                  poll = true;
                }

                option = snapshot.data?.docs[0]['options'];

                caption = snapshot.data?.docs[0]['caption'];
                vote = snapshot.data?.docs[0]['votes'];
                try {
                  print(option[2]);
                  option3 = true;
                } catch (e) {
                  option3 = false;
                }
                check=true;
              } catch (e) {
                v_poll = false;
                check=false;
              }
              ;
            }

            return v_poll == true && check==true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        caption,
                        style: TextStyle(fontSize: 22),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (poll == true) {
                              poll = false;

                              poll_id.add(FirebaseAuth.instance.currentUser!.uid
                                  .toString());

                              int temp = int.parse(vote[0]);
                              temp++;
                              vote[0] = temp.toString();
                              FirebaseFirestore.instance
                                  .collection("Profile")
                                  .doc(widget.uid)
                                  .update({
                                'votes': vote,
                                'poll_id': poll_id,
                              });
                            }
                          },
                          child: Text(
                            option[0],
                            style: TextStyle(fontSize: 22),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            if (poll == true) {
                              poll = false;

                              poll_id.add(FirebaseAuth.instance.currentUser!.uid
                                  .toString());

                              int temp = int.parse(vote[1]);
                              temp++;
                              vote[1] = temp.toString();
                              FirebaseFirestore.instance
                                  .collection("Profile")
                                  .doc(widget.uid)
                                  .update({
                                'votes': vote,
                                'poll_id': poll_id,
                              });
                            }
                          },
                          child: Text(
                            option[1],
                            style: TextStyle(fontSize: 22),
                          )),
                      option3 == true
                          ? ElevatedButton(
                              onPressed: () {
                                if (poll == true) {
                                  poll = false;

                                  poll_id.add(FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString());

                                  int temp = int.parse(vote[2]);
                                  temp++;
                                  vote[2] = temp.toString();
                                  FirebaseFirestore.instance
                                      .collection("Profile")
                                      .doc(widget.uid)
                                      .update({
                                    'votes': vote,
                                    'poll_id': poll_id,
                                  });
                                }
                              },
                              child: Text(
                                option[2],
                                style: TextStyle(fontSize: 22),
                              ))
                          : Center(),
                      ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("Profile")
                                .doc(widget.uid)
                                .update({
                              'options': FieldValue.delete(),
                              'votes': FieldValue.delete(),
                              'poll_id': FieldValue.delete(),
                            });
                          },
                          child: Text("Delete pole")),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>poll_graph(widget.uid)));


                      }, child: Text("view poll graph"))
                    ],
                  )
                : Center(
                    child: Text("No poll has created",style: TextStyle(fontSize: 21),),
                  );
          }),
      backgroundColor: Color(0xffb8d8d8),
    );
  }
}
