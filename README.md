The Solar Panel Condition Detection Application is a test application for detecting whether solar panels are in good or poor condition.

A mobile application that works across all platforms which is able to automatically detect, classify and analyse the physical condition of solar panels from real time camera feeds and/or gallery images. The general objective of this project is to provide a more efficient computer vision model application, through a user-friendly and lightweight mobile interior, thus optimizing maintenance operations.

---

## Key Features

Real time identification and condition diagnosis with the mobile camera view.
Static Image Inference: Upload pictures or aerial captures from the device gallery for diagnostic processing.
**High Efficiency**: Optimized for efficient battery usage and processing time on edge devices.
Full cross platform support of Android and iOS.

---

## Technical Stack

### Computer Vision Engine: YOLOv8
The AI core bases its functionality on Ultralytics YOLOv8, which is state-of-the-art and optimized for multi-class classification and structural localization.
Model Type: EXPORT TO TENSORFLOW LITE (TFLITE) - Localized, Off-line processing on a mobile device.
* **Input Resolution**: Preprocessed to 640x640 to follow the standard configurations of YOLO neural networks.
The network rates target areas according to five maintenance classifications:
  Optimal state in which there is no obstruction: Clean.
  Dusty: Accumulation of surface particles that is cleaned normally.
  Electrical: Internal degradation, hot spots, wiring connection faults.
  Physical Damage: Surface cracks, hail impact fractures, or structural warping.
  * Slowdown: Degraded performance or anomalies in performance during the test that need additional confirmation in a diagnostic test.

### Mobile Framework: Flutter
The complete flutter framework is used for the app user interface and model binding system.
* State Management: Optimized to deal with live camera streams with out latency.
Image Processing Engine: Assets are processed at the hardware level for frame tracking.
**Native Threading**: Runs TFLite inferences asynchronously using background tasks (Isolates) to keep the main UI thread unresponsive to inference requests.

---

## Project Directory Structure

```text
solar_detection_app/
├── assets/
│   └── models/
│       └── solar_panel_best_float16.tflite   # Trained YOLOv8 TFLite model
├── lib/
│   ├── models/                                # Diagnostic data and bounding box schemas
│   ├── screens/                               # UI Views (Onboarding, Home, Diagnostic Results)
│   ├── services/                              # Model loaders and TFLite inference routines
│   ├── utils/                                 # Constants and formatting configurations
│   ├── widgets/                               # Custom UI components (camera interface, file pickers)
│   └── main.dart                              # Application initialization entry point
```

---

## Getting Started Locally

### Prerequisites
2. Add the official Flutter SDK to your development machine.
2) Make sure that you have an Android device with Developer Options ON, or an iOS simulator set up.

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com
   cd solar_detection_app
   ```

2. **Fetch development dependencies:**
   ```bash
   flutter pub get
   ```

3. Check targets for deployment devices that are connected:
   ```bash
   flutter devices
   ```

4. Compile and run the program:
   ```bash
   flutter run
   ```

---

The ability to adapt a model, and retrain it.

If you need to change the classification categories and/or change your model architecture:
Organize your data into five categories of data (Clean, Dusty, Electrical Damage, Physical Damage, Slowdown) and train using the Ultralytics YOLOv8 API.
3. Transfer the finalized model weights into the TensorFlow Lite format, with the following script:
   ```python
   from ultralytics import YOLO
   model = YOLO("best.pt")
   model.export(format="tflite", imgsz=640)
   ```
3. Directly place your new “best_float16.tflite” file in the local “assets/models” directory.

---

## Contribution
Any contributions, bug logs or structure pull requests are welcome. Before making changes, please start a tracking issue and discuss your plans with the relevant person.
