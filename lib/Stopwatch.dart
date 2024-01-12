import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class StopWatchView extends StatefulWidget {
  const StopWatchView({super.key});

  @override
  State<StopWatchView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StopWatchView> {
  final Stopwatch stopwatch = Stopwatch();
  late Timer timer;
  String result = '00:00:00';

  void _start() {
    // Timer.periodic() will call the callback function every 100 milliseconds
    timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {
        // result in hh:mm:ss format
        result =
            '${stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
      });
    });

    stopwatch.start();
  }

  void _stop() {
    timer.cancel();
    stopwatch.stop();
  }

  void _reset() {
    _stop();
    stopwatch.reset();
    result = '00:00:00';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4f6367),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Stopwatch',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 2,
            ),
            Stack(
              children: [
                Center(
                  child: Transform.scale(
                    scale: 6,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.white70,
                      value: stopwatch.isRunning ? null : 0,
                      strokeWidth: 1,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    result,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => AudioPlayer()
                      .play(AssetSource('audio/peking_opera_drum_1.mp3')),
                  tooltip: 'Buzz',
                  icon: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 96, 156, 168),
                  onPressed: () {
                    setState(() {
                      stopwatch.isRunning ? _stop() : _start();
                    });
                  },
                  tooltip: 'Play / Pause',
                  shape: const CircleBorder(),
                  child: Icon(
                    stopwatch.isRunning
                        ? CupertinoIcons.pause_solid
                        : CupertinoIcons.play_arrow_solid,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: _reset,
                  tooltip: 'reset',
                  icon: const Icon(
                    CupertinoIcons.repeat,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
