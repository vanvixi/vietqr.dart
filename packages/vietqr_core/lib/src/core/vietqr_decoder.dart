import '../const/const.dart';
import '../const/field.dart';
import '../exceptions/vietqr_exceptions.dart';
import '../models/additional_data.dart';
import '../models/beneficiary_org_data.dart';
import '../models/merchant_account_info_data.dart';
import '../models/vietqr_data.dart';
import '../utils/crc16_util.dart';

/// Core VietQR decoder implementing the VietQR specification
///
/// This class provides low-level APIs for decoding VietQR-compliant
/// payment QR codes according to Vietnamese banking standards.
class VietQrDecoder {
  VietQrDecoder._();

  /// Decode VietQR-compliant payment string to VietQrData
  static VietQrData decodePaymentQr(String qrString) {
    if (qrString.isEmpty) {
      throw InvalidDataException(fieldName: 'qrString', message: 'cannot be empty');
    }

    // Validate checksum first
    _validateChecksum(qrString);

    // Remove CRC field (6304) and checksum from payload for parsing
    // CRC field is always at the end: "6304" + 4-character checksum
    final payloadWithoutCrc = qrString.substring(0, qrString.length - 8); // Remove "6304XXXX"

    // Parse TLV fields
    final fields = _parseTLVFields(payloadWithoutCrc);

    // Build VietQrData from parsed fields
    return _buildVietQrData(fields);
  }

  // ================================================================
  // PRIVATE METHODS - Validation
  // ================================================================

  static void _validateChecksum(String qrString) {
    if (qrString.length < 8) {
      // Need at least "6304XXXX"
      throw InvalidDataException(fieldName: 'qrString', message: 'too short to contain valid checksum');
    }

    // Check if it ends with CRC field identifier "6304"
    if (!qrString.substring(qrString.length - 8, qrString.length - 4).startsWith('6304')) {
      throw InvalidDataException(fieldName: 'qrString', message: 'missing CRC field identifier');
    }

    final payload = qrString.substring(0, qrString.length - kCRCChecksumLength);
    final providedChecksum = qrString.substring(qrString.length - kCRCChecksumLength);
    final calculatedChecksum = CRC16Util.calculateChecksum(payload);

    if (providedChecksum.toUpperCase() != calculatedChecksum.toUpperCase()) {
      throw InvalidDataException(
        fieldName: 'checksum',
        message: 'invalid checksum. Expected: $calculatedChecksum, got: $providedChecksum',
      );
    }
  }

  // ================================================================
  // PRIVATE METHODS - TLV Parsing
  // ================================================================

  static Map<String, String> _parseTLVFields(String payload) {
    final fields = <String, String>{};
    int index = 0;

    while (index < payload.length) {
      if (index + 4 > payload.length) {
        throw InvalidDataException(fieldName: 'payload', message: 'incomplete TLV field at position $index');
      }

      final tag = payload.substring(index, index + 2);
      final lengthStr = payload.substring(index + 2, index + 4);

      final length = int.tryParse(lengthStr);
      if (length == null || length < 0) {
        throw InvalidDataException(fieldName: 'length', message: 'invalid length value: $lengthStr');
      }

      if (index + 4 + length > payload.length) {
        throw InvalidDataException(
          fieldName: 'payload',
          message: 'field $tag length $length exceeds remaining payload',
        );
      }

      final value = payload.substring(index + 4, index + 4 + length);
      fields[tag] = value;

      index += 4 + length;
    }

    return fields;
  }

  static Map<String, String> _parseNestedTLVFields(String value) {
    return _parseTLVFields(value);
  }

  // ================================================================
  // PRIVATE METHODS - Data Building
  // ================================================================

  static VietQrData _buildVietQrData(Map<String, String> fields) {
    // Extract required fields
    final version = fields[RootField.version.id] ?? '';
    final merchantAccountInfo = _parseMerchantAccountInfo(fields[RootField.merchantAccount.id] ?? '');

    // Extract optional fields
    final merchantCategory = fields[RootField.category.id] ?? '';
    final currency = fields[RootField.currency.id] ?? '';
    final amount = fields[RootField.amount.id] ?? '';
    final tipOrConvenience = fields[RootField.tipOrConvenience.id] ?? '';
    final feeFixed = fields[RootField.feeFixed.id] ?? '';
    final feePercentage = fields[RootField.feePercentage.id] ?? '';
    final countryCode = fields[RootField.country.id] ?? '';
    final merchantName = fields[RootField.merchantName.id] ?? '';
    final merchantCity = fields[RootField.merchantCity.id] ?? '';
    final postalCode = fields[RootField.postal.id] ?? '';
    final additional = _parseAdditionalData(fields[RootField.additionalData.id] ?? '');

    return VietQrData.custom(
      version: version,
      merchantAccInfo: merchantAccountInfo,
      merchantCategory: merchantCategory,
      currency: currency,
      amount: amount,
      tipOrConvenience: tipOrConvenience,
      feeFixed: feeFixed,
      feePercentage: feePercentage,
      countryCode: countryCode,
      merchantName: merchantName,
      merchantCity: merchantCity,
      postalCode: postalCode,
      additional: additional,
    );
  }

  static MerchantAccountInfoData _parseMerchantAccountInfo(String value) {
    if (value.isEmpty) {
      throw InvalidDataException(fieldName: 'merchantAccount', message: 'cannot be empty');
    }

    final fields = _parseNestedTLVFields(value);
    final globalUid = fields[MerchantSubField.gUID.id] ?? '';
    final beneficiaryOrgValue = fields[MerchantSubField.beneficiaryOrg.id] ?? '';
    final serviceCode = fields[MerchantSubField.service.id] ?? '';

    // Parse beneficiary organization data
    final beneficiaryFields = _parseNestedTLVFields(beneficiaryOrgValue);
    final binCode = beneficiaryFields[MerchantSubField.binCode.id] ?? '';
    final accountNum = beneficiaryFields[MerchantSubField.accountNum.id] ?? '';

    final beneficiaryOrgData = BeneficiaryOrgData.custom(bankBinCode: binCode, bankAccount: accountNum);

    return MerchantAccountInfoData.custom(
      globalUid: globalUid,
      beneficiaryOrgData: beneficiaryOrgData,
      serviceCode: serviceCode,
    );
  }

  static AdditionalData _parseAdditionalData(String value) {
    if (value.isEmpty) {
      return const AdditionalData();
    }

    final fields = _parseNestedTLVFields(value);

    return AdditionalData(
      billNumber: fields[AdditionalDataSubField.billNumber.id] ?? '',
      mobileNumber: fields[AdditionalDataSubField.mobileNumber.id] ?? '',
      storeLabel: fields[AdditionalDataSubField.storeLabel.id] ?? '',
      loyaltyNumber: fields[AdditionalDataSubField.loyaltyNumber.id] ?? '',
      referenceLabel: fields[AdditionalDataSubField.referenceLabel.id] ?? '',
      customerLabel: fields[AdditionalDataSubField.customerLabel.id] ?? '',
      terminalLabel: fields[AdditionalDataSubField.terminalLabel.id] ?? '',
      purpose: fields[AdditionalDataSubField.purpose.id] ?? '',
    );
  }
}
