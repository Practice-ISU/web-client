import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';
import 'package:image_hoster/features/image/presentation/upload/bloc/upload_image_bloc.dart';
import 'package:image_hoster/features/image/presentation/upload/widget/paint_image_page.dart';
import 'package:image_hoster/features/image/presentation/upload/widget/upload_image_page.dart';
import 'package:image_hoster/generated/l10n.dart';
import 'package:image_hoster/ui/components/screen.dart';
import 'package:image_hoster/ui/kit/gap.dart';
import 'package:image_hoster/ui/util/snackbar_util.dart';

class UploadImageWidget extends StatefulWidget {
  final int folderId;

  const UploadImageWidget({Key? key, required this.folderId}) : super(key: key);

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  Uint8List? originalImage;
  ui.Image? originalUiImage;

  final pageController = PageController();
  int currentPage = 0;
  final List<PointInfo> drawPoints = [];

  final paintImagePageKey = GlobalKey<PaintImagePageState>();

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<UploadImageBloc, UploadImageState>(
      listener: (context, state) {
        if (state is ProgressImageState) {
          setState(() {
            progress = state.progress;
          });
        }
        if (state is UploadedImageState) {
          context.navigation.images(widget.folderId);
        }
        if (state is ErrorUploadImageState) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: [
                        UploadImagePage(
                          image: originalImage,
                          onUploaded: (file) async {
                            originalUiImage = await bytesToImage(file);
                            setState(() {
                              originalImage = file;
                            });
                          },
                        ),
                        if (originalImage != null && originalUiImage != null)
                          PaintImagePage(
                            key: paintImagePageKey,
                            image: originalUiImage!,
                            onDraw: (offset) {
                              setState(() {
                                drawPoints.add(offset);
                              });
                            },
                            points: drawPoints,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap.md,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (currentPage > 0)
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () async {
                      await _previousPage();
                    },
                    child: Text(S.current.back),
                  )),
                Gap.md,
                Expanded(
                    child: OutlinedButton(
                  onPressed: () {
                    if (originalImage == null) {
                      context.navigation.images(widget.folderId);
                    } else {
                      if (currentPage == 0) {
                        setState(() {
                          originalImage = null;
                          drawPoints.clear();
                        });
                      } else {
                        setState(() {
                          drawPoints.clear();
                        });
                      }
                    }
                  },
                  child: originalImage == null
                      ? Text(S.current.cancelButton)
                      : Text(S.current.clear),
                )),
                Gap.md,
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onNextPressed(),
                    child: currentPage == 1
                        ? Text(S.current.upload)
                        : Text(S.current.next),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      showProgress: (state) => progress,
    );
  }

  _nextPage() async {
    setState(() {
      currentPage++;
    });
    await pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  _previousPage() async {
    setState(() {
      currentPage--;
    });
    await pageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  VoidCallback? _onNextPressed() {
    if (originalImage == null || progress) {
      return null;
    } else {
      return () async {
        if (currentPage < 1) {
          await _nextPage();
        } else {
          setState(() {
            progress = true;
          });
          final bloc = BlocProvider.of<UploadImageBloc>(context);
          final image = await paintImagePageKey.currentState?.getImage();
          if (originalImage != null && image != null) {
            bloc.add(SendImageEvent(originalImage!, image));
          }
        }
      };
    }
  }

  Future<ui.Image> bytesToImage(Uint8List imgBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame;
    try {
      frame = await codec.getNextFrame();
    } finally {
      codec.dispose();
    }
    return frame.image;
  }
}
