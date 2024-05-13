import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:timer_flutter/pages/settings_page.dart';

Future<List<ImageObject>> fetchUnsplashImageObjects() async {
  final response = await http.get(
    Uri.parse('https://api.unsplash.com/photos/random?count=10'),
    headers: {
      'Authorization':
          'Client-ID 7ky9J2cY--dRMPurSiUdObDT8IosKUyrCFvhnDW5DQY'
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    return data.map((item) {
      return ImageObject(
        imageId: item['id'],
        image: item['urls']['regular'] ?? '',
        longName: item['alt_description'] ?? '',
        likes: item['likes'] ?? 0,
        altDescription: item['alt_description'] ?? '',
        user: User(
          username: item['user']['username'] ?? '',
          name: item['user']['name'] ?? '',
          bio: item['user']['bio'] ?? '',
          instagramUsername: item['user']['instagram_username'] ?? '',
          location: item['user']['location'] ?? '',
        ),
      );
    }).toList();
  } else {
    throw Exception('Failed to load Unsplash ImageObjects');
  }
}
