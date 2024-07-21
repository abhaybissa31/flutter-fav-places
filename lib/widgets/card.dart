import 'package:favorite_places/models/placeModel.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class CardData extends StatelessWidget{
  CardData({super.key, required this.place});
  final PlaceModel place;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      enableFeedback: true,
      onTap: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> PlaceDetailsScreen(place: place)));
      },
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.white54,
      borderRadius: BorderRadius.circular(15.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "lib/assets/images/maps.png",
                color: Colors.white,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        place.title,
                        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}