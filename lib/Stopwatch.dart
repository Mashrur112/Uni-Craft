import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';

class Timer_Stopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerStopwatchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimerStopwatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Timer & Stopwatch'),
          backgroundColor: Color(0xff7a9e9f),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Timer'),
              Tab(text: 'Stopwatch'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TimerView(),
            StopwatchView(),
          ],
        ),
      ),
    );
  }
}

class TimerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountDownTimer(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        hintColor: Colors.red,
      ),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  TextEditingController minuteController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  bool isTimerRunning = false;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    minuteController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;
      int minutes = int.tryParse(minuteController.text) ?? 0;
      int seconds = int.tryParse(secondController.text) ?? 0;
      int totalDuration = minutes * 60 + seconds;
      controller.duration = Duration(seconds: totalDuration);
      controller.reverse(from: 1.0);
    });
  }

  void pauseTimer() {
    setState(() {
      isTimerRunning = false;
      controller.stop();
    });
  }

  void resetTimer() {
    setState(() {
      isTimerRunning = false;
      controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xff4f6367),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.lightGreen,
                  height: controller.value * MediaQuery.of(context).size.height,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: CustomTimerPainter(
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Countdown Timer",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                    Text(
                                      timerString,
                                      style: TextStyle(
                                          fontSize: 112.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: minuteController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Minutes',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: secondController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Seconds',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FloatingActionButton.extended(
                          onPressed: isTimerRunning ? pauseTimer : startTimer,
                          backgroundColor: Color.fromARGB(255, 96, 156, 168),
                          foregroundColor: Colors.white,
                          icon: Icon(
                            isTimerRunning ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          label: Text(
                            isTimerRunning ? "Pause" : "Play",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: resetTimer,
                          backgroundColor: Color.fromARGB(255, 96, 168, 144),
                          foregroundColor: Colors.white,
                          icon: Icon(
                            Icons.stop,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Stop",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class StopwatchView extends StatefulWidget {
  const StopwatchView({super.key});

  @override
  State<StopwatchView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StopwatchView> {
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
