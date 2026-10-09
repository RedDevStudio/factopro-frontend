import 'dart:io';

import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LogoPicker extends StatefulWidget {
  const LogoPicker({
    super.key,
    required this.onPickImage,
    required this.source,
    required this.boxRadius,
  });

  final void Function(File pickedImage) onPickImage;
  final ImageSource source;
  final double boxRadius;

  @override
  State<LogoPicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<LogoPicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: widget.source,
      imageQuality: 100,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ring so the circle stands out from the outlineVariant scaffold.
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colorScheme.surface, width: 4),
            ),
            child: CircleAvatar(
              radius: widget.boxRadius,
              backgroundColor: context.colorScheme.outline,
              foregroundImage: _pickedImageFile != null
                  ? FileImage(_pickedImageFile!)
                  : null,
              child: _pickedImageFile == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 32,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'لوگو',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.surface,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 16,
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
