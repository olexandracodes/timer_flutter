import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timer_flutter/components/loading_dialog.dart';

class IpInfoWiget extends StatefulWidget {
  const IpInfoWiget({Key? key}) : super(key: key);

  @override
  _IpInfoWigetState createState() => _IpInfoWigetState();
}

class _IpInfoWigetState extends State<IpInfoWiget> {
  late Future<String> _ipData;

  @override
  void initState() {
    super.initState();
    _ipData = _fetchIpData();
  }

  Future<String> _fetchIpData() async {
    String ip = await _getIpAddress();
    final response = await http.get(Uri.parse('https://ip-api.com/json/$ip'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load IP data');
    }
  }

  Future<String> _getIpAddress() async {
    String ipAddress = '';
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.address != '127.0.0.1' && addr.type.name == 'ipv4') {
            ipAddress = addr.address;
          }
        }
      }
    } catch (_) {
      ipAddress = '127.0.0.1';
    }
    return ipAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Info'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _ipData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomProgressDialog();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SingleChildScrollView(
                child: Text(snapshot.data ?? ''),
              );
            }
          },
        ),
      ),
    );
  }
}
