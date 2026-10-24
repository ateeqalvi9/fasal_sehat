import 'package:flutter/material.dart';

/// Design tokens, thresholds, and configuration constants for Fasal Sehat.
/// All values strictly follow the Master Prompt specifications.
class AppColors {
  AppColors._();

  // Primary palette
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color warningAmber = Color(0xFFF9A825);
  static const Color alertRed = Color(0xFFC62828);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFFAFAF7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cameraBg = Color(0xFF1B1B1B);

  // Text tokens
  static const Color textPrimary = Color(0xFF1B1B1B);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textLight = Color(0xFFFFFFFF);

  // Accessible container colors (never white text on amber)
  static const Color paleGreen = Color(0xFFE8F5E9);
  static const Color darkGreenText = Color(0xFF1B5E20);

  static const Color paleAmber = Color(0xFFFFF1D6);
  static const Color darkAmberText = Color(0xFF7A4A00);

  static const Color paleRed = Color(0xFFFFEBEE);
  static const Color darkRedText = Color(0xFFB71C1C);
}

class AppDimensions {
  AppDimensions._();

  // Tap targets (low-literacy & one-handed outdoor usage)
  static const double minTouchTarget = 48.0;
  static const double primaryButtonHeight = 56.0;
  static const double speakerButtonSize = 56.0;
  static const double giantCameraButtonMinSize = 140.0;

  // Radii
  static const double cardRadius = 16.0;
  static const double buttonRadius = 28.0;
  static const double badgeRadius = 20.0;

  // History thumbnail size (bounds memory on low-end 2GB RAM phones)
  static const double historyThumbSize = 96.0;
}

class AppThresholds {
  AppThresholds._();

  /// Confidence >= 0.80 -> Confident Diagnosis
  static const double confidentThreshold = 0.80;

  /// Confidence 0.50..0.80 -> `Probably <Disease>` (retake recommended)
  static const double probableThreshold = 0.50;

  /// Class name representing non-crop / non-leaf images
  static const String notALeafClass = 'not_a_leaf';

  /// Maximum stored scans to bound device storage
  static const int maxHistoryEntries = 200;
}

class AppModelConfig {
  AppModelConfig._();

  static const String modelAssetPath = 'assets/model/crop_model.tflite';
  static const String labelsAssetPath = 'assets/model/labels.txt';
  static const String remediesAssetPath = 'assets/data/remedies.json';

  // Input tensor specifications
  static const int inputSize = 224;
  static const int inputChannels = 3;

  // MobileNetV2 standard normalisation: (pixel / 127.5) - 1.0 -> [-1.0, 1.0]
  static const double normMean = 127.5;
  static const double normStd = 127.5;
}
