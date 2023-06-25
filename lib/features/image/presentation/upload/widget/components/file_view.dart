import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'file_view_mobile.dart' if (dart.library.html) 'file_view_web.dart' as file;

createFileView(ValueChanged<Uint8List> onUploaded) => file.createFileViewPlatform(onUploaded);