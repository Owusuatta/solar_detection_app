// lib/widgets/prediction_card.dart

import 'package:flutter/material.dart';

class PredictionCard extends StatelessWidget {
  final String label;
  final double confidence;

  const PredictionCard({
    super.key,
    required this.label,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    final bool isClean = label.toLowerCase() == "clean";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isClean ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isClean ? Colors.green : Colors.red),
      ),
      child: Column(
        children: [
          Icon(
            isClean ? Icons.check_circle : Icons.warning,
            color: isClean ? Colors.green : Colors.red,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isClean ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 5),
          Text("Confidence: ${(confidence * 100).toStringAsFixed(2)}%"),
        ],
      ),
    );
  }
}
