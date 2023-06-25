import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/image/presentation/upload/bloc/upload_image_bloc.dart';
import 'package:image_hoster/features/image/presentation/upload/widget/upload_image_widget.dart';

class UploadImageScreen extends StatelessWidget {
  final int folderId;

  const UploadImageScreen({Key? key, required this.folderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadImageBloc(folderId),
      child: UploadImageWidget(folderId: folderId),
    );
  }
}
