import 'dart:io';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final File image;
  final String label;
  final double confidence;

  const ResultScreen({
    super.key,
    required this.image,
    required this.label,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInvalid = label.toLowerCase() == "invalid";
    final bool isClean = label.toLowerCase() == "clean";

    // ✅ Color logic for all states
    Color cardColor = isInvalid
        ? Colors.orange[50]!
        : isClean
        ? Colors.green[50]!
        : Colors.red[50]!;

    Color borderColor = isInvalid
        ? Colors.orange
        : isClean
        ? Colors.green
        : Colors.red;

    IconData cardIcon = isInvalid
        ? Icons.image_not_supported
        : isClean
        ? Icons.check_circle
        : Icons.warning;

    String displayLabel = isInvalid ? "Not a Solar Panel Image" : label;

    String message = isInvalid
        ? "Please take a clear photo of your solar panel and try again."
        : isClean
        ? "Your solar panel looks clean and healthy!"
        : "Your solar panel needs attention.";

    return Scaffold(
      appBar: AppBar(title: const Text("Analysis Result"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔹 Image Display
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Result Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Column(
                children: [
                  Icon(cardIcon, color: borderColor, size: 50),

                  const SizedBox(height: 10),

                  Text(
                    displayLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: borderColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),

                  const SizedBox(height: 10),

                  // ✅ Only show confidence for valid predictions
                  if (!isInvalid)
                    Text(
                      "Confidence: ${(confidence * 100).toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),

            const Spacer(),

            // 🔹 Try Again Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  isInvalid ? "Take Another Photo" : "Try Another Image",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
