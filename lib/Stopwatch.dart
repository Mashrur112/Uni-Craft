import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_craft/laps_component.dart';

class StopWatchView extends StatefulWidget {
  const StopWatchView({Key? key}) : super(key: key);

  @override
  State<StopWatchView> createState() => _StopWatchViewState();
}

class _StopWatchViewState extends State<StopWatchView> {
  Stopwatch? _stopwatch;
  String savedTime = "";
  List saved = [];

  final List buttons = const ['Start', 'Stop', 'Reset', 'Save'];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    Timer _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4f6367),
      appBar: AppBar(
        backgroundColor: const Color(0xff4f6367),
        title: const Text(
          "Stopwatch",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                formatTime(_stopwatch!.elapsedMilliseconds),
                style: const TextStyle(color: Colors.white, fontSize: 80),
              ),
              const SizedBox(
                height: 30,
              ),
              LapsComponent(savedTime: saved),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          start();
                        },
                        shape: const StadiumBorder(
                            side: BorderSide(color: Color(0xff4f6367))),
                        child: const Text(
                          "start",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          stop();
                        },
                        shape: const StadiumBorder(
                            side: BorderSide(color: Color(0xff4f6367))),
                        child: const Text(
                          "stop",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          reset();
                        },
                        shape: const StadiumBorder(
                            side: BorderSide(color: Color(0xff4f6367))),
                        child: const Text(
                          "reset",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          save();
                        },
                        shape: const StadiumBorder(
                            side: BorderSide(color: Color(0xff4f6367))),
                        child: const Text(
                          "save",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  start() {
    _stopwatch!.start();
  }

  stop() {
    _stopwatch!.stop();
  }

  reset() {
    _stopwatch!.reset();
  }

  save() {
    setState(() {
      savedTime = formatTime(_stopwatch!.elapsedMilliseconds);
      saved.add(savedTime);
    });
  }
}

String formatTime(int milliseconds) {
  // to return time in form '00:00:00'
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}
