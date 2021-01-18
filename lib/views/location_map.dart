import '../models/country.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  final Country country;
  LocationMap(this.country);
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {

  GoogleMapController mapController;
  LatLng center;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    center = LatLng(widget.country.latlng[0], widget.country.latlng[1]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Map"),
      ),
      body: SizedBox.expand(
        child: GoogleMap(
          markers: Set<Marker>.of(markers.values),
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: 8,
          ),
          onMapCreated: (controller) async {
            mapController = controller;
            MarkerId id = MarkerId('marker');
            Marker marker = Marker(
              markerId: id,
              position: center,
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(title: widget.country.name),
            );
            setState(() {
              markers[id] = marker;
            });
            Future.delayed(Duration(seconds: 2)).then((value) => mapController.showMarkerInfoWindow(id));
          },
        ),
      ),
    );
  }
}
