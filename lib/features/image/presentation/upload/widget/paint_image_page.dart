import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaintImagePage extends StatefulWidget {
  final ui.Image image;
  final List<PointInfo> points;
  final ValueChanged<PointInfo> onDraw;

  const PaintImagePage({
    Key? key,
    required this.image,
    required this.points,
    required this.onDraw,
  }) : super(key: key);

  @override
  State<PaintImagePage> createState() => PaintImagePageState();
}

class PaintImagePageState extends State<PaintImagePage> {
  bool newLine = true;
  final shiftKeys = [
    LogicalKeyboardKey.shiftLeft,
    LogicalKeyboardKey.shiftRight,
  ];

  ImageOffset? imageOffset;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final imageSize = Size(
      widget.image.width.toDouble(),
      widget.image.height.toDouble(),
    );

    return Center(
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: GestureDetector(
          onPanDown: (details) {
            final isShiftPressed = RawKeyboard.instance.keysPressed.where((it) => shiftKeys.contains(it)).isNotEmpty;

            final drawNewLine = newLine && !isShiftPressed;
            setState(() {
              newLine = false;
            });
            widget.onDraw.call(PointInfo(details.localPosition, drawNewLine));
          },
          onPanUpdate: (details) {
            final isShiftPressed = RawKeyboard.instance.keysPressed.where((it) => shiftKeys.contains(it)).isNotEmpty;

            final drawNewLine = newLine && !isShiftPressed;
            widget.onDraw.call(PointInfo(details.localPosition, drawNewLine));
          },
          onPanEnd: (details) {
            setState(() {
              newLine = true;
            });
          },
          child: CustomPaint(
            size: imageSize,
            painter: ImageEditor(
                image: widget.image,
                points: widget.points,
                scaleImage: true,
                onOffsetChanged: (offset) {
                  imageOffset = offset;
                }),
            child: Container(),
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> getImage() async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    final scaleFactor = imageOffset?.scaleFactor ?? 1;

    final points = widget.points
        .map((e) => PointInfo(
            Offset(
              (e.offset.dx - (imageOffset?.offsetX ?? 0)) / scaleFactor,
              (e.offset.dy - (imageOffset?.offsetY ?? 0)) / scaleFactor,
            ),
            e.newLine))
        .toList();

    var painter = ImageEditor(
      points: points,
      image: widget.image,
      scaleImage: false,
      scale: 1 / scaleFactor,
    );

    painter.paint(
      canvas,
      Size(
        widget.image.width.toDouble(),
        widget.image.height.toDouble(),
      ),
    );

    ui.Image renderedImage = await recorder.endRecording().toImage(
          widget.image.width,
          widget.image.height,
        );

    final byteData = await renderedImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final bytes = byteData?.buffer.asUint8List();
    return bytes;
  }
}

class PointInfo {
  final Offset offset;
  final bool newLine;

  PointInfo(this.offset, this.newLine);
}

class ImageOffset {
  final double scaleFactor;
  final double offsetX;
  final double offsetY;
  final double width;
  final double height;

  ImageOffset(this.scaleFactor, this.offsetX, this.offsetY, this.width, this.height);
}

class ImageEditor extends CustomPainter {
  ImageEditor({required this.image, required this.points, this.scaleImage = true, this.onOffsetChanged, this.scale = 1});

  final ui.Image image;
  final List<PointInfo> points;
  final bool scaleImage;
  final ValueChanged<ImageOffset>? onOffsetChanged;
  final double scale;

  late final Paint painter = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill
    ..strokeWidth = scale * 6
    ..filterQuality = FilterQuality.high;

  @override
  void paint(Canvas canvas, Size size) {
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final canvasSize = size;

    final double widthScale = canvasSize.width / imageSize.width;
    final double heightScale = canvasSize.height / imageSize.height;

    double scaleFactor = min(widthScale, heightScale);

    if (scaleFactor > 1) scaleFactor = 1;

    final double scaledWidth = scaleImage ? imageSize.width * scaleFactor : imageSize.width;
    final double scaledHeight = scaleImage ? imageSize.height * scaleFactor : imageSize.height;

    final double offsetX = scaleImage ? (canvasSize.width - scaledWidth) / 2 : 0;
    final double offsetY = scaleImage ? (canvasSize.height - scaledHeight) / 2 : 0;

    onOffsetChanged?.call(ImageOffset(scaleFactor, offsetX, offsetY, scaledWidth, scaledHeight));

    final Rect imageRect = Rect.fromLTWH(
      offsetX,
      offsetY,
      scaledWidth,
      scaledHeight,
    );

    canvas.clipRect(Rect.fromLTWH(offsetX, offsetY, scaledWidth, scaledHeight));
    canvas.drawImageRect(image, Rect.fromLTRB(0, 0, imageSize.width, imageSize.height), imageRect, Paint());

    for ((int, PointInfo) offset in points.indexed) {
      if (offset.$1 > 0 && !offset.$2.newLine) {
        canvas.drawLine(
          points[offset.$1 - 1].offset,
          offset.$2.offset,
          painter,
        );
      } else {
        canvas.drawCircle(offset.$2.offset, 3, painter);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
