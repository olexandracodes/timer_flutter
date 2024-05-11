import 'package:flutter/material.dart';
import 'package:timer_flutter/src/app_styles.dart';

ClipRRect bottomNavigationBar(int index, void Function(int index) onTabTapped) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(50.0),
      topRight: Radius.circular(50.0),
    ),
    child: BottomNavigationBar(
      selectedItemColor: AppColors.darkGray,
      unselectedItemColor: AppColors.lightGray,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      onTap: (index) => onTabTapped(index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),
          label: 'IP',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    ),
  );
}
