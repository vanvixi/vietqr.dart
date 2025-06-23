import 'package:test/test.dart';
import 'package:vietqr_core/src/const/supported_bank.dart';
import 'package:vietqr_core/src/core/vietqr_decoder.dart';
import 'package:vietqr_core/src/core/vietqr_encoder.dart';
import 'package:vietqr_core/src/exceptions/vietqr_exceptions.dart';
import 'package:vietqr_core/src/models/additional_data.dart';
import 'package:vietqr_core/src/models/vietqr_data.dart';

void main() {
  group('VietQrDecoder', () {
    group('decodePaymentQr', () {
      test('should decode basic VietQR successfully', () {
        // Arrange: Create VietQR data and encode it
        final originalData = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          amount: '50000',
          merchantName: 'Test Merchant',
          merchantCity: 'Ho Chi Minh',
        );
        final encodedQr = VietQrEncoder.encodePaymentQr(originalData);

        // Act: Decode the QR string back to data
        final decodedData = VietQrDecoder.decodePaymentQr(encodedQr);

        // Assert: Verify all fields match
        expect(decodedData.version, equals(originalData.version));
        expect(
          decodedData.initiationMethod,
          equals(originalData.initiationMethod),
        );
        expect(
          decodedData.merchantAccInfo.beneficiaryOrgData.bankBinCode,
          equals(originalData.merchantAccInfo.beneficiaryOrgData.bankBinCode),
        );
        expect(
          decodedData.merchantAccInfo.beneficiaryOrgData.bankAccount,
          equals(originalData.merchantAccInfo.beneficiaryOrgData.bankAccount),
        );
        expect(decodedData.currency, equals(originalData.currency));
        expect(decodedData.amount, equals(originalData.amount));
        expect(decodedData.merchantName, equals(originalData.merchantName));
        expect(decodedData.merchantCity, equals(originalData.merchantCity));
        expect(decodedData.countryCode, equals(originalData.countryCode));
      });

      test('should decode VietQR with additional data successfully', () {
        // Arrange: Create VietQR data with additional information
        final additionalData = AdditionalData(
          purpose: 'Payment for services',
          billNumber: 'BILL001',
          mobileNumber: '0901234567',
          storeLabel: 'Main Store',
        );
        final originalData = VietQrData(
          bankBinCode: SupportedBank.bidv,
          bankAccount: '9876543210',
          amount: '100000',
          merchantName: 'Store ABC',
          merchantCity: 'Ha Noi',
          postalCode: '100000',
          additional: additionalData,
        );
        final encodedQr = VietQrEncoder.encodePaymentQr(originalData);

        // Act: Decode the QR string
        final decodedData = VietQrDecoder.decodePaymentQr(encodedQr);

        // Assert: Verify additional data fields
        expect(decodedData.additional.purpose, equals(additionalData.purpose));
        expect(
          decodedData.additional.billNumber,
          equals(additionalData.billNumber),
        );
        expect(
          decodedData.additional.mobileNumber,
          equals(additionalData.mobileNumber),
        );
        expect(
          decodedData.additional.storeLabel,
          equals(additionalData.storeLabel),
        );
        expect(decodedData.postalCode, equals(originalData.postalCode));
      });

      test('should decode dynamic QR (no amount) successfully', () {
        // Arrange: Create dynamic QR without amount
        final originalData = VietQrData(
          bankBinCode: SupportedBank.techcombank,
          bankAccount: '5555666677',
          merchantName: 'Dynamic Store',
          merchantCity: 'Da Nang',
        );
        final encodedQr = VietQrEncoder.encodePaymentQr(originalData);

        // Act: Decode the QR string
        final decodedData = VietQrDecoder.decodePaymentQr(encodedQr);

        // Assert: Verify it's a dynamic QR (no amount)
        expect(decodedData.amount, isEmpty);
        expect(decodedData.initiationMethod, equals('12')); // Dynamic QR
        expect(
          decodedData.merchantAccInfo.beneficiaryOrgData.bankAccount,
          equals(originalData.merchantAccInfo.beneficiaryOrgData.bankAccount),
        );
      });

      test('should handle minimal VietQR data', () {
        // Arrange: Create minimal VietQR data
        final originalData = VietQrData(
          bankBinCode: SupportedBank.vietinbank,
          bankAccount: '1111222233',
        );
        final encodedQr = VietQrEncoder.encodePaymentQr(originalData);

        // Act: Decode the QR string
        final decodedData = VietQrDecoder.decodePaymentQr(encodedQr);

        // Assert: Verify required fields are present
        expect(decodedData.version, isNotEmpty);
        expect(
          decodedData.merchantAccInfo.beneficiaryOrgData.bankBinCode,
          isNotEmpty,
        );
        expect(
          decodedData.merchantAccInfo.beneficiaryOrgData.bankAccount,
          equals(originalData.merchantAccInfo.beneficiaryOrgData.bankAccount),
        );
        expect(decodedData.currency, isNotEmpty);
        expect(decodedData.countryCode, isNotEmpty);
      });

      test('should throw exception for empty QR string', () {
        // Arrange
        const emptyQr = '';

        // Act & Assert
        expect(
          () => VietQrDecoder.decodePaymentQr(emptyQr),
          throwsA(isA<InvalidDataException>()),
        );
      });

      test('should throw exception for invalid checksum', () {
        // Arrange: Create valid QR and corrupt the checksum
        final originalData = VietQrData(
          bankBinCode: SupportedBank.vietcombank,
          bankAccount: '1234567890',
          amount: '50000',
        );
        final validQr = VietQrEncoder.encodePaymentQr(originalData);
        final corruptedQr = validQr.substring(0, validQr.length - 4) + 'XXXX';

        // Act & Assert
        expect(
          () => VietQrDecoder.decodePaymentQr(corruptedQr),
          throwsA(isA<InvalidDataException>()),
        );
      });

      test('should throw exception for QR string too short for checksum', () {
        // Arrange
        const shortQr = '123';

        // Act & Assert
        expect(
          () => VietQrDecoder.decodePaymentQr(shortQr),
          throwsA(isA<InvalidDataException>()),
        );
      });

      test('should throw exception for malformed TLV fields', () {
        // Arrange: Create QR with invalid TLV structure
        const malformedQr = '001201380063041234'; // Incomplete TLV

        // Act & Assert
        expect(
          () => VietQrDecoder.decodePaymentQr(malformedQr),
          throwsA(isA<InvalidDataException>()),
        );
      });

      test('should throw exception for invalid field length in TLV', () {
        // Arrange: Create QR with invalid length field
        const invalidLengthQr =
            '0012XX38000063041234'; // XX is not a valid length

        // Act & Assert
        expect(
          () => VietQrDecoder.decodePaymentQr(invalidLengthQr),
          throwsA(isA<InvalidDataException>()),
        );
      });

      test('should handle round-trip encoding/decoding consistency', () {
        // Arrange: Create multiple test cases
        final testCases = [
          VietQrData(
            bankBinCode: SupportedBank.vietcombank,
            bankAccount: '1234567890',
            amount: '1000',
          ),
          VietQrData(
            bankBinCode: SupportedBank.bidv,
            bankAccount: '9876543210',
            amount: '999999',
            merchantName: 'Test Shop',
            merchantCity: 'Ho Chi Minh',
            additional: AdditionalData(
              purpose: 'Test payment',
              billNumber: 'TEST001',
            ),
          ),
          VietQrData(
            bankBinCode: SupportedBank.techcombank,
            bankAccount: '5555666677',
          ),
        ];

        for (final originalData in testCases) {
          // Act: Encode then decode
          final encoded = VietQrEncoder.encodePaymentQr(originalData);
          final decoded = VietQrDecoder.decodePaymentQr(encoded);

          // Assert: Data should match after round-trip
          expect(decoded.version, equals(originalData.version));
          expect(
            decoded.merchantAccInfo.beneficiaryOrgData.bankBinCode,
            equals(originalData.merchantAccInfo.beneficiaryOrgData.bankBinCode),
          );
          expect(
            decoded.merchantAccInfo.beneficiaryOrgData.bankAccount,
            equals(originalData.merchantAccInfo.beneficiaryOrgData.bankAccount),
          );
          expect(decoded.amount, equals(originalData.amount));
          expect(decoded.merchantName, equals(originalData.merchantName));
          expect(decoded.merchantCity, equals(originalData.merchantCity));
          expect(
            decoded.additional.purpose,
            equals(originalData.additional.purpose),
          );
          expect(
            decoded.additional.billNumber,
            equals(originalData.additional.billNumber),
          );
        }
      });

      test('should decode QR with all optional fields', () {
        // Arrange: Create VietQR with all possible fields
        final originalData = VietQrData(
          bankBinCode: SupportedBank.sacombank,
          bankAccount: '1111222233',
          amount: '75000',
          merchantCategory: '5812',
          merchantName: 'Store',
          merchantCity: 'Can Tho',
          postalCode: '94000',
          additional: AdditionalData(
            purpose: 'Test payment',
            billNumber: 'BILL001',
            mobileNumber: '0912345678',
            storeLabel: 'Store A',
          ),
        );
        final encodedQr = VietQrEncoder.encodePaymentQr(originalData);

        // Act: Decode the QR string
        final decodedData = VietQrDecoder.decodePaymentQr(encodedQr);

        // Assert: All fields should match
        expect(
          decodedData.merchantCategory,
          equals(originalData.merchantCategory),
        );
        expect(
          decodedData.additional.purpose,
          equals(originalData.additional.purpose),
        );
        expect(
          decodedData.additional.billNumber,
          equals(originalData.additional.billNumber),
        );
        expect(
          decodedData.additional.mobileNumber,
          equals(originalData.additional.mobileNumber),
        );
        expect(
          decodedData.additional.storeLabel,
          equals(originalData.additional.storeLabel),
        );
      });
    });

    group('edge cases', () {
      test('should handle QR with missing merchant account info', () {
        // Arrange: QR string without merchant account field should fail
        const qrWithoutMerchantInfo =
            '0002010112040000530370454045000580254VN6304';

        // Act & Assert
        expect(
          () => VietQrDecoder.decodePaymentQr(qrWithoutMerchantInfo),
          throwsA(isA<InvalidDataException>()),
        );
      });

      test('should handle nested TLV parsing correctly', () {
        // Arrange: Create QR with nested structures
        final originalData = VietQrData(
          bankBinCode: SupportedBank.mbbank,
          bankAccount: '7777888899',
          additional: AdditionalData(
            purpose: 'Nested test',
            mobileNumber: '0987654321',
          ),
        );
        final encodedQr = VietQrEncoder.encodePaymentQr(originalData);

        // Act: Decode and verify nested parsing
        final decodedData = VietQrDecoder.decodePaymentQr(encodedQr);

        // Assert: Nested fields should be parsed correctly
        expect(
          decodedData.merchantAccInfo.beneficiaryOrgData.bankAccount,
          equals(originalData.merchantAccInfo.beneficiaryOrgData.bankAccount),
        );
        expect(
          decodedData.additional.purpose,
          equals(originalData.additional.purpose),
        );
        expect(
          decodedData.additional.mobileNumber,
          equals(originalData.additional.mobileNumber),
        );
      });
    });
  });
}
