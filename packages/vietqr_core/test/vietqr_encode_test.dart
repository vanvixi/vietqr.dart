import 'package:test/test.dart';
import 'package:vietqr_core/src/core/vietqr_encoder.dart';
import 'package:vietqr_core/vietqr_core.dart';

void main() {
  group('VietQrEncoder Tests', () {
    group('QR Generation Tests', () {
      test('should generate valid QR string for minimal data', () {
        // Arrange
        final data = VietQrData(bankBinCode: SupportedBank.vietcombank, bankAccount: '1234567890');

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, isNotEmpty);
        expect(qrString.length, greaterThan(50)); // Minimum QR string length
        expect(qrString, startsWith('0002')); // Version field
        expect(qrString, contains('01')); // Initiation method field
        expect(qrString, contains('38')); // Merchant account info field
        expect(qrString, contains('5303704')); // Currency field (VND)
        expect(qrString, contains('5802VN')); // Country code field
        expect(qrString, matches(RegExp(r'.*[0-9A-F]{4}$'))); // CRC checksum
      });

      test('should generate QR string with amount for static QR', () {
        // Arrange
        final data = VietQrData(bankBinCode: SupportedBank.bidv, bankAccount: '9876543210', amount: '50000');

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('0211')); // Static QR initiation method
        expect(qrString, contains('540550000')); // Amount field
      });

      test('should generate QR string with merchant information', () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.techcombank,
          bankAccount: '1111222233334444',
          amount: '100000',
          merchantName: 'Test Merchant',
          merchantCity: 'Ho Chi Minh',
          postalCode: '700000',
        );

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('5913Test Merchant')); // Merchant name field
        expect(qrString, contains('6011Ho Chi Minh')); // Merchant city field
        expect(qrString, contains('6106700000')); // Postal code field
      });

      test('should generate QR string with additional data', () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          additional: const AdditionalData(purpose: 'Payment', mobileNumber: '0123456789', billNumber: 'INV001'),
        );

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('62')); // Additional data field
        expect(qrString, contains('0807Payment')); // Purpose field
        expect(qrString, contains('02100123456789')); // Mobile number field
        expect(qrString, contains('0106INV001')); // Bill number field
      });

      test('should generate QR string with convenience fees', () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.mbbank,
          bankAccount: '5555666677778888',
          amount: '75000',
          tipOrConvenience: '02',
          // Fixed fee
          feeFixed: '2500',
        );

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('5502')); // Tip/convenience indicator
        expect(qrString, contains('56042500')); // Fixed fee value
      });

      test('should generate QR string with percentage fee', () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.acb,
          bankAccount: '9999888877776666',
          amount: '150000',
          tipOrConvenience: '03',
          // Percentage fee
          feePercentage: '1.5',
        );

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('550203')); // Tip/convenience indicator
        expect(qrString, contains('57031.5')); // Percentage fee value
      });
    });

    group('CRC Checksum Tests', () {
      test('should generate valid CRC checksum', () {
        // Arrange
        final data = VietQrData(bankBinCode: SupportedBank.vietcombank, bankAccount: '1234567890');

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);
        final checksum = qrString.substring(qrString.length - 4);

        // Assert
        expect(checksum, hasLength(4));
        expect(checksum, matches(RegExp(r'^[0-9A-F]{4}$')));
      });

      test('should generate different checksums for different data', () {
        // Arrange
        final data1 = VietQrData(bankBinCode: SupportedBank.vietcombank, bankAccount: '1234567890');
        final data2 = VietQrData(bankBinCode: SupportedBank.bidv, bankAccount: '9876543210');

        // Act
        final qrString1 = VietQrEncoder.encodePaymentQr(data1);
        final qrString2 = VietQrEncoder.encodePaymentQr(data2);

        final checksum1 = qrString1.substring(qrString1.length - 4);
        final checksum2 = qrString2.substring(qrString2.length - 4);

        // Assert
        expect(checksum1, isNot(equals(checksum2)));
      });
    });

    group('Field Encoding Tests', () {
      test('should encode bank BIN code correctly', () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank, // BIN: 970436
          bankAccount: '1234567890',
        );

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('970436')); // Bank BIN code should be present
      });

      test('should encode service code when provided', () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.techcombank,
          bankAccount: '1111222233334444',
          serviceCode: VietQrService.accountNumber,
        );

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('QRIBFTTA')); // Service code should be present
      });

      test('should encode merchant category when provided', () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          merchantCategory: '5812', // Restaurant category
        );

        // Act
        final qrString = VietQrEncoder.encodePaymentQr(data);

        // Assert
        expect(qrString, contains('52045812')); // Merchant category field
      });
    });

    group('Error Handling Tests', () {
      test('should throw exception for invalid data during encoding', () {
        // Arrange
        final invalidData = VietQrData.custom(
          version: '1', // Invalid version length
          merchantAccInfo: MerchantAccountInfoData(
            bankBinCode: SupportedBank.vietcombank,
            bankAccount: '1234567890',
            serviceCode: VietQrService.accountNumber,
          ),
        );

        // Act & Assert
        expect(() => VietQrEncoder.encodePaymentQr(invalidData), throwsA(isA<InvalidLengthException>()));
      });
    });
  });

  group('Integration Tests', () {
    test('should create and encode complete VietQR payment', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890123456',
        amount: '250000',
        merchantName: 'Coffee Shop ABC',
        merchantCity: 'Ha Noi',
        additional: const AdditionalData(purpose: 'Coffee order #123', mobileNumber: '0987654321'),
      );

      // Act
      expect(() => data.validate(), returnsNormally);
      final qrString = VietQrEncoder.encodePaymentQr(data);

      // Assert
      expect(qrString, isNotEmpty);
      expect(qrString.length, greaterThan(100));
      expect(qrString, contains('970436')); // Vietcombank BIN
      expect(qrString, contains('1234567890123456')); // Account number
      expect(qrString, contains('250000')); // Amount
      expect(qrString, contains('Coffee Shop ABC')); // Merchant name
      expect(qrString, contains('Ha Noi')); // Merchant city
      expect(qrString, matches(RegExp(r'.*[0-9A-F]{4}$'))); // Valid CRC
    });

    test('should work with all supported banks', () {
      // Arrange & Act & Assert
      for (final bank in SupportedBank.values) {
        final data = VietQrData(bankBinCode: bank, bankAccount: '1234567890', amount: '10000');

        expect(() => data.validate(), returnsNormally);
        final qrString = VietQrEncoder.encodePaymentQr(data);

        expect(qrString, isNotEmpty);
        expect(qrString, contains(bank.binCode));
      }
    });
  });
}
