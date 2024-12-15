import 'package:flutter/material.dart';
import 'package:flutter_favorite_places/providers/user_places.dart';
import 'package:flutter_favorite_places/screens/add_place.dart';
import 'package:flutter_favorite_places/widgets/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceScreen extends ConsumerStatefulWidget {
  PlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlaceScreen();
  }
}

class _PlaceScreen extends ConsumerState<PlaceScreen> {
  late Future<void> _placeFuture;

  @override
  void initState() {
    super.initState();
    _placeFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (cts) => AddPlaceScreen()),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: _placeFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : PlacesList(places: userPlaces),
        ),
      ),
    );
  }
}
