import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timer_flutter/components/card_img.dart';
import 'package:timer_flutter/components/loading_dialog.dart';
import 'package:timer_flutter/data/database.dart';
import 'package:timer_flutter/src/app_styles.dart';
import 'package:latlng/latlng.dart' as latlng;

class IpInfoWiget extends StatefulWidget {
  const IpInfoWiget({Key? key}) : super(key: key);

  @override
  _IpInfoWigetState createState() => _IpInfoWigetState();
}

class _IpInfoWigetState extends State<IpInfoWiget> {
  late Future<Map<String, dynamic>> _ipData;
  late IpDataBase _ipDataBase;

  @override
  void initState() {
    super.initState();
    _ipDataBase = IpDataBase();
    _ipData = _fetchIpData();
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
    final response = await http.get(
        Uri.parse('https://geolocation-db.com/json/$ipAddress'));
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
      appBar: AppBar(
        backgroundColor: AppColors.appSecondaryBackground,
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
                    'IP Address: $ipAddress',
                    style:
                        TextStyle(color: AppColors.appBlue.withOpacity(0.7)),
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
        children: [
          
          Expanded(
            child: Center(
              child: FutureBuilder<Map<String, dynamic>>(
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
                    final locationInfo =
                        'Latitude: $latitude\nLongitude: $longitude\n';
                    final coordinates =
                      latlng.LatLng(latitude as double, longitude as double);
                  return MapImageWidget(coordinates: coordinates);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
