import 'package:flutter/material.dart';

class LapsComponent extends StatelessWidget {
  const LapsComponent({Key? key, required this.savedTime}) : super(key: key);
  final List savedTime;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: double.infinity,
          color: Color.fromARGB(255, 47, 63, 66),
          height: 80,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lap ${index + 1}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "${savedTime[index]}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              );
            },
            itemCount: savedTime.length,
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1,
                color: Colors.grey[350],
              );
            },
          )),
    );
  }
}
