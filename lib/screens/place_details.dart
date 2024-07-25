import 'package:favorite_places/.env';
import 'package:favorite_places/models/placeModel.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final PlaceModel place;

  String get locationImage {
    final lat = place.location.latitude;
    final long = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16.2&size=600x300&maptype=roadmap&markers=color:red%7Cicon:male%7Clabel:U%7C$lat,$long&key=$google_map_key';
//  return 'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=600&height=400&center=lonlat:$long,$lat&zoom=14.3497&marker=lonlat:$long,$lat;type:awesome;color:%23bb3f73;size:x-large;icon:male;icontype:awesome&apiKey=$geoapify_map_key';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.title,
          style: const TextStyle(color: Color.fromARGB(255, 214, 41, 118)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MapScreen(location: place.location,isSelecting: false,),),);
                      print('-----------------------------------selection api caleeed ------------------------');
                    },
                      child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      place.location.address,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
