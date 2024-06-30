import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PlacesScreen extends ConsumerStatefulWidget{
  const PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
    
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen>{  
   void _addNewPlace(BuildContext context) async {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddNewPlaces(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var opacityAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: opacityAnimation,
            child: child,
          );
        },
      ),
    );  
  }

  late Future<void> _placesFuture;

  @override
  void initState() {
    _placesFuture = ref.read(userPlacesProvider.notifier).loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          children: [
            const Icon(Icons.location_on_outlined,color: Color.fromARGB(255, 214, 41, 118),),
            Text("My Places",style:GoogleFonts.kalnia(fontSize: 24,color: const Color.fromARGB(255, 214, 41, 118)),),
          ],
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        // elevation: 5,
        actions:  [
          IconButton(icon: const Icon(CupertinoIcons.add), color:const Color.fromARGB(255, 214, 41, 118),iconSize: 25,onPressed: (){
            _addNewPlace(context);
          },),
          const SizedBox(width: 12),
        ],
      ),
      body: FutureBuilder(future: _placesFuture, builder: (context,snapshot)=> snapshot.connectionState == ConnectionState.waiting?const Center(child: CircularProgressIndicator.adaptive(),):  PlacesList(places: userPlaces,),)
    );
  }
}
