import 'dart:math';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart' as latlng;

class MapImageWidget extends StatelessWidget {
  final latlng.LatLng? coordinates;
  late final MapController controller;

  MapImageWidget({Key? key, this.coordinates}) {
    const double desiredDistance = 50;
    final double pixelsPerMeter = 156543.03392 * cos(coordinates!.latitude * pi / 180) / pow(2, 18);
    final double zoom = log(156543.03392 * cos(coordinates!.latitude * pi / 180) / (desiredDistance * pixelsPerMeter)) / ln2;

    controller = MapController(location: coordinates!, zoom: zoom);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: MapLayout(
        controller: controller,
        builder: (context, transformer) {
          return TileLayer(
            builder: (context, x, y, z) {
              final tilesInZoom = pow(2.0, z).floor();

              while (x < 0) {
                x += tilesInZoom;
              }
              while (y < 0) {
                y += tilesInZoom;
              }

              x = x.toInt(); 
              y = y.toInt(); 

              x %= tilesInZoom;
              y %= tilesInZoom;

              final url = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/256/$z/$x/$y?access_token=pk.eyJ1IjoiaXRvbGV4YW5kcmEiLCJhIjoiY2x3MnNjZmo2MHB2cjJpbXVrOWRxazE2ZiJ9.eYy-4IBj22DQFcFbxfMMzQ';

              return Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              );
            },
          );
        },
      ),
    );
  }
}