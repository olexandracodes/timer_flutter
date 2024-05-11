import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer;
  int _secondsElapsed = 0;
  bool _timerRunning = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _incrementTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _incrementTimer(Timer timer) {
    if (_timerRunning) {
      setState(() {
        _secondsElapsed++;
      });
    }
  }

  void _toggleTimer() {
    setState(() {
      _timerRunning = !_timerRunning;
    });
  }

  void _resetTimer() {
    setState(() {
      _secondsElapsed = 0;
      _timerRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Elapsed: $_secondsElapsed seconds',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleTimer,
                  child: Text(_timerRunning ? 'Stop Timer' : 'Start Timer'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset Timer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
