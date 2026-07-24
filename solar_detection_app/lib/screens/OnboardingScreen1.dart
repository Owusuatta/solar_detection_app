import 'package:flutter/material.dart';
import 'package:solar_detection_app/screens/OnboardingScreen2.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 LAYER 1: The Full-Screen Background
          // We use SizedBox.expand to make sure it fills every pixel
          SizedBox.expand(
            child: Image.asset('assets/solar_panel.jpg', fit: BoxFit.cover),
          ),

          // 🔹 LAYER 2: The Cinematic Gradient
          // This creates the "Dark Bottom" look from your reference image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.8), // Darker at the very bottom
                ],
                stops: const [0.4, 0.7, 1.0],
              ),
            ),
          ),

          // 🔹 LAYER 3: The UI Elements
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // 👈 Pushes everything to the bottom
                children: [
                  // The "Infinity/Logo" style icon
                  const Icon(
                    Icons.all_inclusive,
                    color: Colors.white,
                    size: 80,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'AI-Powered Solar Intelligence',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Use advanced image recognition to detect solar panels faults and optimize performance.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),

                  const SizedBox(height: 40),

                  // The "Pill" Button like the reference image
                  GestureDetector(
                    onTap: () {
                      // Navigate to next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen2(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
