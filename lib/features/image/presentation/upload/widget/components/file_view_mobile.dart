import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_hoster/generated/l10n.dart';

class _FileView extends StatelessWidget {
  final ValueChanged<Uint8List> onUploaded;

  const _FileView({Key? key, required this.onUploaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          final files = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );
          if (files?.files.first.bytes != null) {
            onUploaded.call(files!.files.first.bytes!);
          }
        },
        child: Text(S.current.upload));
  }
}

createFileViewPlatform(ValueChanged<Uint8List> onUploaded) => _FileView(onUploaded: onUploaded);