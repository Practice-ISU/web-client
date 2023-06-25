import 'package:flutter/material.dart';
import 'package:image_hoster/features/image/data/model/image_item.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/kit/gap.dart';
import 'package:image_hoster/ui/kit/icons.dart';

class ImageListItem extends StatelessWidget {
  final ImageItem imageItem;
  final ValueChanged<ImageItem>? onPressed;
  final ValueChanged<ImageItem>? onLongPress;

  const ImageListItem({
    Key? key,
    required this.imageItem,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.sm),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.sm),
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.surface)),
        child: Stack(
          children: [
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  imageItem.original,
                  errorBuilder: (context, child, progress) => Padding(
                    padding: const EdgeInsets.all(Dimens.md),
                    child: AppIcons.error,
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) {
                      return child;
                    }
                    final progressRatio = progress.expectedTotalBytes != null
                        ? (progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!)
                        : null;

                    final progressPercent = progressRatio != null
                        ? (progressRatio * 100).floor()
                        : null;

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
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(Dimens.sm),
                  onTap: () {
                    onPressed?.call(imageItem);
                  },
                  onLongPress: () {
                    onLongPress?.call(imageItem);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
