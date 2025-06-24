import '../const/const.dart';
import '../const/field.dart';
import '../const/vietqr_enum.dart';
import '../extensions/field_extensions.dart';
import '../models/additional_data.dart';
import '../models/merchant_account_info_data.dart';
import '../models/vietqr_data.dart';
import '../utils/crc16_util.dart';

/// Core VietQR generator implementing the VietQR specification
///
/// This class provides low-level APIs for generating VietQR-compliant
/// payment QR codes and images according to Vietnamese banking standards.
class VietQrEncoder {
  VietQrEncoder._();

  /// Encode VietQR-compliant payment string with optimized string building
  static String encodePaymentQr(VietQrData data) {
    data.validate();

    final buffer = StringBuffer();
    _buildQrPayload(buffer, data);

    final payload = buffer.toString();
    final checksum = CRC16Util.calculateChecksum(payload);

    return payload + checksum;
  }

  // ================================================================
  // QR Building
  // ================================================================
  static void _buildQrPayload(StringBuffer buffer, VietQrData data) {
    final payloadFormatField = RootField.version.toTLV(data.version);
    final methodField = RootField.initiationMethod.toTLV(data.initiationMethod);

    buffer
      ..write(payloadFormatField)
      ..write(methodField);

    _buildMerchantAccInfoField(buffer, data.merchantAccInfo);
    if (data.merchantCategory.isNotEmpty) {
      final categoryField = RootField.category.toTLV(data.merchantCategory);
      buffer.write(categoryField);
    }

    _buildTransactionInfoFields(buffer, data.currency, data.amount);

    _buildConvenienceFeeFields(
      buffer,
      data.tipOrConvenience,
      data.feeFixed,
      data.feePercentage,
    );

    final countryField = RootField.country.toTLV(data.countryCode);
    buffer.write(countryField);

    if (data.merchantName.isNotEmpty) {
      final nameField = RootField.merchantName.toTLV(data.merchantName);
      buffer.write(nameField);
    }

    if (data.merchantCity.isNotEmpty) {
      final cityField = RootField.merchantCity.toTLV(data.merchantCity);
      buffer.write(cityField);
    }

    if (data.postalCode.isNotEmpty) {
      final postalField = RootField.postal.toTLV(data.postalCode);
      buffer.write(postalField);
    }

    _buildAdditionalDataField(buffer, data.additional);

    buffer.write(kCRC);
  }

  static void _buildMerchantAccInfoField(
    StringBuffer buffer,
    MerchantAccountInfoData merchantAccInfo,
  ) {
    final gUIDField = MerchantAccSubField.gUID.toTLV(merchantAccInfo.globalUid);
    final binField = MerchantAccSubField.binCode.toTLV(
      merchantAccInfo.beneficiaryOrgData.bankBinCode,
    );
    final accountField = MerchantAccSubField.accountNum.toTLV(
      merchantAccInfo.beneficiaryOrgData.bankAccount,
    );
    final beneficiaryOrgField = MerchantAccSubField.beneficiaryOrg.toTLV(
      binField + accountField,
    );
    final serviceField = MerchantAccSubField.service.toTLV(
      merchantAccInfo.serviceCode,
    );

    final merchantBuffer =
        StringBuffer()
          ..write(gUIDField)
          ..write(beneficiaryOrgField)
          ..write(serviceField);

    final merchantAccInfoField = RootField.merchantAccount.toTLV(
      merchantBuffer.toString(),
    );
    buffer.write(merchantAccInfoField);
  }

  static void _buildTransactionInfoFields(
    StringBuffer buffer,
    String currency,
    String amount,
  ) {
    final currencyField = RootField.currency.toTLV(currency);
    buffer.write(currencyField);

    if (amount.isEmpty) return;

    final amountField = RootField.amount.toTLV(amount);
    buffer.write(amountField);
  }

  static void _buildConvenienceFeeFields(
    StringBuffer buffer,
    String tipOrConvenience,
    String feeFixed,
    String feePercentage,
  ) {
    if (tipOrConvenience.isEmpty) return;

    final tipField = RootField.tipOrConvenience.toTLV(tipOrConvenience);
    buffer.write(tipField);

    if (tipOrConvenience == TipOrConvenienceIndicator.fixedFee.value) {
      final feeFixedField = RootField.feeFixed.toTLV(feeFixed);
      buffer.write(feeFixedField);
    }

    if (tipOrConvenience == TipOrConvenienceIndicator.percentageFee.value) {
      final feePercentageField = RootField.feePercentage.toTLV(feePercentage);
      buffer.write(feePercentageField);
    }
  }

  static void _buildAdditionalDataField(
    StringBuffer buffer,
    AdditionalData additional,
  ) {
    if (additional.isEmpty) return;

    final additionalBuffer = StringBuffer();

    if (additional.billNumber.isNotEmpty) {
      final mobileField = AdditionalDataSubField.billNumber.toTLV(
        additional.billNumber,
      );
      additionalBuffer.write(mobileField);
    }

    if (additional.mobileNumber.isNotEmpty) {
      final mobileField = AdditionalDataSubField.mobileNumber.toTLV(
        additional.mobileNumber,
      );
      additionalBuffer.write(mobileField);
    }

    if (additional.storeLabel.isNotEmpty) {
      final storeField = AdditionalDataSubField.storeLabel.toTLV(
        additional.storeLabel,
      );
      additionalBuffer.write(storeField);
    }

    if (additional.loyaltyNumber.isNotEmpty) {
      final loyaltyField = AdditionalDataSubField.loyaltyNumber.toTLV(
        additional.loyaltyNumber,
      );
      additionalBuffer.write(loyaltyField);
    }

    if (additional.referenceLabel.isNotEmpty) {
      final referenceField = AdditionalDataSubField.referenceLabel.toTLV(
        additional.referenceLabel,
      );
      additionalBuffer.write(referenceField);
    }

    if (additional.customerLabel.isNotEmpty) {
      final customerField = AdditionalDataSubField.customerLabel.toTLV(
        additional.customerLabel,
      );
      additionalBuffer.write(customerField);
    }

    if (additional.terminalLabel.isNotEmpty) {
      final terminalField = AdditionalDataSubField.terminalLabel.toTLV(
        additional.terminalLabel,
      );
      additionalBuffer.write(terminalField);
    }

    if (additional.purpose.isNotEmpty) {
      final purposeField = AdditionalDataSubField.purpose.toTLV(
        additional.purpose,
      );
      additionalBuffer.write(purposeField);
    }

    if (additional.customerLabel.isNotEmpty) {
      final customerField = AdditionalDataSubField.customerLabel.toTLV(
        additional.customerLabel,
      );
      additionalBuffer.write(customerField);
    }

    final additionalField = RootField.additionalData.toTLV(
      additionalBuffer.toString(),
    );
    buffer.write(additionalField);
  }
}
