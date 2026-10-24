import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fasal_sehat/core/constants.dart';
import 'package:fasal_sehat/core/severity.dart';
import 'package:fasal_sehat/features/result/result_screen.dart';
import 'package:fasal_sehat/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onNavigateToHistory;

  const HomeScreen({
    super.key,
    this.onNavigateToHistory,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);
      final XFile? photo = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (photo != null && mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              imagePath: photo.path,
              diseaseLabel: 'Tomato___Early_blight',
              confidence: 0.94,
              cropNameEn: 'Tomato',
              cropNameUr: 'ٹماٹر',
              diseaseNameEn: 'Early Blight',
              diseaseNameUr: 'پتہ جھلساؤ',
              severity: Severity.mild,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error selecting image: $e'),
            backgroundColor: AppColors.alertRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openDemoResult() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ResultScreen(
          diseaseLabel: 'Tomato___Early_blight',
          confidence: 0.92,
          cropNameEn: 'Tomato',
          cropNameUr: 'ٹماٹر',
          diseaseNameEn: 'Early Blight',
          diseaseNameUr: 'پتہ جھلساؤ',
          severity: Severity.mild,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appNameUrdu),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off_rounded, size: 16, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  isUrdu ? 'آف لائن' : 'Offline',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.primaryGreen),
                  const SizedBox(height: 16),
                  Text(
                    l10n.checking,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero Card
                  Card(
                    elevation: 2,
                    color: AppColors.paleGreen,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.eco_rounded,
                            size: 64,
                            color: AppColors.primaryGreen,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.appNameUrdu,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: AppColors.darkGreenText,
                                  fontSize: 28,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.worksOffline,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.darkGreenText.withValues(alpha: 0.9),
                                  fontWeight: FontWeight.w600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Giant Scan / Take Photo Button
                  SizedBox(
                    height: AppDimensions.primaryButtonHeight + 8,
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt_rounded, size: 28),
                      label: Text(
                        l10n.takePhoto,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Pick from Gallery Button
                  SizedBox(
                    height: AppDimensions.primaryButtonHeight,
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_rounded, size: 24),
                      label: Text(
                        isUrdu ? 'گیلری سے تصویر منتخب کریں' : 'Choose from Gallery',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Demo Scan Button (Quick Result navigation without camera)
                  TextButton.icon(
                    onPressed: _openDemoResult,
                    icon: const Icon(Icons.visibility_rounded, color: AppColors.primaryGreen),
                    label: Text(
                      isUrdu
                          ? 'تشخیص کا نمونہ دیکھیں (Demo Result)'
                          : 'View Sample Diagnosis Result',
                      style: const TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Photography Tips Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.lightbulb_outline_rounded,
                                color: AppColors.warningAmber,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isUrdu ? 'بہترین نتائج کے لیے ہدایات' : 'Tips for Best Results',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildTipRow(Icons.crop_free_rounded, l10n.tipSingleLeaf),
                          const SizedBox(height: 8),
                          _buildTipRow(Icons.wallpaper_rounded, l10n.tipPlainBg),
                          const SizedBox(height: 8),
                          _buildTipRow(Icons.wb_sunny_outlined, l10n.tipDaylight),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTipRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryGreen),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
