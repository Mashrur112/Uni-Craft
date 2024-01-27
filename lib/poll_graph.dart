import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class poll_graph extends StatelessWidget {
  var uid;
  poll_graph(this.uid);
  var votes = [], total, options = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Profile")
                .where('uid', isEqualTo: uid)
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                total = 0;

                votes = snapshots.data?.docs[0]['votes'];
                options = snapshots.data?.docs[0]['options'];
                try {
                  total = 0;
                  for (int i = 0; i < 3; i++) {
                    total = total + int.parse(votes[i]);
                  }
                } catch (e) {
                  total = 0;
                  votes.insert(2, "0");
                  for (int i = 0; i < 3; i++) {
                    total = total + int.parse(votes[i]);
                  }
                }
              }
              return Center(
                child: Container(
                  width: 600,
                  height: 600,
                  color: Colors.white,
                  child: PieChart(PieChartData(
                      centerSpaceRadius: 6,
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      sections: [
                        votes[0] != '0'
                            ? PieChartSectionData(
                                title: options[0] + (":") + votes[0] + "votes",
                                value: ((int.parse(votes[0]) / total) * 100),
                                color: Colors.yellow,
                                radius: 100)
                            : PieChartSectionData(
                                value: ((int.parse(votes[0]) / total) * 100),
                                color: Colors.yellow,
                                radius: 100),
                        votes[1] != '0'
                            ? PieChartSectionData(
                                title: options[1] + (":") + votes[1] + "votes",
                                value: ((int.parse(votes[1]) / total) * 100),
                                color: Colors.blue,
                                radius: 100)
                            : PieChartSectionData(
                                value: ((int.parse(votes[1]) / total) * 100),
                                color: Colors.blue,
                                radius: 100),
                        votes[2] != '0'
                            ? PieChartSectionData(
                                title: options[2] + (":") + votes[2] + "votes",
                                value: ((int.parse(votes[2]) / total) * 100),
                                color: Colors.white,
                                radius: 100)
                            : PieChartSectionData(
                                value: ((int.parse(votes[2]) / total) * 100),
                                color: Colors.white,
                                radius: 100),
                      ])),
                ),
              );
            }));
  }
}
