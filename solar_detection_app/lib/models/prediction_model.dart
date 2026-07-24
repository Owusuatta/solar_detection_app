// lib/models/prediction_model.dart

class Prediction {
  final String label;
  final double confidence;

  Prediction({required this.label, required this.confidence});

  // 🔹 Convert to readable string
  @override
  String toString() {
    return '$label (${(confidence * 100).toStringAsFixed(2)}%)';
  }

  // 🔹 Convert to Map (for storage / logging)
  Map<String, dynamic> toMap() {
    return {'label': label, 'confidence': confidence};
  }

  // 🔹 Create object from Map safely
  factory Prediction.fromMap(Map<String, dynamic> map) {
    return Prediction(
      label: map['label'] ?? '',
      confidence: (map['confidence'] ?? 0).toDouble(),
    );
  }
}

// 🔥 Advanced: Handle multiple predictions
class PredictionResult {
  final List<Prediction> predictions;

  PredictionResult({required this.predictions});

  // 🔹 Ensure predictions are sorted (highest confidence first)
  List<Prediction> get sortedPredictions {
    List<Prediction> sorted = List.from(predictions);
    sorted.sort((a, b) => b.confidence.compareTo(a.confidence));
    return sorted;
  }

  // 🔹 Get top prediction safely
  Prediction? get topPrediction {
    if (predictions.isEmpty) return null;
    return sortedPredictions.first;
  }

  // 🔹 Get only labels
  List<String> get labels {
    return predictions.map((p) => p.label).toList();
  }

  // 🔹 Get only confidence scores
  List<double> get confidences {
    return predictions.map((p) => p.confidence).toList();
  }

  // 🔹 Convert to Map (for saving/logging)
  Map<String, dynamic> toMap() {
    return {'predictions': predictions.map((p) => p.toMap()).toList()};
  }

  // 🔹 Create from Map safely
  factory PredictionResult.fromMap(Map<String, dynamic> map) {
    return PredictionResult(
      predictions: (map['predictions'] as List<dynamic>? ?? [])
          .map((item) => Prediction.fromMap(item))
          .toList(),
    );
  }

  // 🔹 Pretty print (useful for debugging)
  @override
  String toString() {
    return sortedPredictions.map((p) => p.toString()).join('\n');
  }
}
