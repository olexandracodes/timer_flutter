import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timer_flutter/components/card_img.dart';
import 'package:timer_flutter/components/loading_dialog.dart';
import 'package:timer_flutter/data/database.dart';
import 'package:timer_flutter/src/app_styles.dart';
import 'package:latlng/latlng.dart' as latlng;
import 'package:marquee/marquee.dart';

class IpInfoWiget extends StatefulWidget {
  const IpInfoWiget({Key? key}) : super(key: key);

  @override
  _IpInfoWigetState createState() => _IpInfoWigetState();
}

class _IpInfoWigetState extends State<IpInfoWiget>
    with TickerProviderStateMixin {
  late Future<Map<String, dynamic>> _ipData;
  late IpDataBase _ipDataBase;
  late AnimationController _slideInAnimationController;

  @override
  void initState() {
    super.initState();
    _ipDataBase = IpDataBase();
    _ipData = _fetchIpData();
    _slideInAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    // Запустите анимацию при построении виджета
    _slideInAnimationController.forward();
  }

  @override
  void dispose() {
    _slideInAnimationController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _fetchIpData() async {
    final lastSuccessfulData = _ipDataBase.getLastSuccessfulData();
    if (lastSuccessfulData != null) {
      return Future.value(lastSuccessfulData);
    } else {
      try {
        final response =
            await http.get(Uri.parse('https://api.ipify.org?format=json'));
        if (response.statusCode == 200) {
          final ipData = json.decode(response.body);
          final ipAddress = ipData['ip'];
          final locationData = await _fetchLocationData(ipAddress);
          await _ipDataBase.updateDataBase(locationData);
          return locationData;
        } else {
          throw Exception('Failed to load IP data');
        }
      } catch (e) {
        throw Exception('Failed to load IP data: $e');
      }
    }
  }

  Future<Map<String, dynamic>> _fetchLocationData(String ipAddress) async {
    final response =
        await http.get(Uri.parse('https://geolocation-db.com/json/$ipAddress'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load location data');
    }
  }

  Future<void> _reloadIpData() async {
    try {
      final newData = await _fetchIpData();
      setState(() {
        _ipData = Future.value(newData);
      });
    } catch (e) {
      print('Error reloading IP data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appSecondaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightOrange,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: FutureBuilder<Map<String, dynamic>>(
              future: _ipData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomProgressDialog();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final locationData = snapshot.data!;
                  final ipAddress = locationData['IPv4'];
                  return Text(
                    'IP: $ipAddress',
                    style: TextStyle(
                        color: AppColors.appBlue.withOpacity(0.7),
                        fontSize: 32),
                  );
                }
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadIpData,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                FutureBuilder<Map<String, dynamic>>(
                  future: _ipData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CustomProgressDialog();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final locationData = snapshot.data!;
                      final latitude = locationData['latitude'];
                      final longitude = locationData['longitude'];
                      final country = locationData['country_name'];
                      final city = locationData['city'];
                      final countryCode = locationData['country_code'];
                      final coordinates = latlng.LatLng(
                          latitude as double, longitude as double);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInExpo,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.appBlue.withOpacity(0.4),
                                    spreadRadius: 5,
                                    blurRadius: 40,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInExpo,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: MapImageWidget(
                                            coordinates: coordinates),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Marquee(
                              text:
                                  '      Country: $country       City: $city        Country Code: $countryCode',
                              style: const TextStyle(
                                  fontSize: 30, color: AppColors.appBlue),
                              velocity: 40,
                              blankSpace: 20,
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.easeInOut,
                              decelerationDuration: const Duration(seconds: 1),
                              decelerationCurve: Curves.easeInOut,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
