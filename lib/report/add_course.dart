import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_craft/report/marks_section.dart';

class add_course extends StatefulWidget{
  @override
  State<add_course> createState() => _add_courseState();
}

class _add_courseState extends State<add_course> {
  var course_n=TextEditingController();

  List course_name=[];

  var join_code;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
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
            return Column(
              children: [
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(

                        actions: <Widget>[
                          TextField(
                            controller:course_n ,
                          ),
                          ElevatedButton(onPressed: (){
                            course_name.add(course_n.text.toString());
                            FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                              'course':course_name,
                            });
                            setState(() {
                              Navigator.pop(context);
                            });


                          }, child: Text("Add"))

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
                  shrinkWrap: true,
                    itemCount:course_name.length,
                    itemBuilder: (context,index){
                      return ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>marks_sec()));

                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(course_name[index]),

                          GestureDetector(
                              onTap: (){
                                course_name.removeAt(index);
                                FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                  'course':course_name,

                                });
                                setState(() {

                                });
                              },
                              child: Icon(Icons.delete,size: 20,)),
                        ],
                      ));
                    }),
              ],
            );
          })


        ],

      )


    );
  }
}