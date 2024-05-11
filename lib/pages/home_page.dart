import 'package:flutter/material.dart';
import 'package:timer_flutter/data/database.dart';
import 'package:timer_flutter/layout/nav_bar.dart';
import 'package:timer_flutter/pages/ip_page.dart';
import 'package:timer_flutter/pages/settings_page.dart';
import 'package:timer_flutter/pages/timer_page.dart';
import 'package:timer_flutter/src/app_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IpDataBase db = IpDataBase();

  int _selectedIndex = 0;

  Future<void> fetchData() async {
    await db.loadData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 2) {
        _selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const TimerPage(),
      const IpInfoWiget(),
      settingsPage(context),
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
