import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/image/presentation/list/bloc/images_bloc.dart';
import 'package:image_hoster/features/image/presentation/list/widget/images_widget.dart';

class ImagesScreen extends StatelessWidget {
  final int folderId;

  const ImagesScreen({Key? key, required this.folderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagesBloc(folderId)..add(LoadImagesEvent()),
      child: const ImagesWidget(),
    );
  }
}
