# Widgets to Image Plus

`widgets_to_image_plus` is a versatile Flutter library designed to capture Flutter widgets as
images. This library provides a range of functionalities that enable developers to manipulate and
customize images generated from Flutter widgets, enhancing the visual appeal and interactivity of
applications.

[![pub package](https://img.shields.io/pub/v/widgets_to_image_plus.svg)](https://pub.dev/packages/widgets_to_image_plus)

## Screenshots
![Screenshot 1](https://raw.githubusercontent.com/shirsh94/flutter_doc_scanner/main/demo/screen_shot_1.jpg?raw=true) 

## Features

- **Capture Widgets as Images**: Easily convert any Flutter widget into an image in multiple
  formats, including PNG and JPEG.
- **Image Manipulation**: Apply various transformations to the captured images, such as:
    - Grayscale conversion
    - Watermark addition
    - Background color customization
    - Thumbnail generation
- **Image Effects**: Enhance images with a variety of effects including:
    - Rotation
    - Color inversion
    - Sepia tone
    - Brightness, contrast, and saturation adjustments
    - Vignette effects
    - Borders and rounded corners
    - Horizontal and vertical flipping

## Installation

To integrate `widgets_to_image_plus` into your Flutter project, add the following dependency to
your `pubspec.yaml` file:

```yaml
dependencies:
  widgets_to_image_plus: ^0.0.1
```

## Import the library into your Dart file:

```dart
import 'package:widgets_to_image_plus/widgets_to_image_plus.dart';
```

## Basic Example

Here's a simple example demonstrating how to use widgets_to_image_plus to capture a widget and
display it as an image:

```dart
  Future<void> _captureImage() async {
  final WidgetToImagePlus _controller = WidgetToImagePlus();
  final bytes = await _controller.simpleCapture();
  print("Your Image"+bytes.toString());
}
```

## Full Example

```dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:widgets_to_image_plus/widgets_to_image_plus.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  final WidgetToImagePlus _controller = WidgetToImagePlus();
  Uint8List? _imageBytes;

  Future<void> _captureImage() async {
    final bytes =
    await _controller.simpleCapture(format: ui.ImageByteFormat.png);
    _setImage(bytes);
  }

  Future<void> _captureAsGrayscale() async {
    final bytes = await _controller.captureAsGrayscale();
    _setImage(bytes);
  }

  Future<void> _captureWithWatermark() async {
    final bytes =
    await _controller.captureWithWatermark(watermark: "Watermark");
    _setImage(bytes);
  }

  Future<void> _captureWithBackground() async {
    final bytes =
    await _controller.captureWithBackground(backgroundColor: Colors.red);
    _setImage(bytes);
  }

  Future<void> _generateThumbnail() async {
    final bytes = await _controller.generateThumbnail();
    _setImage(bytes);
  }

  Future<void> _captureWithRotation() async {
    final bytes = await _controller.captureWithRotation(angle: 0.5);
    _setImage(bytes);
  }

  Future<void> _captureWithInvertedColors() async {
    final bytes = await _controller.captureWithInvertedColors();
    _setImage(bytes);
  }

  Future<void> _captureWithSepia() async {
    final bytes = await _controller.captureWithSepia();
    _setImage(bytes);
  }

  Future<void> _captureWithBrightness() async {
    final bytes = await _controller.captureWithBrightness(brightness: 0.5);
    _setImage(bytes);
  }

  Future<void> _captureWithContrast() async {
    final bytes = await _controller.captureWithContrast(contrast: 1.5);
    _setImage(bytes);
  }

  Future<void> _captureWithSaturation() async {
    final bytes = await _controller.captureWithSaturation(saturation: 1.5);
    _setImage(bytes);
  }

  Future<void> _captureWithVignette() async {
    final bytes =
    await _controller.captureWithVignette(radius: 0.5, color: Colors.black);
    _setImage(bytes);
  }

  Future<void> _captureWithBorder() async {
    final bytes =
    await _controller.captureWithBorder(thickness: 20, color: Colors.black);
    _setImage(bytes);
  }

  Future<void> _captureWithRoundedCorners() async {
    final bytes = await _controller.captureWithRoundedCorners(radius: 20);
    _setImage(bytes);
  }

  Future<void> _captureWithHorizontalFlip() async {
    final bytes = await _controller.captureWithHorizontalFlip();
    _setImage(bytes);
  }

  Future<void> _captureWithVerticalFlip() async {
    final bytes = await _controller.captureWithVerticalFlip();
    _setImage(bytes);
  }

  void _setImage(Uint8List? bytes) {
    if (bytes != null) {
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capture Widget as Image"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: _controller.containerKey,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Hello, Flutter!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 20,
                alignment:  WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _captureImage,
                    child: Text("Capture Image"),
                  ),
                  ElevatedButton(
                    onPressed: _captureAsGrayscale,
                    child: Text("Capture as Grayscale"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithWatermark,
                    child: Text("Capture with Watermark"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithBackground,
                    child: Text("Capture with Background"),
                  ),
                  ElevatedButton(
                    onPressed: _generateThumbnail,
                    child: Text("Generate Thumbnail"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithRotation,
                    child: Text("Capture with Rotation"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithInvertedColors,
                    child: Text("Capture with Inverted Colors"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithSepia,
                    child: Text("Capture with Sepia"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithBrightness,
                    child: Text("Capture with Brightness"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithContrast,
                    child: Text("Capture with Contrast"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithSaturation,
                    child: Text("Capture with Saturation"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithVignette,
                    child: Text("Capture with Vignette"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithBorder,
                    child: Text("Capture with Border"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithRoundedCorners,
                    child: Text("Capture with Rounded Corners"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithHorizontalFlip,
                    child: Text("Capture with Horizontal Flip"),
                  ),
                  ElevatedButton(
                    onPressed: _captureWithVerticalFlip,
                    child: Text("Capture with Vertical Flip"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_imageBytes != null)
                Image.memory(_imageBytes!), // Display captured image
            ],
          ),
        ),
      ),
    );
  }
}
```

## Available Methods

The library provides several methods for capturing widgets and applying image manipulations:

- Future<Uint8List?> simpleCapture({double pixelRatio, ui.ImageByteFormat format})
- Future<Uint8List?> captureAsGrayscale({double pixelRatio, ui.ImageByteFormat format})
- Future<Uint8List?> captureWithWatermark({required String watermark, double pixelRatio,
  ui.ImageByteFormat format})
- Future<Uint8List?> captureWithBackground({required Color backgroundColor, double pixelRatio,
  ui.ImageByteFormat format})
- Future<Uint8List?> generateThumbnail({double scaleFactor, ui.ImageByteFormat format})
- Future<Uint8List?> captureWithRotation({required double angle, double pixelRatio,
  ui.ImageByteFormat format})
- Future<Uint8List?> captureWithInvertedColors({double pixelRatio, ui.ImageByteFormat format})
- Future<Uint8List?> captureWithSepia({double pixelRatio, ui.ImageByteFormat format})
- Future<Uint8List?> captureWithBrightness({required double brightness, double pixelRatio,
  ui.ImageByteFormat format})
- Future<Uint8List?> captureWithContrast({required double contrast, double pixelRatio,
  ui.ImageByteFormat format})
- Future<Uint8List?> captureWithSaturation({required double saturation, double pixelRatio,
  ui.ImageByteFormat format})
- Future<Uint8List?> captureWithVignette({required double radius, required Color color, double
  pixelRatio, ui.ImageByteFormat format})
- Future<Uint8List?> captureWithBorder({required double thickness, required Color color, double
  pixelRatio, ui.ImageByteFormat format})
- Future<Uint8List?> captureWithRoundedCorners({required double radius, double pixelRatio,
  ui.ImageByteFormat format})
- Future<Uint8List?> captureWithHorizontalFlip({double pixelRatio, ui.ImageByteFormat format})
- Future<Uint8List?> captureWithVerticalFlip({double pixelRatio, ui.ImageByteFormat format})

## Contributing

Contributions to widgets_to_image_plus are welcome! If you have suggestions for improvements, bug
fixes, or new features, please submit a pull request or open an issue on GitHub.


## License

The MIT License (MIT) Copyright (c) 2024 Shirsh Shukla

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.






