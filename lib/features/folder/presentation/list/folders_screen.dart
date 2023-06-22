import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/folder/presentation/list/bloc/folders_bloc.dart';
import 'package:image_hoster/features/folder/presentation/list/widget/folders_widget.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoldersBloc()..add(LoadFoldersEvent()),
      child: const FoldersWidget(),
    );
  }
}
