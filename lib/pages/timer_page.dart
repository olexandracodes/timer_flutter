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
  bool _timerRunning = false;
  late AnimationController _actionAnimationController;
  late AnimationController _pulseAnimationController;
  late Animation<double> _pulseAnimation;
  late AnimationController _shadowAnimationController;
  late Animation<Color?> _shadowAnimation;

  final List<Color> shadowColors = [
    AppColors.pastelOrange,
    AppColors.pastelBlue,
    AppColors.pastelGreen,
    AppColors.pastelRed,
    AppColors.pastelPink,
    AppColors.pastelPurple,
    AppColors.pastelTeal,
  ];

  @override
  void initState() {
    super.initState();
    _pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(_pulseAnimationController);

    _actionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _shadowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    )..repeat();
    _shadowAnimation = ColorTween(
      begin: shadowColors[0],
      end: shadowColors[shadowColors.length - 1],
    ).animate(_shadowAnimationController);

    _timer = Timer.periodic(const Duration(seconds: 1), _incrementTimer);
  }

  @override
  void dispose() {
    _pulseAnimationController.dispose();
    _shadowAnimationController.dispose();
    _actionAnimationController.dispose();
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
    if (_timerRunning) {
      _startActionAnimation();
    } else {
      _stopActionAnimation();
    }
  });
}

void _resetTimer() {
  setState(() {
    _secondsElapsed = 0;
    _timerRunning = false;
    _stopActionAnimation();
  });
}

  void _startActionAnimation() {
  _actionAnimationController.forward();
}

void _stopActionAnimation() {
  _actionAnimationController.reverse();
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
            GestureDetector(
              onTap: _toggleTimer,
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.appSecondaryBackground,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: _shadowAnimation.value!,
                            spreadRadius: 5,
                            blurRadius: 20,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Center(
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _actionAnimationController,
                        size: 100,
                        color: _timerRunning ? AppColors.lightOrange : AppColors.appOrange,
                      ),
                    ),
                    ),
                  );
                },
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
