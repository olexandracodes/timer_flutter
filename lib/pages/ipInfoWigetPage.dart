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
    final response = await http.get(Uri.parse('https://ip-api.com/json'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load IP data');
    }
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
