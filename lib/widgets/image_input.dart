import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function (File) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _chooseImagePickerSource() {
    // ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        duration: const Duration(seconds: 120),
        content: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Choose a picker:',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  splashFactory: InkSparkle.splashFactory,
                  onTap: () => _takePicture(true),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // InkWell(
                      // onTap:() => _takePicture(true) ,
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.camera,
                            color: Colors.white,
                            // onPressed: ,
                          ),
                          Text(
                            'Click a picture',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      // )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
                InkWell(
                  splashFactory: InkSparkle.splashFactory,
                  enableFeedback: true,
                  onTap: () => _takePicture(false) ,
                  child:const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                             CupertinoIcons.photo_on_rectangle,
                            // onPressed:,
                            color: Colors.white,
                          ),
                          const Text(
                            'Choose from Gallery',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  _takePicture(bool isCameraSelected) async {
    final imagePicker = ImagePicker();
    if (isCameraSelected) {
      final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 600,
      );
      ScaffoldMessenger.of(context).clearSnackBars();
      if (pickedImage == null) {
        return;
      }

      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      widget.onPickImage(_selectedImage!);

    } else {
      final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 600,
      );
      ScaffoldMessenger.of(context).clearSnackBars();
      if (pickedImage == null) {
        return;
      }

      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      
      widget.onPickImage(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _chooseImagePickerSource,
      label: const Text("Take a Picture"),
      icon: const Icon(Icons.camera),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _chooseImagePickerSource,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
