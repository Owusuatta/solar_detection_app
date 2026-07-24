// lib/utils/constants.dart

class AppConstants {
  // 🔹 Model path (must match pubspec.yaml)
  static const String modelPath =
      'assets/models/solar_panel_best_float16.tflite';

  // 🔹 Image input size (must match training)
  static const int imageSize = 224;

  // 🔹 Class labels (MUST match training order)
  static const List<String> labels = [
    "Bird-drop",
    "Clean",
    "Dusty",
    "Electrical-damage",
    "Physical-Damage",
    "Snow-Covered",
  ];
}
