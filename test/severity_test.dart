import 'package:flutter_test/flutter_test.dart';
import 'package:fasal_sehat/core/severity.dart';
import 'package:fasal_sehat/core/constants.dart';
import 'package:flutter/material.dart';

void main() {
  group('Severity mapping and contract tests', () {
    test('fromString parses correctly with case insensitivity', () {
      expect(Severity.fromString('healthy'), Severity.healthy);
      expect(Severity.fromString('Mild'), Severity.mild);
      expect(Severity.fromString('SEVERE'), Severity.severe);
      expect(Severity.fromString(null), Severity.mild); // Default fallback
      expect(Severity.fromString('unknown'), Severity.mild);
    });

    test('toDbString outputs exact enum name', () {
      expect(Severity.healthy.toDbString(), 'healthy');
      expect(Severity.mild.toDbString(), 'mild');
      expect(Severity.severe.toDbString(), 'severe');
    });

    test('Each severity has distinct colors and icons', () {
      // Color accessibility verification: healthy is green, mild is amber, severe is red
      expect(Severity.healthy.color, AppColors.primaryGreen);
      expect(Severity.mild.color, AppColors.warningAmber);
      expect(Severity.severe.color, AppColors.alertRed);

      // Icon accessibility verification (never color alone)
      expect(Severity.healthy.icon, Icons.check_circle_rounded);
      expect(Severity.mild.icon, Icons.warning_rounded);
      expect(Severity.severe.icon, Icons.report_problem_rounded);
    });

    test('Text colors provide readable contrast on corresponding backgrounds', () {
      expect(Severity.healthy.backgroundColor, AppColors.paleGreen);
      expect(Severity.healthy.textColor, AppColors.darkGreenText);

      expect(Severity.mild.backgroundColor, AppColors.paleAmber);
      expect(Severity.mild.textColor, AppColors.darkAmberText);

      expect(Severity.severe.backgroundColor, AppColors.paleRed);
      expect(Severity.severe.textColor, AppColors.darkRedText);
    });
  });
}
