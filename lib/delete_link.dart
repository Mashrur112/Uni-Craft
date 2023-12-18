import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_craft/study_Materials.dart';

class delete_link extends StatefulWidget{
  var name=[],link=[];
  var index;
  var count1;
  delete_link(this.name,this.link,this.index,this.count1);

  @override
  State<delete_link> createState() => _delete_linkState();
}

class _delete_linkState extends State<delete_link> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").snapshots(), builder: (context,snapshot){
        if(snapshot.hasData)
        {
          int idx_link=widget.index;
          final res=snapshot.data!.docs.toList();
          for(var r in res!) {
            if (r['uid'] == FirebaseAuth.instance.currentUser!.uid) {

              while(true){
                // print(widget.index);
                // print(widget.count1);
                if(widget.index==widget.count1)
                  break;
                else{

                  if(widget.index==(widget.count1-1)) {
                    FirebaseFirestore.instance.collection("Profile").doc(
                        FirebaseAuth.instance.currentUser!.uid).update({
                      'link'+(2*widget.index).toString(): "",
                      'link'+((2*widget.index) + 1).toString(): "",
                    });
                    break;
                  }
                  else{
                    idx_link=idx_link+1;

                    FirebaseFirestore.instance.collection("Profile").doc(FirebaseAuth.instance.currentUser!.uid).update({
                     'link'+ (2*widget.index).toString():widget.name[idx_link].toString(),
                      'link'+((2*widget.index)+1).toString():widget.link[idx_link].toString(),
                    });

                    widget.index++;}}
              }
            }
          }
        }
        return Center();
      }),

    );
  }
}