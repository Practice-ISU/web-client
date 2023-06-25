import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_hoster/features/image/presentation/upload/widget/components/file_view.dart';

class UploadImagePage extends StatelessWidget {
  final ValueChanged<Uint8List> onUploaded;
  final Uint8List? image;

  const UploadImagePage({Key? key, required this.onUploaded, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = image == null
        ? createFileView((file) {
            onUploaded.call(file);
          })
        : Image.memory(
            image!,
            fit: BoxFit.scaleDown,
            );

    return Center(child: child);
  }
}
