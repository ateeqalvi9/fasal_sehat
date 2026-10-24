import 'package:flutter/material.dart';
import 'package:fasal_sehat/core/constants.dart';

/// Single source of truth for disease severity mapping across the app.
/// Meets accessibility rules: Never relies on colour alone; always pairs
/// color with an unmistakable icon and text.
enum Severity {
  healthy,
  mild,
  severe;

  static Severity fromString(String? val) {
    switch (val?.trim().toLowerCase()) {
      case 'healthy':
        return Severity.healthy;
      case 'mild':
        return Severity.mild;
      case 'severe':
        return Severity.severe;
      default:
        return Severity.mild;
    }
  }

  String toDbString() => name;

  Color get color {
    switch (this) {
      case Severity.healthy:
        return AppColors.primaryGreen;
      case Severity.mild:
        return AppColors.warningAmber;
      case Severity.severe:
        return AppColors.alertRed;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case Severity.healthy:
        return AppColors.paleGreen;
      case Severity.mild:
        return AppColors.paleAmber;
      case Severity.severe:
        return AppColors.paleRed;
    }
  }

  Color get textColor {
    switch (this) {
      case Severity.healthy:
        return AppColors.darkGreenText;
      case Severity.mild:
        return AppColors.darkAmberText;
      case Severity.severe:
        return AppColors.darkRedText;
    }
  }

  IconData get icon {
    switch (this) {
      case Severity.healthy:
        return Icons.check_circle_rounded;
      case Severity.mild:
        return Icons.warning_rounded;
      case Severity.severe:
        return Icons.report_problem_rounded;
    }
  }
}
