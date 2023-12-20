import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notice_text extends StatelessWidget{
  var text;
  notice_text(this.text);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Notice"),

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