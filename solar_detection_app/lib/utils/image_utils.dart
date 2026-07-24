import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'constants.dart';

class ImageUtils {
  static img.Image? decodeAndResize(Uint8List bytes) {
    final img.Image? original = img.decodeImage(bytes);
    if (original == null) return null;

    return img.copyResize(
      original,
      width: AppConstants.imageSize,
      height: AppConstants.imageSize,
    );
  }

  static List<List<List<List<double>>>> imageToTensor(img.Image image) {
    final int size = AppConstants.imageSize;

    return [
      List.generate(size, (y) {
        return List.generate(size, (x) {
          final pixel = image.getPixel(x, y);

          // ✅ YOLOv8 normalization - must match training
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        });
      }),
    ];
  }
}
