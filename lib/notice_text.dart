import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notice_text extends StatelessWidget{
  var text;
  notice_text(this.text);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffb8d8d8),
      appBar: AppBar(
        title: Text("Description"),
        backgroundColor: Color(0xff7a9e9f),

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(text,style: TextStyle(fontSize: 20),),
        ),
      ),



    );
  }

}