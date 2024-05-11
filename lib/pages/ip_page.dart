import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timer_flutter/components/loading_dialog.dart';

class IpInfoWiget extends StatefulWidget {
  const IpInfoWiget({Key? key}) : super(key: key);

  @override
  _IpInfoWigetState createState() => _IpInfoWigetState();
}

class _IpInfoWigetState extends State<IpInfoWiget> {
  late Future<Map<String, dynamic>> _ipData;

  @override
  void initState() {
    super.initState();
    _ipData = _fetchIpData();
  }

  Future<Map<String, dynamic>> _fetchIpData() async {
    final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final ipData = json.decode(response.body);
      final ipAddress = ipData['ip'];
      return _fetchLocationData(ipAddress);
    } else {
      throw Exception('Failed to load IP data');
    }
  }

  Future<Map<String, dynamic>> _fetchLocationData(String ipAddress) async {
    final response = await http.get(Uri.parse('https://geolocation-db.com/json/$ipAddress'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load location data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Info'),
      ),
      body: Center(
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
              final locationInfo = 'Latitude: $latitude\nLongitude: $longitude\n';
              return SingleChildScrollView(
                child: Text(locationInfo),
              );
            }
          },
        ),
      ),
    );
  }
}
