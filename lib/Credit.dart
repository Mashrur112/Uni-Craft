import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class credit extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Credits"),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 500,

          child:Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("\nTeam Name: Phantom 49",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                Text("  \nMembers-\n\nMashrur Rahman\nAhnuf karim Chowdhury\nHasibur Rahman Srijon\nMahi\nTahsinur Rahman",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              ],
            ),
          ),
        ),
      ),

    );
  }

}