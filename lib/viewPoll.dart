import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/poll_graph.dart';

class ViewPoll extends StatefulWidget {
  var uid,role;

  ViewPoll(this.uid,this.role);

  @override
  State<ViewPoll> createState() => _ViewPollState();
}

class _ViewPollState extends State<ViewPoll> {
  var option, vote, poll_id, poll_idIdx;
  var caption;
  var option3 = false;

  var poll = false;
  bool v_poll = true, check = false;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7a9e9f),
        title: Text(
          "View Poll",
          style: TextStyle(
              //fontSize: 35,
              ),
        ),
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
              check = true;
            } catch (e) {

              v_poll = false;
              check = false;
            }
          }

          return v_poll == true && check == true
              ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
                child: Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(
                        vertical: 0.22 * screenH, horizontal: 0.02 * screenW),
                    color: Color(0xff77a5b5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 0.9 * screenW,
                            height: 0.07 * screenH,
                            child: Card(
                              color: Color(0xffd5eded),
                              elevation: 5,
                              child: Center(
                                child: Text(
                                  caption,
                                  maxLines: 2,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 0.03 *
                                  screenH), // Add some space between the caption and buttons
                          Container(
                            width: 0.6 * screenW,
                            height: 0.06 * screenH,
                            child: Card(
                              elevation: 2,
                              color: Color(0xff218D97),
                              child: GestureDetector(
                                onTap: () {
                                  print("Op1");


                                  if (poll == true) {
                                    poll = false;

                                    poll_id.add(
                                      FirebaseAuth.instance.currentUser!.uid
                                          .toString(),
                                    );

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
                                child: Center(
                                  child: Text(
                                    option[0],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 0.01 *
                                  screenH), // Add some space between the buttons
                          Container(
                            width: 0.6 * screenW,
                            height: 0.06 * screenH,
                            child: Card(
                              elevation: 2,
                              color: Color(0xff196B72),
                              child: GestureDetector(
                                onTap: () {
                                  print("op2");
                                  if (poll == true) {
                                    poll = false;

                                    poll_id.add(
                                      FirebaseAuth.instance.currentUser!.uid
                                          .toString(),
                                    );

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
                                child: Center(
                                  child: Text(
                                    option[1],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 0.01 * screenH),
                          option3 == true
                              ? Container(
                                  width: 0.6 * screenW,
                                  height: 0.06 * screenH,
                                  child: Card(
                                    elevation: 2,
                                    color: Color(0xff14545A),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (poll == true) {
                                          poll = false;

                                          poll_id.add(
                                            FirebaseAuth.instance.currentUser!.uid
                                                .toString(),
                                          );

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
                                      child: Center(
                                        child: Text(
                                          option[2],
                                          style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(height: 0.04*screenH),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              widget.role=="Administrator"?
                              Container(
                                height: 0.05*screenH,
                                width: 0.3*screenW,
                                decoration: BoxDecoration(
                                  color: Color(0xffa84747),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection("Profile")
                                        .doc(widget.uid)
                                        .update({
                                      'options': FieldValue.delete(),
                                      'votes': FieldValue.delete(),
                                      'poll_id': FieldValue.delete(),
                                    });
                                  },
                                  child: Center(child: Text("Delete Poll",style: TextStyle(color: Colors.white),)),
                                ),
                              ):Center(),
                              SizedBox.fromSize(size: Size(0.02*screenW,0),),
                              Container(
                                height: 0.05*screenH,
                                width: 0.3*screenW,
                                decoration: BoxDecoration(
                                  color: Color(0xff3f7070),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            poll_graph(widget.uid),
                                      ),
                                    );
                                  },
                                  child:Center(child: Text("Poll Graph",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                            ],
                          ),
                          // Adjust the height as needed
                        ],
                      ),
                    ),
                  ),
              )
              : Center(
                  child: Text(
                    "No poll has been created",
                    style: TextStyle(fontSize: 21),
                  ),
                );
        },
      ),
      backgroundColor: Color(0xffb8d8d8),
    );
  }
}
