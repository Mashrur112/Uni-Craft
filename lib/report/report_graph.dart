import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class report_graph extends StatelessWidget{

  List course=[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").snapshots(), builder: (context,snapshots){

       if(snapshots.hasData)
         {
           var res=snapshots.data!.docs.toList();
           for(var r in res)
             {
               if(r['uid']==FirebaseAuth.instance.currentUser!.uid)
                 {
                   course=r['course'];

                 }
             }

         }
       return Center(
         child: Container(
           height: 550,

           child: BarChart(
               BarChartData(
                 borderData: FlBorderData(
                   border: Border(
                   top:BorderSide.none,
                     right: BorderSide.none,
                     left: BorderSide(width: 2),
                     bottom: BorderSide(width: 2),


                   )

                 ),

                 barGroups: [
                   BarChartGroupData(x: 1,
                     barRods: [
                       BarChartRodData(toY: 10,color: Colors.yellow)
                     ]


                   ),
                  // BarChartGroupData(x: 6)
                 ]


               )

           ),
         ),
       );
     }),


   );
  }

}