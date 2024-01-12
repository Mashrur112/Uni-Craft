import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class poll_graph extends StatelessWidget{
  var uid;
  poll_graph(this.uid);
  var votes=[],total;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:StreamBuilder(stream: FirebaseFirestore.instance.collection("Profile").where('uid',isEqualTo: uid).snapshots(), builder: (context,snapshots){
        if(snapshots.hasData)
          {
            total=0;


            votes=snapshots.data?.docs[0]['votes'];
            try {
              total=0;
              for (int i = 0; i < 3; i++) {
                total = total + int.parse(votes[i]);
              }
            }catch(e)
        {
          total=0;
          votes.insert(2, "0");
          for (int i = 0; i < 3; i++) {
            total = total + int.parse(votes[i]);
          }

        }

            print(votes[2]);

          }
        return Center(
          child: Container(
            width: 400,
            height: 400,
            color: Colors.red,
            child: PieChart(
                PieChartData(
                  centerSpaceRadius: 5,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  sections: [
                    PieChartSectionData(
                      value: ((int.parse(votes[0])/total)*100),color: Colors.blue,radius: 100),
          PieChartSectionData(
              value: ((int.parse(votes[1])/total)*100),color: Colors.yellow,radius: 100),
                    PieChartSectionData(
                        value: ((int.parse(votes[2])/total)*100),color: Colors.white,radius: 100),
                  ]

                )
            ),
          ),
        );
      })



    );
  }





}