import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/folder/presentation/list/bloc/folders_bloc.dart';
import 'package:image_hoster/features/folder/presentation/list/widget/components/folder_list_item.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/components/screen.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/icons.dart';
import 'package:image_hoster/ui/util/snackbar_util.dart';

class FoldersWidget extends StatefulWidget {
  const FoldersWidget({Key? key}) : super(key: key);

  @override
  State<FoldersWidget> createState() => _FoldersWidgetState();
}

class _FoldersWidgetState extends State<FoldersWidget> {
  bool inProgress = true;
  final List<Folder> folders = [];

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<FoldersBloc, FoldersState>(
      padding: EdgeInsets.zero,
      listener: (context, state) {
        if (state is ProgressFoldersState) {
          setState(() {
            inProgress = state.progress;
          });
        }
        if (state is ErrorFoldersState) {
          context.showSnackBar(state.message);
        }
        if (state is LoadedFoldersState) {
          setState(() {
            folders.clear();
            folders.addAll(state.folders);
          });
        }
      },
      appBar: AppBar(
        title: Text(S.current.folders),
        actions: [
          IconButton(
            onPressed: () {
              _onNewFolderPressed();
            },
            icon: AppIcons.plusCircle,
          ),
          IconButton(
            icon: AppIcons.logout,
            onPressed: () {
              _onLogoutPressed();
            },
          )
        ],
      ),
      builder: (context, state) {
        final int count =
        (MediaQuery
            .of(context)
            .size
            .width / (200 + Dimens.md)).floor();
        return GridView.count(
          padding: const EdgeInsets.all(Dimens.md),
          mainAxisSpacing: Dimens.md,
          crossAxisSpacing: Dimens.md,
          crossAxisCount: count,
          children: folders
              .map(
                (e) =>
                FolderListItem(
                  folder: e,
                  onPressed: (folder) {
                    _onFolderPressed(folder);
                  },
                ),
          )
              .toList(),
        );
      },
      showProgress: (state) => inProgress,
    );
  }

  _onLogoutPressed() {
    BlocProvider.of<FoldersBloc>(context).add(LogoutFoldersEvent());
  }

  _onFolderPressed(Folder folder) {
    context.navigation.images(folder.id);
  }

  _onNewFolderPressed() {}
}
