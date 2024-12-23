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
