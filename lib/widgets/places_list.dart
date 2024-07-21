import 'package:favorite_places/models/placeModel.dart';
import 'package:favorite_places/widgets/card.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet.',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Adjust columns as needed
        childAspectRatio: 2.0,
      ),
      
      itemBuilder: (ctx, index) => CardData(
        place: places[index],
      ),
      itemCount: places.length,
    );

    // ListView.builder(
    //   itemCount: places.length,
    //   itemBuilder: (ctx, index) => ListTile(
    //     title: Text(
    //       places[index].title,
    //       style: Theme.of(context)
    //           .textTheme
    //           .titleMedium!
    //           .copyWith(color: Colors.white),
    //     ),
    //     onTap: (){
    //       Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> PlaceDetailsScreen(place: places[index])));
    //     },
    //   ),
    // );
  }
}
