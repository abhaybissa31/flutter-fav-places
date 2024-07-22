import 'package:favorite_places/models/placeModel.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(place.title, style: const TextStyle(color:  Color.fromARGB(255, 214, 41, 118)),),
        automaticallyImplyLeading: false,
      ),
      body: Stack(children: [
        Image.file(place.image, fit: BoxFit.cover, width: double.infinity,height: double.infinity,)
      ],),
    );
  }
}
