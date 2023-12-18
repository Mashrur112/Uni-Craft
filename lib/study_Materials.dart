import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

import 'delete_file.dart';
import 'delete_link.dart';

class study_Materials extends StatefulWidget {
  @override
  State<study_Materials> createState() => _study_MaterialsState();
}

class _study_MaterialsState extends State<study_Materials> {
  var join_code;
  var show = false;

  int c = 0;
  int b = 0;
  int count = 0, count1 = 0, image_nidx = 0, img_lidx = 0,file_nidx=0,file_lidx=0,l=0,l1=0,count2=0,count3=0;
  var link = [];
  var name = [];
  var role;
  var url;
  var image_name = [];
  var image_link = [];
  var file_name = [];
  var file_link = [];
  int index1=0;
  var link_cap=[];
  var link_l=[];


  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Study Materials"),
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(text: "Media", icon: Icon(Icons.photo)),
              Tab(text: "File", icon: Icon(Icons.file_copy_sharp)),
              Tab(text: "Link", icon: Icon(Icons.link)),
            ]),
            Expanded(
              child: TabBarView(children: [
                Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Profile")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          c = 0;
                          b = c + 1;
                          count = 0;
                          count1 = 0;
                          image_nidx = 0;
                          img_lidx = 0;

                          final res = snapshot.data!.docs.toList();
                          for (var r in res!) {
                            if (r['uid'] ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              join_code = r['code'];
                              role = r['role'];

                              break;
                            }
                          }
                          for (var r in res!) {
                            if (r['code'] == join_code.toString() &&
                                r['role'] == "Administrator") {
                              //print(count1);

                              while (true) {
                                try {
                                  if (r[c.toString()] == "")
                                    break;
                                  else {
                                    link.insert(
                                        count1,
                                        snapshot.data!.docs[count][c.toString()]
                                            .toString());
                                    name.insert(
                                        count1,
                                        snapshot.data!.docs[count][b.toString()]
                                            .toString());
                                    if (name[count1].contains('.jpg') ||
                                        name[count1].contains('.jpeg') ||
                                        name[count1].contains('.png') ||
                                        name[count1].contains('.raw') ||
                                        name[count1].contains('.jfif') ||
                                        name[count1].contains('.pjpeg') ||
                                        name[count1].contains('.pjp') ||
                                        name[count1].contains('.svj')) {
                                      image_name.insert(
                                          image_nidx,
                                          snapshot
                                              .data!.docs[count][b.toString()]
                                              .toString());
                                      image_link.insert(
                                          img_lidx,
                                          snapshot
                                              .data!.docs[count][c.toString()]
                                              .toString());
                                      image_nidx++;
                                      img_lidx++;
                                    }
                                    count1++;
                                    c = c + 2;
                                    b = c + 1;
                                  }
                                } catch (e) {
                                  break;
                                }
                              }
                            } else
                              count++;
                          }
                        }

                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, ((50 / 872) * screenH), 0, 0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.9 / 3,
                            ),

                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            physics: BouncingScrollPhysics(),
                            //padding: EdgeInsets.all(21),
                            itemCount: img_lidx,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    height: (150 / 872) * screenH,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final url =
                                            Uri.parse(image_link[index]);
                                        if (!await launchUrl(url))
                                          throw Exception(
                                              'Could not launch $url');
                                      },

                                      child: CachedNetworkImage(
                                        imageUrl: image_link[index],
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child: Text(image_name[index])),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),

                                      // Text(
                                      //   name[index],
                                      //   style: TextStyle(
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ),
                                  ),
                                  // SizedBox.fromSize(size: Size(0,50),),
                                  role == "Administrator"
                                      ? ElevatedButton(
                                          onPressed: () {
                                            for(int i=0;i<count1;i++)
                                              {
                                                if(image_name[index]==name[i])
                                                  {
                                                    index1=i;
                                                    break;
                                                  }


                                              }
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        delete_file(name, link,
                                                            index1, count1)));
                                          },
                                          child: Text("Delete"))
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        );
                      }),
                ),
                Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Profile")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          c = 0;
                          b = c + 1;
                          count = 0;
                          count1 = 0;
                          file_nidx = 0;
                          file_lidx = 0;

                          final res = snapshot.data!.docs.toList();
                          for (var r in res!) {
                            if (r['uid'] ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              join_code = r['code'];
                              role = r['role'];

                              break;
                            }
                          }
                          for (var r in res!) {
                            if (r['code'] == join_code.toString() &&
                                r['role'] == "Administrator") {
                              //print(count1);

                              while (true) {
                                try {
                                  if (r[c.toString()] == "")
                                    break;
                                  else {

                                    if (!name[count1].contains('.jpg') &&
                                        !name[count1].contains('.jpeg') &&
                                        !name[count1].contains('.png') &&
                                        !name[count1].contains('.raw') &&
                                        !name[count1].contains('.jfif') &&
                                        !name[count1].contains('.pjpeg') &&
                                        !name[count1].contains('.pjp') &&
                                        !name[count1].contains('.svj')) {
                                      file_name.insert(
                                          file_nidx,
                                          snapshot
                                              .data!.docs[count][b.toString()]
                                              .toString());
                                      file_link.insert(
                                          file_lidx,
                                          snapshot
                                              .data!.docs[count][c.toString()]
                                              .toString());
                                      file_lidx++;
                                      file_nidx++;
                                    }
                                    count1++;
                                    c = c + 2;
                                    b = c + 1;
                                  }
                                } catch (e) {
                                  break;
                                }
                              }
                            } else
                              count++;
                          }
                        }

                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, ((50 / 872) * screenH), 0, 0),
                          child: ListView.builder(


                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            physics: BouncingScrollPhysics(),
                            //padding: EdgeInsets.all(21),
                            itemCount: file_lidx,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    height: (40 / 872) * screenH,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final url =
                                            Uri.parse(file_link[index]);
                                        if (!await launchUrl(url))
                                          throw Exception(
                                              'Could not launch $url');
                                      },

                                      child: Text(file_name[index]),

                                      // Text(
                                      //   name[index],
                                      //   style: TextStyle(
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ),
                                  ),
                                  // SizedBox.fromSize(size: Size(0,50),),
                                  role == "Administrator"
                                      ? ElevatedButton(
                                          onPressed: () {
                                            for(int i=0;i<count1;i++)
                                            {
                                              if(file_name[index]==name[i])
                                              {
                                                index1=i;
                                                break;
                                              }


                                            }


                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        delete_file(name, link,
                                                            index1, count1)));
                                          },
                                          child: Text("Delete"))
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        );
                      }),
                ),
                Container(
                  child:
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Profile")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          l = 0;
                          l1 = l + 1;
                          count2 = 0;
                          count3 = 0;

                          final res = snapshot.data!.docs.toList();
                          for (var r in res!) {
                            if (r['uid'] ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              join_code = r['code'];
                              role = r['role'];

                              break;
                            }
                          }
                          for (var r in res!) {
                            if (r['code'] == join_code.toString() &&
                                r['role'] == "Administrator") {

                              //print(count1);

                              while (true) {
                                try {

                                  if (r['link'+l.toString()] == "")
                                    break;
                                  else {

                                    link_cap.insert(
                                        count2,
                                        snapshot.data!.docs[count3]['link'+l.toString()]
                                            .toString());
                                    link_l.insert(
                                        count2,
                                        snapshot.data!.docs[count3]['link'+l1.toString()]
                                            .toString());

                                    count2++;
                                    l = l + 2;
                                    l1 = l + 1;
                                  }
                                } catch (e) {
                                  break;
                                }
                              }
                            } else
                              count3++;
                          }
                        }

                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, ((50 / 872) * screenH), 0, 0),
                          child: ListView.builder(


                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            physics: BouncingScrollPhysics(),
                            //padding: EdgeInsets.all(21),
                            itemCount: count2,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    height: (70 / 872) * screenH,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final url =
                                        Uri.parse(link_l[index]);

                                        if (!await launchUrl(url))

                                          throw Exception(
                                              'Could not launch $url');
                                      },

                                      child: Text(link_cap[index]),

                                      // Text(
                                      //   name[index],
                                      //   style: TextStyle(
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ),
                                  ),
                                  // SizedBox.fromSize(size: Size(0,50),),
                                  role == "Administrator"
                                      ? ElevatedButton(
                                      onPressed: () {




                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    delete_link(link_cap, link_l,
                                                        index, count2)));
                                      },
                                      child: Text("Delete"))
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        );
                      }),


                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
