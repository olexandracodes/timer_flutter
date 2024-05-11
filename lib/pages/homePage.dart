import 'package:flutter/material.dart';
import 'package:timer_flutter/data/database.dart';
// import 'package:timer_flutter/layout/app_bar.dart';
import 'package:timer_flutter/layout/nav_bar.dart';
import 'package:timer_flutter/pages/ipInfoWigetPage.dart';
import 'package:timer_flutter/pages/settingsPage.dart';
import 'package:timer_flutter/pages/timerWigetPage.dart';
import 'package:timer_flutter/src/app_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IpDataBase db = IpDataBase();

  int _selectedIndex = 0;
  final timerController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime timestamp = DateTime.now();

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
    timerController.dispose();
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
      // appBar: myAppBar(),
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
