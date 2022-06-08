import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';

class ListData extends StatefulWidget {
 

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  

  final MapController _mapController = Get.find<MapController>();

  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.prefsmethod();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Of LatLng')),
      body: Obx(() {
        return _mapController.data.isEmpty
            ? const Center(
                child: Text('No Data'),
              )
            : ListView.builder(
                itemCount: _mapController.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    title: Text('long ${_mapController.data[i].longitude}'),
                    subtitle: Text('lat ${_mapController.data[i].latitude}'),
                  );
                });
      }),
    );
  }
}
