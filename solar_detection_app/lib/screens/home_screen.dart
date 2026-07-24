import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/tflite_service.dart';
import 'result_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? selectedImage;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  //final TFLiteService tfliteService = TFLiteService();
  late TFLiteService tfliteService;

  @override
  void initState() {
    super.initState();
    tfliteService = TFLiteService();
    tfliteService.loadModel();
  }

  final Color primaryTeal = const Color(0xFF1A7F80);

  Future<void> _pickImage(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);
    if (photo != null) {
      setState(() {
        selectedImage = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Image
          SizedBox.expand(
            child: Image.asset('assets/solar_roof.jpg', fit: BoxFit.cover),
          ),

          // 🔹 Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // 🔹 Main Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 🔹 Header with Navigation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.solar_power,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Solar AI",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.miscellaneous_services,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),
                const Text(
                  "Detect faults in solar panels using AI",
                  style: TextStyle(color: Colors.white70),
                ),

                const Spacer(),

                // 🔥 Glass Container
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            // 🔹 Image Preview
                            GestureDetector(
                              onTap: () => _pickImage(ImageSource.gallery),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    selectedImage == null
                                        ? Container(
                                            height: 180,
                                            width: double.infinity,
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.image,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : Image.file(
                                            selectedImage!,
                                            height: 180,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),

                                    // Overlay gradient
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.6),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Text overlay
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            selectedImage == null
                                                ? "Tap to upload image"
                                                : "Tap to change image",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // 🔹 Buttons
                            Row(
                              children: [
                                _buildActionButton(
                                  icon: Icons.camera_alt_rounded,
                                  label: "Camera",
                                  color: primaryTeal,
                                  isLeft: true,
                                  onTap: () => _pickImage(ImageSource.camera),
                                ),
                                const SizedBox(width: 2),
                                _buildActionButton(
                                  icon: Icons.photo_library_rounded,
                                  label: "Gallery",
                                  color: Colors.grey[300]!,
                                  textColor: primaryTeal,
                                  isLeft: false,
                                  onTap: () => _pickImage(ImageSource.gallery),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            // 🔹 Analyze Button
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryTeal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: selectedImage == null
                                    ? null
                                    : () async {
                                        setState(() => isLoading = true);

                                        // Logic for prediction
                                        final result = await tfliteService
                                            .predict(selectedImage!);

                                        setState(() => isLoading = false);

                                        if (result != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ResultScreen(
                                                    image: selectedImage!,
                                                    label: result.label,
                                                    confidence:
                                                        result.confidence,
                                                  ),
                                            ),
                                          );
                                        }
                                      },
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.analytics,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Analyze Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // 🔹 Bottom Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(child: _buildSmallStatCard("Accuracy ~83%")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildSmallStatCard("Works Offline")),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    Color textColor = Colors.white,
    required bool isLeft,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              bottomLeft: isLeft ? const Radius.circular(20) : Radius.zero,
              bottomRight: !isLeft ? const Radius.circular(20) : Radius.zero,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 28),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallStatCard(String title) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
