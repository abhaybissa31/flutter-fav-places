import 'package:favorite_places/models/placeModel.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  CardData({super.key, required this.place});
  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => PlaceDetailsScreen(place: place)));
      },
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: [
              Positioned(
                child: Image.file(
                  place.image,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 250.0,
                top: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 3,),
                      Expanded(
                        child: Text(
                          place.title,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
