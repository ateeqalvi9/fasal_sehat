import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fasal_sehat/app.dart';

void main() {
  testWidgets('App renders Home with navigation and buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const FasalSehatApp());
    await tester.pumpAndSettle();

    // Verify Urdu title renders
    expect(find.text('فصل صحت'), findsWidgets);

    // Verify Navigation bar tabs exist
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('مرکزی صفحہ'), findsWidgets);
    expect(find.text('ریکارڈ'), findsOneWidget);
    expect(find.text('ترتیبات'), findsOneWidget);

    // Verify Take Photo & Gallery buttons exist
    expect(find.text('تصویر لیں'), findsOneWidget);
  });

  testWidgets('Switch tabs via NavigationBar', (WidgetTester tester) async {
    await tester.pumpWidget(const FasalSehatApp());
    await tester.pumpAndSettle();

    // Tap on History tab ('ریکارڈ')
    await tester.tap(find.text('ریکارڈ'));
    await tester.pumpAndSettle();
    expect(find.text('ٹماٹر - پتہ جھلساؤ'), findsOneWidget);

    // Tap on Settings tab ('ترتیبات')
    await tester.tap(find.text('ترتیبات'));
    await tester.pumpAndSettle();
    expect(find.text('اردو (Urdu)'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
  });

  testWidgets('Navigate to Result Screen via Demo button', (WidgetTester tester) async {
    await tester.pumpWidget(const FasalSehatApp());
    await tester.pumpAndSettle();

    // Tap the demo result button
    final demoBtn = find.text('تشخیص کا نمونہ دیکھیں (Demo Result)');
    expect(demoBtn, findsOneWidget);
    await tester.tap(demoBtn);
    await tester.pumpAndSettle();

    // Verify result screen rendered
    expect(find.text('تشخیص کا نتیجہ'), findsOneWidget);
    expect(find.text('علاج اور احتیاطی تدابیر'), findsOneWidget);
  });
}
