import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_flutter/src/app_styles.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  late Timer _timer;
  int _secondsElapsed = 0;
  double turns = 0.0;
  bool _timerRunning = false;
  bool isClicked = false;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _incrementTimer);
  }

  @override
  void dispose() {
    _animationController.dispose();
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
      backgroundColor: AppColors.appMainBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appSecondaryBackground,
        title: const Text(
          'Timer',
          style: TextStyle(color: AppColors.appBlue),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
              turns: turns,
              curve: Curves.easeInOut,
              duration: const Duration(
                seconds: 1,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (isClicked) {
                      setState(() {
                        turns -= 1 / 4;
                        _animationController.reverse();
                      });
                    } else {
                      setState(() {
                        turns += 1 / 4;
                        _animationController.forward();
                      });
                    }
                    isClicked = !isClicked;
                  });
                },
                child: AnimatedContainer(
                  curve: Curves.easeOutExpo,
                  duration: const Duration(
                    seconds: 1,
                  ),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.appSecondaryBackground,
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: isClicked ? const Offset(20, -20) : const Offset(20, 20),
                      ),
                       BoxShadow(
                        color: Colors.white,
                        spreadRadius: -5,
                        blurRadius: 20,
                        offset: isClicked ? const Offset(-20, 20) : const Offset(-20, -20),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _animationController,
                        size: 100,
                        color: AppColors.appOrange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
