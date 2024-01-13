import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_craft/study_Materials.dart';

class marks_sec extends StatefulWidget {
  @override
  State<marks_sec> createState() => _marks_secState();
}

class _marks_secState extends State<marks_sec> {
  var quiz = TextEditingController();

  var quiz_m = '0';

  var mid = TextEditingController();

  var mid_m = '0';

  var fina = TextEditingController();

  var fina_m = '0';

  var attend = TextEditingController();

  var attend_m = '0';

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  actions: <Widget>[
                    TextField(
                      controller: quiz,
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          quiz_m = quiz.text.toString();

                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Add"))
                  ],
                ),
              );
            },
            child: Container(
              height: 0.07 * screenH,
              width: screenW,
              color: Colors.red,
              child: Text("Quiz marks    -$quiz_m"),
            ),
          )
        ],
      ),
    );
  }
}
