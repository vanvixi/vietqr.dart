import 'package:vietqr_core/vietqr_core.dart';

class TestUtils {
  TestUtils._();
  // Example 1: Basic VietQR payment with amount
  static basicVietQR() {
    final basicPayment = VietQrData(
      bankBinCode: SupportedBank.vietcombank,
      bankAccount: '0123456789',
      amount: '50000',
      merchantName: 'John Doe',
      merchantCity: 'Ho Chi Minh City',
      additional: const AdditionalData(purpose: 'Payment for invoice #12345'),
    );

    final basicQrString = VietQr.encode(basicPayment);
    print('Basic Payment QR: $basicQrString');
    print('');
  }

  // Example 2: Dynamic QR (no amount - user enters amount when scanning)
  static dynamicPayment() {
    final dynamicPayment = VietQrData(
      bankBinCode: SupportedBank.techcombank,
      bankAccount: '9876543210',
      merchantName: 'Coffee Shop ABC',
      merchantCity: 'Hanoi',
      additional: const AdditionalData(
        purpose: 'Coffee payment',
        storeLabel: 'Store #001',
      ),
    );

    final dynamicQrString = VietQr.encode(dynamicPayment);
    print('Dynamic Payment QR: $dynamicQrString');
    print('');
  }
  // Example 3: Payment with additional data

  static detailedPayment() {
    final detailedPayment = VietQrData(
      bankBinCode: SupportedBank.bidv,
      bankAccount: '1122334455',
      amount: '100000',
      merchantName: 'Restaurant XYZ',
      merchantCity: 'Da Nang',
      postalCode: '550000',
      additional: const AdditionalData(
        purpose: 'Dinner payment',
        billNumber: 'BILL-2024-001',
        mobileNumber: '0912345678',
        storeLabel: 'Main Branch',
        customerLabel: 'VIP Customer',
      ),
    );

    final detailedQrString = VietQr.encode(detailedPayment);
    print('Detailed Payment QR: $detailedQrString');
    print('');
  }
  // Example 4: Encode and Decode demo

  static originalData() {
    final originalData = VietQrData(
      bankBinCode: SupportedBank.mbbank,
      bankAccount: '5566778899',
      amount: '25000',
      merchantName: 'Online Store',
      additional: const AdditionalData(
        purpose: 'Online purchase',
        referenceLabel: 'ORDER-789',
      ),
    );

    // Encode to QR string
    final encodedQrString = VietQr.encode(originalData);
    print('Encoded QR: $encodedQrString');

    // Decode back to VietQrData
    final decodedData = VietQr.decode(encodedQrString);
    print(
      'Decoded Bank: ${SupportedBank.fromBinCode(decodedData.merchantAccInfo.beneficiaryOrgData.bankBinCode)?.displayName}',
    );
    print(
      'Decoded Account: ${decodedData.merchantAccInfo.beneficiaryOrgData.bankAccount}',
    );
    print('Decoded Amount: ${decodedData.amount}');
    print('Decoded Purpose: ${decodedData.additional.purpose}');
    print('');
  }
  // Example 5: Different banks demonstration

  static different() {
    final banks = [
      SupportedBank.vietinbank,
      SupportedBank.agribank,
      SupportedBank.acb,
      SupportedBank.vpbank,
    ];

    print('Multi-bank QR generation:');
    for (final bank in banks) {
      final payment = VietQrData(
        bankBinCode: bank,
        bankAccount: '1234567890',
        amount: '10000',
        merchantName: 'Multi-bank Demo',
        additional: AdditionalData(purpose: 'Payment via ${bank.displayName}'),
      );

      final qrString = VietQr.encode(payment);
      print('${bank.displayName}: ${qrString.substring(0, 50)}...');
    }
  }
}
