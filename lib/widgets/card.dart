import 'package:favorite_places/models/placeModel.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  const CardData({super.key, required this.place});
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
                right: 0.0,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Row(
                                // children: [
                                // Row(
                                // children: [
                                Text(
                                  place.title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                // ],
                                // ),
                                // ],
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    place.location.address,
                                    style: TextStyle(color: Colors.white,fontSize: 12),
                                  ),
                                ),
                              ],
                            )
                          ],
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
