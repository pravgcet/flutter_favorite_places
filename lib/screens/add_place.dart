import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_favorite_places/providers/user_places.dart';
import 'package:flutter_favorite_places/widgets/image_input.dart';
import 'package:flutter_favorite_places/widgets/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty) {
      return;
    }
    ref
        .read(userPlaceProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            SizedBox(height: 16),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            SizedBox(height: 16),
            LocationInput(),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }
}
