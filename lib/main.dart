import 'package:flutter/material.dart';

void main() {
  runApp( Craft());
}
class Craft extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Uni Craft",
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Homepage(),
    );

  }


}
class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),

      ),
      body: Center(
        child: Container(
          width: 200,
            height: 200,
            child: Center(child: Text("Mashrur")),
          color: Colors.blue.shade50

        ),
      )
    );
  }

}


