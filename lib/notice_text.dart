import 'package:flutter/material.dart';

class notice_text extends StatelessWidget{
  var text;
  notice_text(this.text, {super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notice"),

      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(text,style: const TextStyle(fontSize: 20),),
        ),
      ),



    );
  }

}