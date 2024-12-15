import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  double? latt, longg;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    setState(() {
      latt = locationData.latitude;
      longg = locationData.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          'Lattitude',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(latt == null ? 'XX' : latt.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
      ]),
      SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text('Longitude',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        Text(longg == null ? 'XX' : longg.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
      ]),
      SizedBox(height: 10),
      TextButton.icon(
        onPressed: _getCurrentLocation,
        label: Text('Set current location'),
        icon: Icon(Icons.location_on),
      )
    ]);
  }
}
