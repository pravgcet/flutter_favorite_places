import 'package:flutter/material.dart';
import 'package:flutter_favorite_places/modals/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceDetailScreen({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
