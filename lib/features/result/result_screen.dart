import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fasal_sehat/core/constants.dart';
import 'package:fasal_sehat/core/severity.dart';
import 'package:fasal_sehat/l10n/app_localizations.dart';

class ResultScreen extends StatefulWidget {
  final String? imagePath;
  final String diseaseLabel;
  final double confidence;
  final String cropNameEn;
  final String cropNameUr;
  final String diseaseNameEn;
  final String diseaseNameUr;
  final Severity severity;
  final List<Map<String, String>> remediesUr;
  final List<Map<String, String>> remediesEn;

  const ResultScreen({
    super.key,
    this.imagePath,
    this.diseaseLabel = 'Tomato___Early_blight',
    this.confidence = 0.92,
    this.cropNameEn = 'Tomato',
    this.cropNameUr = 'ٹماٹر',
    this.diseaseNameEn = 'Early Blight',
    this.diseaseNameUr = 'پتہ جھلساؤ',
    this.severity = Severity.mild,
    this.remediesUr = const [
      {
        'icon': 'spray',
        'text': 'ہر 7 دن بعد کاپر فنگی سائیڈ کا سپرے کریں',
      },
      {
        'icon': 'water',
        'text': 'زیادہ پانی دینے سے پرہیز کریں اور زمین خشک رکھیں',
      },
      {
        'icon': 'shield',
        'text': 'سپرے کرتے وقت حفاظتی ماسک اور دستانے پہنیں',
      },
    ],
    this.remediesEn = const [
      {
        'icon': 'spray',
        'text': 'Spray copper-based fungicide every 7 days',
      },
      {
        'icon': 'water',
        'text': 'Avoid over-watering and keep soil drained',
      },
      {
        'icon': 'shield',
        'text': 'Wear protective mask and gloves while spraying',
      },
    ],
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isPlayingAudio = false;

  void _toggleAudio() {
    setState(() {
      _isPlayingAudio = !_isPlayingAudio;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isPlayingAudio
              ? (Localizations.localeOf(context).languageCode == 'ur'
                  ? 'آواز کی رہنمائی چل رہی ہے...'
                  : 'Playing voice guidance...')
              : (Localizations.localeOf(context).languageCode == 'ur'
                  ? 'آواز روک دی گئی'
                  : 'Voice guidance paused'),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  IconData _getStepIcon(String? iconType) {
    switch (iconType) {
      case 'spray':
        return Icons.sanitizer_rounded;
      case 'water':
        return Icons.water_drop_rounded;
      case 'shield':
        return Icons.health_and_safety_rounded;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  String _getSeverityText(AppLocalizations l10n, Severity severity) {
    switch (severity) {
      case Severity.healthy:
        return l10n.healthy;
      case Severity.mild:
        return l10n.mild;
      case Severity.severe:
        return l10n.severe;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isUrdu = Localizations.localeOf(context).languageCode == 'ur';
    final cropTitle = isUrdu ? widget.cropNameUr : widget.cropNameEn;
    final diseaseTitle = isUrdu ? widget.diseaseNameUr : widget.diseaseNameEn;
    final steps = isUrdu ? widget.remediesUr : widget.remediesEn;
    final confidencePct = (widget.confidence * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text(isUrdu ? 'تشخیص کا نتیجہ' : 'Diagnosis Result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Preview or Leaf Banner
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: widget.imagePath != null
                  ? (kIsWeb
                      ? Image.network(
                          widget.imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderImage(),
                        )
                      : Image.file(
                          File(widget.imagePath!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderImage(),
                        ))
                  : _buildPlaceholderImage(),
            ),
            const SizedBox(height: 16),

            // Disease Summary Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cropTitle,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: AppColors.primaryGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                diseaseTitle,
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      fontSize: 26,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Severity Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: widget.severity.backgroundColor,
                            borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
                            border: Border.all(
                              color: widget.severity.color.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.severity.icon,
                                size: 18,
                                color: widget.severity.textColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _getSeverityText(l10n, widget.severity),
                                style: TextStyle(
                                  color: widget.severity.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Confidence Bar
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: widget.confidence,
                              backgroundColor: Colors.grey.shade300,
                              color: widget.severity.color,
                              minHeight: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$confidencePct%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Voice guidance button
            Container(
              decoration: BoxDecoration(
                color: AppColors.paleGreen,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(color: AppColors.primaryGreen.withValues(alpha: 0.3)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton.filled(
                    onPressed: _toggleAudio,
                    icon: Icon(
                      _isPlayingAudio ? Icons.pause_rounded : Icons.volume_up_rounded,
                      size: 28,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                        AppDimensions.speakerButtonSize,
                        AppDimensions.speakerButtonSize,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.voiceOutput,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.darkGreenText,
                          ),
                        ),
                        Text(
                          isUrdu
                              ? 'علاج کی ہدایات سننے کے لیے بٹن دبائیں'
                              : 'Tap to listen to remedies audio',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.darkGreenText.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Treatment Steps Title
            Text(
              isUrdu ? 'علاج اور احتیاطی تدابیر' : 'Recommended Treatment',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Treatment Step Cards
            ...steps.map((step) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.paleGreen,
                        child: Icon(
                          _getStepIcon(step['icon']),
                          color: AppColors.primaryGreen,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          step['text'] ?? '',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),

            // Extension Officer Disclaimer Notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade400),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: Colors.amber.shade900),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.consultOfficer,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Retake / Take Another Photo Button
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.camera_alt_rounded),
              label: Text(l10n.takeAnotherPhoto),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.green.shade50,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.energy_savings_leaf_rounded,
              size: 64,
              color: AppColors.primaryGreen.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 8),
            Text(
              Localizations.localeOf(context).languageCode == 'ur'
                  ? 'ٹماٹر کے پتے کا اسکین'
                  : 'Scanned Tomato Leaf',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
