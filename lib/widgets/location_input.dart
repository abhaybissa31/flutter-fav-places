import 'dart:convert';

import 'package:favorite_places/models/placeModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
// /// Determine the current position of the device.
// ///
// /// When the location services are not enabled or permissions
// /// are denied the `Future` will return an error.
// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition();
// }



  String get locationImage{
    if (_pickedLocation==null) {
      print('_pickedlocation is nulllllllllllllll-----------------');
      return '_pickedlocation nulll';
    }
    final lat = _pickedLocation!.latitude;
    final long = _pickedLocation!.longitude;

 return 'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=600&height=400&center=lonlat:$long,$lat&zoom=14.3497&marker=lonlat:$long,$lat;type:awesome;color:%23bb3f73;size:x-large;icon:male;icontype:awesome&apiKey=bad591d2b1f944d3bc7da689c06ead6f';  
 }



  PlaceLocation? _pickedLocation;
  bool _isGettingLoaded = false;

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
    setState(() {
      _isGettingLoaded = true;
    });

    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude==null || longitude==null) {
      print('lat or long is null----------------------------');
      return;
    }

    final url = Uri.parse(
        'https://api.geoapify.com/v1/geocode/reverse?lat=$latitude&lon=$longitude&apiKey=b6fb61c4436e4337b4a7231de3c27349');
    final res = await http.get(url);
    final resData = json.decode(res.body);

    String? address;
    if (resData['features'].isNotEmpty) {
      String address = resData['features'][0]['properties']['formatted'];
      print(address);
    } else {
      print('error in getting formated location');
    }

   

    setState(() {
      _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude, address: address ?? 'Unknown address');
      _isGettingLoaded = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    Widget previewContent = Text(
      "No location chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(locationImage,fit: BoxFit.cover,height: double.infinity,width: double.infinity,);
    }
    // if (_isGettingLoaded) {
    //     previewContent = const CircularProgressIndicator.adaptive();
    // }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text("Get current location"),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text("Select on Map"),
              icon: const Icon(Icons.map_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
