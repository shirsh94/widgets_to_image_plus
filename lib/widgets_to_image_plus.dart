library widgets_to_image_plus;

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class WidgetToImagePlus {
  final GlobalKey _containerKey = GlobalKey();

  /// Key to associate with the widget
  GlobalKey get containerKey => _containerKey;

  /// Capture the widget as an image in various formats
  Future<Uint8List?> simpleCapture({
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    try {
      RenderRepaintBoundary? boundary = _containerKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: format);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      rethrow;
    }
  }

  /// Convert widget to a grayscale image
  Future<Uint8List?> captureAsGrayscale({
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyColorFilter(
        pixelRatio: pixelRatio,
        format: format,
        colorFilter:
        const ColorFilter.mode(Colors.white, BlendMode.saturation));
  }

  /// Add watermark to captured image
  Future<Uint8List?> captureWithWatermark({
    required String watermark,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyTextOverlay(
        pixelRatio: pixelRatio, format: format, text: watermark);
  }

  /// Capture with a custom background color
  Future<Uint8List?> captureWithBackground({
    required Color backgroundColor,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    try {
      RenderRepaintBoundary? boundary = _containerKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw background color
      canvas.drawColor(backgroundColor, BlendMode.src);
      canvas.drawImage(image, Offset.zero, Paint());

      final finalImage = await recorder.endRecording().toImage(
        image.width,
        image.height,
      );
      final byteData = await finalImage.toByteData(format: format);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      rethrow;
    }
  }

  /// Generate a thumbnail of the captured image
  Future<Uint8List?> generateThumbnail({
    double scaleFactor = 0.1,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    try {
      final originalBytes = await simpleCapture(format: format);
      if (originalBytes == null) return null;

      final codec = await ui.instantiateImageCodec(originalBytes,
          targetWidth: (scaleFactor * 100).toInt());
      final frame = await codec.getNextFrame();
      final image = frame.image;
      final byteData = await image.toByteData(format: format);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      rethrow;
    }
  }

  /// Rotate the captured image
  Future<Uint8List?> captureWithRotation({
    required double angle,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyTransformation(
        pixelRatio: pixelRatio,
        format: format,
        transform: (canvas, image) {
          canvas.translate(image.width / 2, image.height / 2);
          canvas.rotate(angle);
          canvas.translate(-image.width / 2, -image.height / 2);
          canvas.drawImage(image, Offset.zero, Paint());
        });
  }

  /// Invert the colors of the captured image
  Future<Uint8List?> captureWithInvertedColors({
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyColorFilter(
        pixelRatio: pixelRatio,
        format: format,
        colorFilter: const ColorFilter.matrix([
          -1,
          0,
          0,
          0,
          255,
          0,
          -1,
          0,
          0,
          255,
          0,
          0,
          -1,
          0,
          255,
          0,
          0,
          0,
          1,
          0,
        ]));
  }

  /// Apply a sepia tone to the captured image
  Future<Uint8List?> captureWithSepia({
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyColorFilter(
        pixelRatio: pixelRatio,
        format: format,
        colorFilter: const ColorFilter.matrix([
          0.393,
          0.769,
          0.189,
          0,
          0,
          0.349,
          0.686,
          0.168,
          0,
          0,
          0.272,
          0.534,
          0.131,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]));
  }

  /// Brighten the captured image
  Future<Uint8List?> captureWithBrightness({
    required double brightness,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyColorFilter(
        pixelRatio: pixelRatio,
        format: format,
        colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(brightness), BlendMode.srcATop));
  }

  /// Adjust the contrast of the captured image
  Future<Uint8List?> captureWithContrast({
    required double contrast,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyColorFilter(
        pixelRatio: pixelRatio,
        format: format,
        colorFilter: ColorFilter.matrix([
          contrast,
          0,
          0,
          0,
          0,
          0,
          contrast,
          0,
          0,
          0,
          0,
          0,
          contrast,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]));
  }

  /// Adjust the saturation of the captured image
  Future<Uint8List?> captureWithSaturation({
    required double saturation,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyColorFilter(
        pixelRatio: pixelRatio,
        format: format,
        colorFilter: ColorFilter.matrix([
          0.3 + 0.7 * saturation,
          0.3 + 0.7 * saturation,
          0.3 + 0.7 * saturation,
          0,
          0,
          0.3 + 0.7 * saturation,
          0.3 + 0.7 * saturation,
          0.3 + 0.7 * saturation,
          0,
          0,
          0.3 + 0.7 * saturation,
          0.3 + 0.7 * saturation,
          0.3 + 0.7 * saturation,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]));
  }

  /// Apply a vignette effect to the captured image
  Future<Uint8List?> captureWithVignette({
    required double radius,
    required Color color,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    // Vignette effect can be complex; this is a simplified version
    return _applyTransformation(
        pixelRatio: pixelRatio,
        format: format,
        transform: (canvas, image) {
          canvas.drawImage(image, Offset.zero, Paint());
          final paint = Paint()
            ..colorFilter =
            ColorFilter.mode(color.withOpacity(radius), BlendMode.srcOut);
          canvas.drawRect(
              Rect.fromLTWH(
                  0, 0, image.width.toDouble(), image.height.toDouble()),
              paint);
        });
  }

  /// Draw border around the image
  Future<Uint8List?> captureWithBorder({
    required double thickness,
    required Color color,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyTransformation(
        pixelRatio: pixelRatio,
        format: format,
        transform: (canvas, image) {
          // Draw the original image
          canvas.drawImage(image, Offset.zero, Paint());

          // Create a paint object for the border
          final paint = Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = thickness;

          // Draw the border around the image
          canvas.drawRect(
            Rect.fromLTWH(
                0, 0, image.width.toDouble(), image.height.toDouble()),
            paint,
          );
        });
  }

  /// Add rounded corners to the image
  Future<Uint8List?> captureWithRoundedCorners({
    required double radius,
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyTransformation(
        pixelRatio: pixelRatio,
        format: format,
        transform: (canvas, image) {
          canvas.save();
          canvas.clipRRect(RRect.fromRectAndRadius(
              Rect.fromLTWH(
                  0, 0, image.width.toDouble(), image.height.toDouble()),
              Radius.circular(radius)));
          canvas.drawImage(image, Offset.zero, Paint());
          canvas.restore();
        });
  }

  /// Flip the captured image horizontally
  Future<Uint8List?> captureWithHorizontalFlip({
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyTransformation(
        pixelRatio: pixelRatio,
        format: format,
        transform: (canvas, image) {
          canvas.scale(-1, 1);
          canvas.drawImage(image, Offset(-image.width.toDouble(), 0), Paint());
        });
  }

  /// Flip the captured image vertically
  Future<Uint8List?> captureWithVerticalFlip({
    double pixelRatio = 6,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    return _applyTransformation(
        pixelRatio: pixelRatio,
        format: format,
        transform: (canvas, image) {
          canvas.scale(1, -1);
          canvas.drawImage(image, Offset(0, -image.height.toDouble()), Paint());
        });
  }

  /// Private method to apply a transformation to the captured image
  Future<Uint8List?> _applyTransformation({
    required double pixelRatio,
    required ui.ImageByteFormat format,
    required Function(Canvas canvas, ui.Image image) transform,
  }) async {
    try {
      final originalBytes = await simpleCapture(pixelRatio: pixelRatio);
      if (originalBytes == null) return null;

      final codec = await ui.instantiateImageCodec(originalBytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);

      // Apply the transformation
      transform(canvas, image);

      final transformedImage = await pictureRecorder
          .endRecording()
          .toImage(image.width, image.height);

      final byteData = await transformedImage.toByteData(format: format);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      rethrow;
    }
  }

  /// Private method to apply a color filter to the captured image
  Future<Uint8List?> _applyColorFilter({
    required double pixelRatio,
    required ui.ImageByteFormat format,
    required ColorFilter colorFilter,
  }) async {
    try {
      final originalBytes = await simpleCapture(pixelRatio: pixelRatio);
      if (originalBytes == null) return null;

      final codec = await ui.instantiateImageCodec(originalBytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final paint = Paint()
        ..colorFilter = colorFilter;
      canvas.drawImage(image, Offset.zero, paint);

      final filteredImage = await pictureRecorder
          .endRecording()
          .toImage(image.width, image.height);

      final byteData = await filteredImage.toByteData(format: format);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      rethrow;
    }
  }

  /// Private method to apply text overlay on the captured image
  Future<Uint8List?> _applyTextOverlay({
    required double pixelRatio,
    required ui.ImageByteFormat format,
    required String text,
  }) async {
    try {
      final originalBytes = await simpleCapture(pixelRatio: pixelRatio);
      if (originalBytes == null) return null;

      final codec = await ui.instantiateImageCodec(originalBytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      canvas.drawImage(image, Offset.zero, Paint());

      final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 24,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: image.width.toDouble(),
      );
      textPainter.paint(canvas, Offset(20, image.height - 40));

      final watermarkedImage = await pictureRecorder
          .endRecording()
          .toImage(image.width, image.height);

      final byteData = await watermarkedImage.toByteData(format: format);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      rethrow;
    }
  }
}

