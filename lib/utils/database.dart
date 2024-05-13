import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IpDataBase {
  SharedPreferences? _prefs;
  List<Map<String, dynamic>> ipData = [];

  Future<void> createInitialData() async {
    _prefs = await SharedPreferences.getInstance();
    await loadData();
  }

  Future<void> loadData() async {
    _prefs ??= await SharedPreferences.getInstance();
    final jsonData = _prefs!.getString('ipData');
    if (jsonData != null) {
      ipData = List<Map<String, dynamic>>.from(json.decode(jsonData));
    }
  }

  Future<void> updateDataBase(Map<String, dynamic> newData) async {
    try {
      ipData.add(newData);
      await _saveDataToPrefs();
    } catch (e) {
      if (kDebugMode) {
        print('Error updating data: $e');
      }
    }
  }

  Future<void> _saveDataToPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    final jsonData = json.encode(ipData);
    await _prefs!.setString('ipData', jsonData);
  }

  Map<String, dynamic>? getLastSuccessfulData() {
    if (ipData.isNotEmpty) {
      return ipData.last;
    } else {
      return null;
    }
  }
}

extension IterableExtensions<T> on Iterable<T> {
  T? get firstOrNull => isNotEmpty ? first : null;
}
