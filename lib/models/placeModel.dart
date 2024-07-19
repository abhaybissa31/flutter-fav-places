import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel{
  PlaceModel({required this.title}):id = uuid.v4();
  final String title;
  final String id;
}