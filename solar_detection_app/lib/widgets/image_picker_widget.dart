// lib/widgets/image_picker_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? image;
  final Function(ImageSource) onPick;

  const ImagePickerWidget({
    super.key,
    required this.image,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Preview
        GestureDetector(
          onTap: () => onPick(ImageSource.gallery),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: image == null
                ? Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 50),
                  )
                : Image.file(
                    image!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onPick(ImageSource.camera),
                icon: const Icon(Icons.camera),
                label: const Text("Camera"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => onPick(ImageSource.gallery),
                icon: const Icon(Icons.photo),
                label: const Text("Gallery"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
