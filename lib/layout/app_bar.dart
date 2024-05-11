import 'package:flutter/material.dart';
import 'package:timer_flutter/src/app_styles.dart';

AppBar myAppBar() {
  return AppBar(
    title: const Text('',
        style: TextStyle(
            color: AppColors.appTitle,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 24)),
    backgroundColor: AppColors.appMainBackground,
    elevation: 0,
  );
}
