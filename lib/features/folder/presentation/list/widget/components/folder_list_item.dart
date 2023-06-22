import 'package:flutter/material.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';
import 'package:image_hoster/ui/kit/icons.dart';
import 'package:image_hoster/ui/theme/app_text_theme.dart';

class FolderListItem extends StatelessWidget {
  final Folder folder;
  final ValueChanged<Folder>? onPressed;

  const FolderListItem({
    Key? key,
    required this.folder,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed?.call(folder);
      },
      borderRadius: BorderRadius.circular(Dimens.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcons.folder,
          Gap.sm,
          Expanded(
            child: Text(
              folder.name,
              style: Theme.of(context).textTheme.h2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
