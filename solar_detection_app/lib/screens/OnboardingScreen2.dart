import 'package:flutter/material.dart';
import 'package:solar_detection_app/screens/home_screen.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use a Stack so the image can be the "Bottom Layer"
      body: Stack(
        children: [
          // 🔹 LAYER 1: The Full-Screen Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/onboarding_screen 2.jpg',
              fit: BoxFit.cover, // Makes the image fill the whole screen
            ),
          ),

          // 🔹 LAYER 2: The Gradient Overlay (The "Tide App" Secret)
          // This makes the bottom dark so white text is readable
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8), // Darkest at the bottom
                ],
                stops: const [
                  0.4,
                  0.7,
                  1.0,
                ], // Starts getting dark at 40% height
              ),
            ),
          ),

          // 🔹 LAYER 3: The Content (Text and Buttons)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Pushes text to the bottom
                children: [
                  const Text(
                    "Save the Planet",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Using solar energy helps keep our air clean.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),

                  const SizedBox(height: 60), // Space before buttons
                  // The Action Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),

                      // Styled "Next" Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF001F3F),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Next"),
                      ),
                    ],
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
