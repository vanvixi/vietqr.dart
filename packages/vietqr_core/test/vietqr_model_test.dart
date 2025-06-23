import 'package:test/test.dart';
import 'package:vietqr_core/vietqr_core.dart';

void main() {
  group('Valid Data Creation', () {
    test('should create valid VietQrData with minimal required fields', () {
      // Arrange & Act
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
      );

      // Assert
      expect(data.version, equals('01'));
      expect(data.initiationMethod, equals('12')); // Dynamic QR (no amount)
      expect(
        data.merchantAccInfo.beneficiaryOrgData.bankBinCode,
        equals('970436'),
      );
      expect(
        data.merchantAccInfo.beneficiaryOrgData.bankAccount,
        equals('1234567890'),
      );
      expect(data.currency, equals('704')); // VND
      expect(data.amount, isEmpty);
      expect(data.countryCode, equals('VN'));
    });

    test('should create static QR when amount is provided', () {
      // Arrange & Act
      final data = VietQrData(
        bankBinCode: SupportedBank.bidv,
        bankAccount: '9876543210',
        amount: '50000',
      );

      // Assert
      expect(data.initiationMethod, equals('11')); // Static QR (with amount)
      expect(data.amount, equals('50000'));
    });

    test('should create VietQrData with all optional fields', () {
      // Arrange & Act
      final data = VietQrData(
        version: VietQrVersion.v_01,
        bankBinCode: SupportedBank.techcombank,
        bankAccount: '1111222233334444',
        serviceCode: VietQrService.accountNumber,
        merchantCategory: '5812',
        currency: VietQrCurrency.vnd,
        amount: '100000',
        tipOrConvenience: '01',
        countryCode: 'VN',
        merchantName: 'Test Merchant',
        merchantCity: 'Ho Chi Minh',
        postalCode: '700000',
        additional: const AdditionalData(purpose: 'Test payment'),
      );

      // Assert
      expect(data.version, equals('01'));
      expect(
        data.merchantAccInfo.beneficiaryOrgData.bankBinCode,
        equals('970407'),
      );
      expect(
        data.merchantAccInfo.beneficiaryOrgData.bankAccount,
        equals('1111222233334444'),
      );
      expect(data.merchantCategory, equals('5812'));
      expect(data.amount, equals('100000'));
      expect(data.tipOrConvenience, equals('01'));
      expect(data.merchantName, equals('Test Merchant'));
      expect(data.merchantCity, equals('Ho Chi Minh'));
      expect(data.postalCode, equals('700000'));
      expect(data.additional.purpose, equals('Test payment'));
    });

    test('should create VietQrData with custom constructor', () {
      // Arrange
      final merchantAccInfo = MerchantAccountInfoData(
        bankBinCode: SupportedBank.mbbank,
        bankAccount: '5555666677778888',
        serviceCode: VietQrService.accountNumber,
      );

      // Act
      final data = VietQrData.custom(
        merchantAccInfo: merchantAccInfo,
        amount: '75000',
        merchantName: 'Custom Merchant',
      );

      // Assert
      expect(
        data.merchantAccInfo.beneficiaryOrgData.bankBinCode,
        equals('970422'),
      );
      expect(
        data.merchantAccInfo.beneficiaryOrgData.bankAccount,
        equals('5555666677778888'),
      );
      expect(data.amount, equals('75000'));
      expect(data.merchantName, equals('Custom Merchant'));
    });
  });

  group('Field Validation Tests', () {
    test('should throw InvalidLengthException for invalid version length', () {
      // Arrange
      final data = VietQrData.custom(
        version: '1', // Invalid: should be 2 characters
        merchantAccInfo: MerchantAccountInfoData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          serviceCode: VietQrService.accountNumber,
        ),
      );

      // Act & Assert
      expect(() => data.validate(), throwsA(isA<InvalidLengthException>()));
    });

    test('should validate globalUid length correctly', () {
      // Arrange & Act
      final data = VietQrData.custom(
        merchantAccInfo: MerchantAccountInfoData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          serviceCode: VietQrService.accountNumber,
        ),
      );

      // Act & Assert
      expect(() => data.validate(), returnsNormally);
      expect(data.merchantAccInfo.globalUid, equals('A000000727'));
      expect(
        data.initiationMethod,
        equals('12'),
      ); // Dynamic QR for empty amount
    });

    test(
      'should throw InvalidLengthException for invalid merchant category length',
      () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          merchantCategory: '58', // Invalid: should be 4 characters if provided
        );

        // Act & Assert
        expect(() => data.validate(), throwsA(isA<InvalidLengthException>()));
      },
    );

    test('should throw InvalidLengthException for invalid currency length', () {
      // Arrange
      final testData = VietQrData.custom(
        currency: '70', // Invalid: should be 3 characters
        merchantAccInfo: MerchantAccountInfoData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          serviceCode: VietQrService.accountNumber,
        ),
      );

      // Act & Assert
      expect(() => testData.validate(), throwsA(isA<InvalidLengthException>()));
    });

    test(
      'should throw InvalidLengthException for invalid country code length',
      () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          countryCode: 'VNM', // Invalid: should be 2 characters
        );

        // Act & Assert
        expect(() => data.validate(), throwsA(isA<InvalidLengthException>()));
      },
    );

    test('should throw MaxLengthExceededCharException for too long amount', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        amount: '12345678901234', // 14 characters, exceeds max of 13
      );

      // Act & Assert
      expect(
        () => data.validate(),
        throwsA(isA<MaxLengthExceededCharException>()),
      );
    });

    test('should throw InvalidDataException for invalid amount format', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        amount: 'abc123', // Invalid: not a number
      );

      // Act & Assert
      expect(() => data.validate(), throwsA(isA<InvalidDataException>()));
    });

    test('should throw InvalidDataException for negative amount', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        amount: '-1000', // Invalid: negative amount
      );

      // Act & Assert
      expect(() => data.validate(), throwsA(isA<InvalidDataException>()));
    });

    test('should throw InvalidDataException for zero amount', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        amount: '0', // Invalid: zero amount
      );

      // Act & Assert
      expect(() => data.validate(), throwsA(isA<InvalidDataException>()));
    });

    test(
      'should throw MaxLengthExceededCharException for too long merchant name',
      () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          merchantName: 'A' * 26, // 26 characters, exceeds max of 25
        );

        // Act & Assert
        expect(
          () => data.validate(),
          throwsA(isA<MaxLengthExceededCharException>()),
        );
      },
    );

    test(
      'should throw MaxLengthExceededCharException for too long merchant city',
      () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          merchantCity: 'A' * 16, // 16 characters, exceeds max of 15
        );

        // Act & Assert
        expect(
          () => data.validate(),
          throwsA(isA<MaxLengthExceededCharException>()),
        );
      },
    );

    test(
      'should throw MaxLengthExceededCharException for too long postal code',
      () {
        // Arrange
        final data = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          postalCode: '12345678901', // 11 characters, exceeds max of 10
        );

        // Act & Assert
        expect(
          () => data.validate(),
          throwsA(isA<MaxLengthExceededCharException>()),
        );
      },
    );
  });

  group('Convenience Fee Validation Tests', () {
    test('should validate fixed fee when tip indicator is 02', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        tipOrConvenience: '02', // Fixed fee
        feeFixed: '5000',
      );

      // Act & Assert
      expect(() => data.validate(), returnsNormally);
    });

    test('should validate percentage fee when tip indicator is 03', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        tipOrConvenience: '03', // Percentage fee
        feePercentage: '2.5',
      );

      // Act & Assert
      expect(() => data.validate(), returnsNormally);
    });

    test(
      'should throw InvalidLengthException for invalid tip indicator length',
      () {
        // Arrange
        final testData = VietQrData.custom(
          tipOrConvenience: '1', // Invalid: should be 2 characters
          merchantAccInfo: MerchantAccountInfoData(
            bankBinCode: SupportedBank.vietcombank,
            bankAccount: '1234567890',
            serviceCode: VietQrService.accountNumber,
          ),
        );

        // Act & Assert
        expect(
          () => testData.validate(),
          throwsA(isA<InvalidLengthException>()),
        );
      },
    );

    test(
      'should throw InvalidDataException for invalid tip indicator value',
      () {
        // Arrange
        final testData = VietQrData.custom(
          tipOrConvenience: '04', // Invalid: should be 01, 02, or 03
          merchantAccInfo: MerchantAccountInfoData(
            bankBinCode: SupportedBank.vietcombank,
            bankAccount: '1234567890',
            serviceCode: VietQrService.accountNumber,
          ),
        );

        // Act & Assert
        expect(() => testData.validate(), throwsA(isA<InvalidDataException>()));
      },
    );
  });

  group('Empty Field Handling', () {
    test('should allow empty optional fields', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        merchantCategory: '',
        // Empty optional field
        merchantName: '',
        // Empty optional field
        merchantCity: '',
        // Empty optional field
        postalCode: '', // Empty optional field
      );

      // Act & Assert
      expect(() => data.validate(), returnsNormally);
      expect(data.merchantCategory, isEmpty);
      expect(data.merchantName, isEmpty);
      expect(data.merchantCity, isEmpty);
      expect(data.postalCode, isEmpty);
    });

    test('should handle empty amount correctly', () {
      // Arrange
      final data = VietQrData(
        bankBinCode: SupportedBank.vietcombank,
        bankAccount: '1234567890',
        amount: '', // Empty amount should not trigger validation
      );

      // Act & Assert
      expect(() => data.validate(), returnsNormally);
      expect(data.amount, isEmpty);
      expect(
        data.initiationMethod,
        equals('12'),
      ); // Dynamic QR for empty amount
    });
  });
}
