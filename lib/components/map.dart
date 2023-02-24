import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class OSMMap extends StatelessWidget {
  final double lat;
  final double lon;
  const OSMMap({super.key, required this.lat, required this.lon});

  @override
  Widget build(BuildContext context) {
    MapController controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: lat,
        longitude: lon,
      ),
    );

    return OSMFlutter(
      controller: controller,
      trackMyPosition: false,
      initZoom: 10,
      stepZoom: 1.0,
      userLocationMarker: UserLocationMaker(
        personMarker: const MarkerIcon(
          icon: Icon(
            Icons.location_history_rounded,
            color: Colors.red,
            size: 48,
          ),
        ),
        directionArrowMarker: const MarkerIcon(
          icon: Icon(
            Icons.double_arrow,
            size: 48,
          ),
        ),
      ),
      roadConfiguration: RoadConfiguration(
        startIcon: const MarkerIcon(
          icon: Icon(
            Icons.person,
            size: 64,
            color: Colors.brown,
          ),
        ),
        roadColor: Colors.yellowAccent,
      ),
      markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
        icon: Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 56,
        ),
      )),
    );
    ;
  }
}
