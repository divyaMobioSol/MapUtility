import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/controller.dart';
import 'list_of_latLang.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
//controllers
  final Completer<GoogleMapController> _controller = Completer();
  final MapController _mapController = Get.put(MapController());

  SharedPreferences? prefs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.setMarker(initial);
      super.initState();
    });
  }



//initial camera position
  static LatLng initial = const LatLng(37.42796133580664, -122.085749655962);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: initial,
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Map'),
        actions: [
          InkWell(
            onTap: () {
              _mapController.save();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListData()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.directions_boat),
            ),
          ),
        ],
      ),
      body: GetBuilder<MapController>(
        builder: (_) => GoogleMap(
          markers: _mapController.markers,
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          // polygons: _polygons,
          onTap: (point) {
            _mapController.latlng.add(point);

            _mapController.setMarker(point);
            print('ponts -------- ${point.latitude}');
          },
        ),
      ),
    );
  }
}
