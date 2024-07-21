import 'package:favorite_places/providers/user_places.dart';
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

  void _savedPlaces(){
    final _enteredText = _titleController.text;

    if (_enteredText.isEmpty) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(_enteredText);

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
        title: const Text('Add a new place'),
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

                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: InputBorder.none
                  // border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20),
            ),
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
