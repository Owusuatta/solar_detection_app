import 'dart:io';
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../models/prediction_model.dart';
import '../utils/constants.dart';
import '../utils/image_utils.dart';

class TFLiteService {
  Interpreter? _interpreter;
  bool _isLoaded = false;

  // ✅ Confidence threshold - rejects non-solar images
  static const double confidenceThreshold = 0.70;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(AppConstants.modelPath);
      _isLoaded = true;
      print("✅ Model loaded");
    } catch (e) {
      print("❌ Model load error: $e");
    }
  }

  Future<Prediction?> predict(File imageFile) async {
    if (!_isLoaded || _interpreter == null) {
      print("❌ Model not loaded");
      return null;
    }

    try {
      Uint8List bytes = await imageFile.readAsBytes();

      final resized = ImageUtils.decodeAndResize(bytes);
      if (resized == null) {
        print("❌ Invalid image");
        return null;
      }

      final input = ImageUtils.imageToTensor(resized);

      var output = List.generate(
        1,
        (_) => List.filled(AppConstants.labels.length, 0.0),
      );

      _interpreter!.run(input, output);

      print("✅ MODEL OUTPUT: $output");

      // Get best prediction
      int bestIndex = 0;
      double bestScore = 0;

      for (int i = 0; i < AppConstants.labels.length; i++) {
        if (output[0][i] > bestScore) {
          bestScore = output[0][i];
          bestIndex = i;
        }
      }

      print(
        "🎯 Predicted: ${AppConstants.labels[bestIndex]} at ${(bestScore * 100).toStringAsFixed(1)}%",
      );

      // ✅ Confidence threshold check
      if (bestScore < confidenceThreshold) {
        return Prediction(label: "invalid", confidence: bestScore);
      }

      return Prediction(
        label: AppConstants.labels[bestIndex],
        confidence: bestScore,
      );
    } catch (e) {
      print("❌ Prediction error: $e");
      return null;
    }
  }

  void close() {
    _interpreter?.close();
  }
}
