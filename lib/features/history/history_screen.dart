import 'package:flutter/material.dart';
import 'package:fasal_sehat/core/constants.dart';
import 'package:fasal_sehat/core/severity.dart';
import 'package:fasal_sehat/features/result/result_screen.dart';
import 'package:fasal_sehat/l10n/app_localizations.dart';

class HistoryItem {
  final String id;
  final String cropNameEn;
  final String cropNameUr;
  final String diseaseNameEn;
  final String diseaseNameUr;
  final Severity severity;
  final double confidence;
  final DateTime timestamp;

  const HistoryItem({
    required this.id,
    required this.cropNameEn,
    required this.cropNameUr,
    required this.diseaseNameEn,
    required this.diseaseNameUr,
    required this.severity,
    required this.confidence,
    required this.timestamp,
  });
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Initial demo records to let farmers / evaluators see history in action
  final List<HistoryItem> _items = [
    HistoryItem(
      id: '1',
      cropNameEn: 'Tomato',
      cropNameUr: 'ٹماٹر',
      diseaseNameEn: 'Early Blight',
      diseaseNameUr: 'پتہ جھلساؤ',
      severity: Severity.mild,
      confidence: 0.92,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HistoryItem(
      id: '2',
      cropNameEn: 'Tomato',
      cropNameUr: 'ٹماٹر',
      diseaseNameEn: 'Healthy Leaf',
      diseaseNameUr: 'صحت مند پتہ',
      severity: Severity.healthy,
      confidence: 0.98,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.history),
      ),
      body: _items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.history_toggle_off_rounded,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.emptyHistoryTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey.shade700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.emptyHistoryDesc,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final crop = isUrdu ? item.cropNameUr : item.cropNameEn;
                final disease = isUrdu ? item.diseaseNameUr : item.diseaseNameEn;
                final conf = (item.confidence * 100).toInt();

                return Dismissible(
                  key: Key(item.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.alertRed,
                      borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                    ),
                    child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
                  ),
                  onDismissed: (_) => _deleteItem(index),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ResultScreen(
                              cropNameEn: item.cropNameEn,
                              cropNameUr: item.cropNameUr,
                              diseaseNameEn: item.diseaseNameEn,
                              diseaseNameUr: item.diseaseNameUr,
                              confidence: item.confidence,
                              severity: item.severity,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Thumbnail / Severity circle
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: item.severity.backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item.severity.icon,
                                color: item.severity.textColor,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$crop - $disease',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.severity.name.toUpperCase()} • $conf%',
                                    style: TextStyle(
                                      color: item.severity.textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
