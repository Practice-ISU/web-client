import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/folder/presentation/list/bloc/folders_bloc.dart';
import 'package:image_hoster/features/folder/presentation/list/widget/components/folder_list_item.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/components/app_dialog.dart';
import 'package:image_hoster/ui/components/app_text_dialog.dart';
import 'package:image_hoster/ui/components/screen.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';
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
              _onNewFolderPressed(context);
            },
            icon: AppIcons.plusCircle,
            splashRadius: Dimens.appBarSplashRadius,
          ),
          Gap.md,
          IconButton(
            icon: AppIcons.logout,
            onPressed: () {
              _onLogoutPressed();
            },
            splashRadius: Dimens.appBarSplashRadius,
          ),
          Gap.md,
        ],
      ),
      builder: (context, state) {
        final int count =
            (MediaQuery.of(context).size.width / (200 + Dimens.md)).floor();
        return GridView.count(
          padding: const EdgeInsets.all(Dimens.md),
          mainAxisSpacing: Dimens.md,
          crossAxisSpacing: Dimens.md,
          crossAxisCount: count,
          children: folders
              .map(
                (e) => FolderListItem(
                  folder: e,
                  onPressed: (folder) {
                    _onFolderPressed(folder);
                  },
                  onLongPress: (folder) {
                    _onFolderDelete(context, folder);
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

  _onNewFolderPressed(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Wrap(
          children: [
            AppTextDialog(
              positiveText: S.current.yes,
              negativeText: S.current.no,
              title: S.current.addFolder,
              onPositivePressed: (text) {
                BlocProvider.of<FoldersBloc>(parentContext)
                    .add(AddFolderEvent(text));
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  _onFolderDelete(BuildContext parentContext, Folder folder) {
    showDialog(
      context: parentContext,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Wrap(
          children: [
            AppDialog(
              positiveText: S.current.yes,
              negativeText: S.current.no,
              title: S.current.deleteFolder,
              onPositivePressed: () {
                BlocProvider.of<FoldersBloc>(parentContext).add(
                  DeleteFolderEvent(folder),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
