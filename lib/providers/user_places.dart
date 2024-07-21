import 'dart:io';

import 'package:favorite_places/models/placeModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title,File image) {
    final newPlace = PlaceModel(title: title, image: image);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<PlaceModel>>(
        (ref) => UserPlacesNotifier());
