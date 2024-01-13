import 'package:flutter/material.dart';

void main() {
  runApp( const Craft());
}
class Craft extends StatelessWidget{
  const Craft({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Uni Craft",
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: const Homepage(),
    );

  }


}
class Homepage extends StatelessWidget{
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),

        ),
        body: Center(
          child: Container(
              width: 200,
              height: 200,
              color: Colors.blue.shade50,
              child: const Center(child: Text("Mashrur"))

          ),
        )
    );
  }

}


