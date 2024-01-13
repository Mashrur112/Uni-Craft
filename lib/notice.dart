



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_notice.dart';
import 'notice_text.dart';

class notice extends StatefulWidget{
  const notice({super.key});

  @override
  State<notice> createState() => _noticeState();
}

class _noticeState extends State<notice> {
  var index1;

  void del( idx)
  {
    index1=idx;
  }
  var strm_opn=false;

  var notice_n=[];

  var notice_t=[];

  int count1=0;
  int current_u=0;

  var del_n=false;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const add_notice()));



          }, icon: const Icon(Icons.add,color: Colors.green,)),


        ],

      ),
      body:



      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Profile")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData ) {
              final res = snapshots.data!.docs.toList();
              for (var r in res) {
                if (r['uid'] ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  int c = 1;
                  int t = c + 1;
                  int count=0;
                  count1=0;
                  ///print( r['notice'+c.toString()]);

                  while(true) {
                    try {

                      if (r['notice$c']!="" ) {




                        count1++;

                        notice_n.insert(count, r['notice$c']);
                        notice_t.insert(count, r['notice$t']);









                      }
                      c = c + 2;
                      t = c + 1;


                    } catch (e) {



                      break;
                    }
                  }
                  break;
                }
                current_u++;


              }
            }
            if(del_n==true)
              {


                // FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                //   'notice'+((index1*2)+1).toString():snapshots.data!.docs[current_u][ 'notice'+((index1*2)+3).toString()].toString(),
                //   "notice"+((index1*2)+2).toString():snapshots.data!.docs[current_u][ 'notice'+((index1*2)+4).toString()].toString(),
                //
                // });
                FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                  'notice${(index1)+1}':"",
                  "notice${(index1)+2}":"",

                });

                del_n=false;
                // setState(() {
                //
                // });




              }
            print(notice_n[1]);
            return ListView.builder(

                itemCount:count1 ,

                itemBuilder: (BuildContext context,int index){

                  return GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: (250/872)*screenH,
                          child: Card(
                            child: FittedBox(child: Text(notice_n[index],style: const TextStyle(color: Colors.black,fontSize: 20),)),

                          ),
                        ),
                        ElevatedButton(onPressed: (){

                          int total=count1-index-1;
                          print(total);


                          del(total);

                          setState(() {


                            del_n=true;

                          });


                        }, child: const Text("Delete")),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>notice_text(notice_t[index])));
                    },
                  );




            });
          }),

    );
  }
}