import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/study_Materials.dart';

class marks_sec extends StatefulWidget {
  List temp=[];

  marks_sec(this.temp);





  @override
  State<marks_sec> createState() => _marks_secState();
}

class _marks_secState extends State<marks_sec> {
  var m;




  var quiz = TextEditingController();


  var quiz_m ,mid_m,final_m;


  var mid = TextEditingController();



  var fina = TextEditingController();

  var fina_m = '0';

  var attend = TextEditingController();

  var attend_m = '0';

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body:StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").snapshots(), builder: (context,snapshots){
        if(snapshots.hasData)
          {
            var res=snapshots.data?.docs.toList();
            for(var r in res!)
              {
                if(r['uid']==FirebaseAuth.instance.currentUser!.uid)
                  {
                    try {
                      quiz_m = r['course'][widget.temp[1]]['quiz'];
                      mid_m = r['course'][widget.temp[1]]['mid'];
                      final_m = r['course'][widget.temp[1]]['final'];
                    }catch(e)
        {
          quiz_m='0';
          mid_m=final_m='0';
        }
                  }
              }
          }

        return
        Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    actions: <Widget>[
                      TextField(
                        controller: quiz,
                        keyboardType: TextInputType.number,
                      ),
                      ElevatedButton(
                          onPressed: () {


                            widget.temp[0][widget.temp[1]]['quiz']=quiz.text.toString();
                            FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                              'course':widget.temp[0],
                            });


                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Add"))
                    ],
                  ),
                );
              },
              child: Container(
                height: 0.07 * screenH,
                width: screenW,
                color: Colors.red,
                child: Center(child: Text("Quiz marks    $quiz_m",style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    actions: <Widget>[
                      TextField(
                        controller: mid,
                        keyboardType: TextInputType.number,
                      ),
                      ElevatedButton(
                          onPressed: () {


                            widget.temp[0][widget.temp[1]]['mid']=mid.text.toString();
                            FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                              'course':widget.temp[0],
                            });


                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Add"))
                    ],
                  ),
                );
              },
              child: Container(
                height: 0.07 * screenH,
                width: screenW,
                color: Colors.blue,
                child: Center(child: Text("Mid marks    $mid_m",style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    actions: <Widget>[
                      TextField(
                        controller: fina,
                        keyboardType: TextInputType.number,
                      ),
                      ElevatedButton(
                          onPressed: () {


                            widget.temp[0][widget.temp[1]]['final']=fina.text.toString();
                            FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                              'course':widget.temp[0],
                            });


                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Add"))
                    ],
                  ),
                );
              },
              child: Container(
                height: 0.07 * screenH,
                width: screenW,
                color: Colors.green,
                child: Center(child: Text("Final marks    $final_m",style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
            )

          ],
        );

      })


    );
  }
}
