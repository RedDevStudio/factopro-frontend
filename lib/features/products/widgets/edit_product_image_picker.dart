import 'dart:io';

import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

/// "تصویر کالا" block: square product image on the start (right) side, title,
/// format hint and change/remove actions beside it. The picked file is kept
/// locally for preview only. Expects an RTL [Directionality] ancestor.
class EditProductImagePicker extends StatefulWidget {
  const EditProductImagePicker({
    super.key,
    required this.placeholderIcon,
    this.onImageChanged,
  });

  /// Shown while no image has been picked (the product has no real image
  /// asset yet).
  final IconData placeholderIcon;
  final ValueChanged<File?>? onImageChanged;

  @override
  State<EditProductImagePicker> createState() => _EditProductImagePickerState();
}

class _EditProductImagePickerState extends State<EditProductImagePicker> {
  File? _pickedImageFile;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;

    setState(() => _pickedImageFile = File(pickedImage.path));
    widget.onImageChanged?.call(_pickedImageFile);
  }

  void _removeImage() {
    setState(() => _pickedImageFile = null);
    widget.onImageChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 88,
          height: 88,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outline),
          ),
          child: _pickedImageFile != null
              ? Image.file(_pickedImageFile!, fit: BoxFit.cover)
              : Icon(
                  widget.placeholderIcon,
                  size: 36,
                  color: colorScheme.onSurfaceVariant,
                ),
        ),
        const Gap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تصویر کالا',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const Gap(4),
              Text(
                'فرمت‌های JPG یا PNG، حداکثر ۴ مگابایت',
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(12),
              Row(
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const Gap(6),
                            Flexible(
                              child: Text(
                                'تغییر تصویر',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(4),
                  IconButton(
                    onPressed: _removeImage,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: colorScheme.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
