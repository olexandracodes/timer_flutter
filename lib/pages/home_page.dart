import 'package:flutter/material.dart';
import 'package:timer_flutter/layout/nav_bar.dart';
import 'package:timer_flutter/pages/ip_page.dart';
import 'package:timer_flutter/pages/settings_page.dart';
import 'package:timer_flutter/pages/timer_page.dart';
import 'package:timer_flutter/src/app_styles.dart'; // Import SettingsPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const TimerPage(),
      const IpInfoWiget(),
      const SettingsPage(), // Include SettingsPage only once
    ];

    return Scaffold(
      backgroundColor: AppColors.appMainBackground,
      bottomNavigationBar: bottomNavigationBar(
        _selectedIndex,
        _onTabTapped,
      ),
      body: Stack(
        children: [
          Center(
            child: pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
