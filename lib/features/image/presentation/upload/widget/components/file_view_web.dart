import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/kit/dimens.dart';

class _FileView extends StatefulWidget {
  final ValueChanged<Uint8List> onUploaded;

  const _FileView({Key? key, required this.onUploaded}) : super(key: key);

  @override
  State<_FileView> createState() => _FileViewState();
}

class _FileViewState extends State<_FileView> {
  DropzoneViewController? dropzoneController;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimens.sm),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: DropzoneView(
                onCreated: (controller) {
                  dropzoneController = controller;
                },
                onDrop: (file) async {
                  final bytes = await dropzoneController?.getFileData(file);
                  if (bytes != null) {
                    widget.onUploaded.call(bytes);
                  }
                },
              ),
            ),
            TextButton(
                onPressed: () async {
                  final files = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (files?.files.first.bytes != null) {
                    widget.onUploaded.call(files!.files.first.bytes!);
                  }
                },
                child: Text(S.current.upload))
          ],
        ),
      ),
    );
  }
}

createFileViewPlatform(ValueChanged<Uint8List> onUploaded) =>
    _FileView(onUploaded: onUploaded);
