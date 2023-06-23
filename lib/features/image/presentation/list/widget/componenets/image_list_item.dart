import 'package:flutter/material.dart';
import 'package:image_hoster/features/image/data/model/image_item.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';

class ImageListItem extends StatelessWidget {
  final ImageItem imageItem;
  final ValueChanged<ImageItem>? onPressed;

  const ImageListItem({
    Key? key,
    required this.imageItem,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.sm),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.surface
        )
      ),
      child: InkWell(
        onTap: () {
          onPressed?.call(imageItem);
        },
        borderRadius: BorderRadius.circular(Dimens.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageItem.filename,
              fit: BoxFit.contain,
              errorBuilder: (context, child, progress) => Center(
                child: Text(S.current.imageLoadError),
              ),
              loadingBuilder: (context, child, progress) {
                final progressRatio =
                    progress != null && progress.expectedTotalBytes != null
                        ? (progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!)
                        : null;

                final progressPercent =
                    progressRatio != null ? (progressRatio * 100).floor() : null;

                return Center(
                    child: Column(children: [
                  const CircularProgressIndicator(),
                  if (progressPercent != null) ...[
                    Gap.sm,
                    Text('$progressPercent%')
                  ]
                ]));
              },
            ),
          ],
        ),
      ),
    );
  }
}
