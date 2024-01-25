import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_craft/report/marks_section.dart';
import 'package:uni_craft/report/report_graph.dart';

class add_course extends StatefulWidget{
  @override
  State<add_course> createState() => _add_courseState();
}

class _add_courseState extends State<add_course> {

  var course_n=TextEditingController();
  //var twoDList = List<List>.generate(1, (i) => List<dynamic>.generate(3, (index) => null, growable: false), growable: false);

  List course_name=<Map>[];

  var join_code;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
<<<<<<< HEAD
        appBar: AppBar(),
        body:Column(
          children: [
            StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").snapshots(), builder: (context,snapshots){
              if(snapshots.hasData)
              {
                var res=snapshots.data?.docs.toList();

                for(var r in res!)
                {
                  if(r['uid']==FirebaseAuth.instance.currentUser!.uid)
                  {
                    try{
                      course_name=r['course'];
                    }catch(e){

                    }
                  }
                }
              }
=======
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").snapshots(), builder: (context,snapshots){
              if(snapshots.hasData)
                {
                  var res=snapshots.data?.docs.toList();
        
                  for(var r in res!)
                    {
                      if(r['uid']==FirebaseAuth.instance.currentUser!.uid)
                        {
                          try{
                            course_name=r['course'];
                          }catch(e){
        
                          }
                        }
                    }
                }
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
<<<<<<< HEAD

=======
        
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4
                          actions: <Widget>[
                            TextField(
                              controller:course_n ,
                            ),
                            ElevatedButton(onPressed: (){
                              var map={};
                              map['Name']=course_n.text.toString();
                              map['quiz']=0;
                              map['mid']=0;
                              map['final']=0;
                              course_name.add(map);
                              FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                'course':course_name,
                              });
                              setState(() {
                                Navigator.pop(context);
                              });
<<<<<<< HEAD


                            }, child: Text("Add"))

=======
        
        
                            }, child: Text("Add"))
        
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4
                          ],
                        ),
                      );
                    },
                    child: Container(
                      height: 0.08*screenH,
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          Text("Add courses"),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
<<<<<<< HEAD
                      shrinkWrap: true,
=======
                    shrinkWrap: true,
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4
                      itemCount:course_name.length,
                      itemBuilder: (context,index){
                        return ElevatedButton(onPressed: (){
                          int idx=index;
                          List temp=[];
                          temp.add(course_name);
                          temp.add(idx);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>marks_sec(temp)));
<<<<<<< HEAD

                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(course_name[index]['Name']),

=======
        
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Text(course_name[index]['Name']),
        
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4
                            GestureDetector(
                                onTap: (){
                                  course_name.removeAt(index);
                                  FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                    'course':course_name,
<<<<<<< HEAD

                                  });
                                  setState(() {

=======
        
                                  });
                                  setState(() {
        
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4
                                  });
                                },
                                child: Icon(Icons.delete,size: 20,)),
                          ],
                        ));
                      }),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>report_graph()));
<<<<<<< HEAD

=======
        
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4
                  }, child: Text("Graph"))
                ],
              );
            })
<<<<<<< HEAD


          ],

        )
=======
        
        
          ],
        
        ),
      )
>>>>>>> 4b0d5b3ca56e345a0d21f5e4f53f1843d94e38e4


    );
  }
}