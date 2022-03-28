import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final String source;
  final String target;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    @required this.source,
    @required this.target,
    @required this.totalDistance,
    @required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    if ((map['routes'] as List).isEmpty) return null;

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // Distance & Duration
    String distance = '';
    String duration = '';
    String  end_address="";
    String start_address="";
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
      end_address=leg["end_address"];
      start_address=leg["start_address"];
    }

    return Directions(
      source: start_address,
      target:end_address,
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}