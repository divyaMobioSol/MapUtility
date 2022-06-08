import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapController extends GetxController {
  Set<Marker> markers = <Marker>{};

  RxList<LatLng> data = <LatLng>[].obs;

  
//variables
  Set<Polygon> _polygons = Set<Polygon>();
  int polygonIdCounter = 1;
  int markerIdCounter = 1;

  SharedPreferences? prefs;
  List<LatLng> latlng = <LatLng>[];

  void setMarker(LatLng point) {
    markers.add(Marker(
        markerId: MarkerId('marker'),
        infoWindow: InfoWindow(title: point.toString()),
        position: point));
    update();
  }

  //save method
  save() async {
    prefs = await SharedPreferences.getInstance();
    String data = json.encode(latlng);
    prefs!.setString('positions_list', data);
  }

//set polygon function
  void setPolygon(LatLng point) {
    final String polygonIdVal = "polygon_$polygonIdCounter";
    polygonIdCounter++;
    _polygons.add(Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: latlng,
        strokeColor: Colors.transparent,
        strokeWidth: 2));
  }

  Future<void> prefsmethod() async {
    final prefs = await SharedPreferences.getInstance();

    String? value = prefs.getString('positions_list');
    if (value != null) {
      var ls = json.decode(value);
      print('ls-------$ls');
      for (var i in ls) {
        data.add(LatLng(i[0], i[1]));
      }
    }
    update();
  }
}
