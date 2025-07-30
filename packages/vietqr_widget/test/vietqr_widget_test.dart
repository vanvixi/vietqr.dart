import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vietqr_widget/vietqr_widget.dart';

void main() {
  group('VietQrWidget Tests', () {
    testWidgets('VietQrWidget renders without error', (WidgetTester tester) async {
      final vietQrData = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '0123456789',
        amount: '50000',
        merchantName: 'Test Merchant',
        additional: const AdditionalData(purpose: 'Test payment'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VietQrWidget(
              data: vietQrData,
            ),
          ),
        ),
      );

      expect(find.byType(VietQrWidget), findsOneWidget);
    });

    testWidgets('VietQrWidget shows error builder on invalid data', (WidgetTester tester) async {
      final invalidData = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VietQrWidget(
              data: invalidData,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Custom Error');
              },
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Custom Error'), findsOneWidget);
    });
  });
}
