import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

class PostcardMap extends StatefulWidget {
  LatLng location;
  double hue;
  PostcardMap(GeoPoint geopoint, double hue){
    location = LatLng(geopoint.latitude, geopoint.longitude);
    this.hue = hue;
  }
  @override
  State<PostcardMap> createState() => PostcardMapState();
}

class PostcardMapState extends State<PostcardMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    //TODO Place Marker
    BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(widget.hue);
    return GoogleMap(
        markers: {Marker(markerId: MarkerId("uh"), icon: markerIcon, position:widget.location )},
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: widget.location,
            zoom: 18),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
  }

}