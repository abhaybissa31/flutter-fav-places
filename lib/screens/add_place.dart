import 'dart:io';

import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewPlaces extends ConsumerStatefulWidget {
  const AddNewPlaces({super.key});
  @override
  ConsumerState<AddNewPlaces> createState() => _AddNewPlacesState();
}

class _AddNewPlacesState extends ConsumerState<AddNewPlaces> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savedPlaces(){
    final _enteredText = _titleController.text;

    if (_enteredText.isEmpty || _selectedImage == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(_enteredText,_selectedImage!);

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
        title: const Text('Add a new place',style: TextStyle(color: Color.fromARGB(255, 214, 41, 118)),),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
               controller: _titleController,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  alignLabelWithHint: true,
           
                  hintText: 'Add name of the place',
                  hintTextDirection: TextDirection.rtl,

                  // enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                  // focusedBorder: InputBorder.none
                  // border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20),
            ),
            const SizedBox(
              height: 16,
            ),
             ImageInput(onPickImage: (image) {
              _selectedImage = image;
            },),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _savedPlaces,
              label: const Text("Add a place"),
              icon: const Icon(CupertinoIcons.add),
            )
          ],
        ),
      ),
    );
  }
}
