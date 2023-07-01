import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/image/data/model/image_item.dart';
import 'package:image_hoster/features/image/presentation/list/bloc/images_bloc.dart';
import 'package:image_hoster/features/image/presentation/list/widget/componenets/image_list_item.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/components/app_dialog.dart';
import 'package:image_hoster/ui/components/screen.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';
import 'package:image_hoster/ui/kit/icons.dart';
import 'package:image_hoster/ui/util/snackbar_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagesWidget extends StatefulWidget {
  const ImagesWidget({Key? key}) : super(key: key);

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  Folder? folder;
  final List<ImageItem> images = [];
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<ImagesBloc, ImagesState>(
      listener: (context, state) {
        if (state is DownloadImagesState) {
          launchUrl(Uri.parse(state.url));
        }
        if (state is LoadedImagesState) {
          setState(() {
            folder = state.images.folder;
            images.clear();
            images.addAll(state.images.images);
          });
        }
        if (state is ErrorImagesState) {
          context.showSnackBar(state.message);
        }
        if (state is ProgressImagesState) {
          setState(() {
            progress = state.progress;
          });
        }
      },
      appBar: folder != null
          ? AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: Dimens.md),
                child: IconButton(
                  icon: AppIcons.arrowBack,
                  onPressed: () {
                    context.navigation.folders();
                  },
                  splashRadius: Dimens.appBarSplashRadius,
                ),
              ),
              title: Text(folder!.name),
              actions: [
                IconButton(
                  onPressed: () {
                    _onDownloadPressed();
                  },
                  splashRadius: Dimens.appBarSplashRadius,
                  icon: AppIcons.zip,
                ),
                Gap.md,
                IconButton(
                  onPressed: () {
                    _onNewImagePressed();
                  },
                  splashRadius: Dimens.appBarSplashRadius,
                  icon: AppIcons.plusCircle,
                ),
                Gap.md,
                IconButton(
                  icon: AppIcons.logout,
                  splashRadius: Dimens.appBarSplashRadius,
                  onPressed: () {
                    _onLogoutPressed();
                  },
                ),
                Gap.md,
              ],
            )
          : null,
      builder: (context, state) {
        final int count = (MediaQuery.of(context).size.width / (200 + Dimens.md)).floor();
        return GridView.count(
          padding: const EdgeInsets.all(Dimens.md),
          mainAxisSpacing: Dimens.md,
          crossAxisSpacing: Dimens.md,
          crossAxisCount: count,
          children: images
              .map(
                (e) => ImageListItem(
                  imageItem: e,
                  onPressed: (image) {
                    _onImagePressed(image);
                  },
                  onLongPress: (image) {
                    _onImageDelete(context, image);
                  },
                ),
              )
              .toList(),
        );
      },
      showProgress: (state) => progress,
    );
  }

  _onImagePressed(ImageItem imageItem) {
    launchUrl(Uri.parse(imageItem.fileName));
  }

  _onLogoutPressed() {
    BlocProvider.of<ImagesBloc>(context).add(LogoutImagesEvent());
  }

  _onNewImagePressed() {
    final folderId = folder?.id;
    if (folderId == null) return;
    context.navigation.uploadImage(folderId);
  }

  _onDownloadPressed() {
    BlocProvider.of<ImagesBloc>(context).add(DownloadEvent());
  }

  _onImageDelete(BuildContext parentContext, ImageItem image) {
    showDialog(
      context: parentContext,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Wrap(
          children: [
            AppDialog(
              positiveText: S.current.yes,
              negativeText: S.current.no,
              title: S.current.deleteImage,
              onPositivePressed: () {
                BlocProvider.of<ImagesBloc>(parentContext).add(
                  DeleteImageEvent(image.id),
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
