import 'package:flutter/material.dart';
// 1. This tells the app where your first screen is
import 'screens/OnboardingScreen1.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar App',
      // 2. This hides that little red "Debug" banner in the corner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 3. This makes your app look modern
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // 4. This is the "Front Door" - it shows your onboarding screen!
      home: const OnboardingScreen1(),
    );
  }
}
