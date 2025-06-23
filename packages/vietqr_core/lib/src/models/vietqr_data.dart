import 'package:dart_mappable/dart_mappable.dart';

import '../const/const.dart';
import '../const/supported_bank.dart';
import '../const/vietqr_enum.dart';
import '../exceptions/vietqr_exceptions.dart';
import 'additional_data.dart';
import 'data.dart';
import 'merchant_account_info_data.dart';

part 'vietqr_data.mapper.dart';

/// Data model for VietQR payment information
///
/// This class represents all the necessary information to generate a VietQR
/// payment QR code according to Vietnamese banking standards.
@MappableClass()
class VietQrData extends Data with VietQrDataMappable {
  const VietQrData._({
    required this.version,
    required this.initiationMethod,
    required this.merchantAccInfo,
    required this.merchantCategory,
    required this.currency,
    required this.amount,

    required this.tipOrConvenience,
    required this.feeFixed,
    required this.feePercentage,
    required this.countryCode,
    required this.merchantName,
    required this.merchantCity,

    required this.postalCode,
    required this.additional,
  });

  /// Create VietQrData using enum values for better type safety
  ///
  /// Example:
  /// ```dart
  /// final data = VietQrData(
  ///   bankBinCode: SupportedBank.vietcombank,
  ///   bankAccount: '0123456789',
  ///   amount: '50000',
  ///   additional: AdditionalData(purpose: 'Payment for invoice'),
  /// );
  /// ```
  factory VietQrData({
    VietQrVersion? version,
    required SupportedBank bankBinCode,
    required String bankAccount,
    VietQrService? serviceCode,
    String? merchantCategory,
    VietQrCurrency? currency,
    String? amount,
    String? tipOrConvenience,
    String? feeFixed,
    String? feePercentage,
    String countryCode = kDefaultCountryCode,
    String? merchantName,
    String? merchantCity,
    String? postalCode,
    AdditionalData? additional,
  }) {
    amount ??= '';
    return VietQrData._(
      version: version?.value ?? VietQrVersion.v_01.value,
      initiationMethod:
          amount.isEmpty
              ? PointOfInitiationMethod.dynamicQr.value
              : PointOfInitiationMethod.staticQr.value,
      merchantAccInfo: MerchantAccountInfoData(
        bankBinCode: bankBinCode,
        bankAccount: bankAccount,
        serviceCode: serviceCode,
      ),
      merchantCategory: merchantCategory ?? '',
      currency: currency?.value ?? VietQrCurrency.vnd.value,
      amount: amount,
      tipOrConvenience: tipOrConvenience ?? '',
      feeFixed: feeFixed ?? '',
      feePercentage: feePercentage ?? '',
      countryCode: countryCode.isNotEmpty ? countryCode : kDefaultCountryCode,
      merchantName: merchantName ?? '',
      merchantCity: merchantCity ?? '',
      postalCode: postalCode ?? '',
      additional: additional ?? const AdditionalData(),
    );
  }

  /// Create VietQrData with custom parameters
  @MappableConstructor()
  factory VietQrData.custom({
    String? version,
    required MerchantAccountInfoData merchantAccInfo,
    String? merchantCategory,
    String? currency,
    String? amount,
    String? tipOrConvenience,
    String? feeFixed,
    String? feePercentage,
    String countryCode = kDefaultCountryCode,
    String? merchantName,
    String? merchantCity,
    String? postalCode,
    AdditionalData? additional,
  }) {
    amount ??= '';
    return VietQrData._(
      version: version ?? VietQrVersion.v_01.value,
      initiationMethod:
          amount.isEmpty
              ? PointOfInitiationMethod.dynamicQr.value
              : PointOfInitiationMethod.staticQr.value,
      merchantAccInfo: merchantAccInfo,
      merchantCategory: merchantCategory ?? '',
      currency: currency ?? VietQrCurrency.vnd.value,
      amount: amount,
      tipOrConvenience: tipOrConvenience ?? '',
      feeFixed: feeFixed ?? '',
      feePercentage: feePercentage ?? '',
      countryCode: countryCode.isNotEmpty ? countryCode : kDefaultCountryCode,
      merchantName: merchantName ?? '',
      merchantCity: merchantCity ?? '',
      postalCode: postalCode ?? '',
      additional: additional ?? const AdditionalData(),
    );
  }

  /// Payload Format Indicator (default is "01")
  final String version;

  /// Point of Initiation
  final String initiationMethod;

  /// Merchant Account Information
  final MerchantAccountInfoData merchantAccInfo;

  /// Merchant Category Code
  final String merchantCategory;

  /// Transaction Currency (default is "704" for VND)
  final String currency;

  /// Transaction Amount (as a string, e.g., "50000")
  final String amount;

  /// Tip or Convenience Indicator
  final String tipOrConvenience;

  /// Value of Convenience Fee Fixed
  final String feeFixed;

  /// Value of Convenience Fee Percentage
  final String feePercentage;

  /// Country code (default is "VN" for Vietnam)
  final String countryCode;

  /// Merchant Name
  final String merchantName;

  /// Merchant Name
  final String merchantCity;

  /// Postal code (zip code) for the merchant's location
  final String postalCode;

  final AdditionalData additional;

  @override
  void validate() {
    if (version.length != kVersionLength) {
      throw InvalidLengthException(
        fieldName: 'version',
        length: kVersionLength,
      );
    }

    if (initiationMethod.length != kMethodLength) {
      throw InvalidLengthException(
        fieldName: 'initiationMethod',
        length: kMethodLength,
      );
    }

    merchantAccInfo.validate();

    if (merchantCategory.isNotEmpty &&
        merchantCategory.length != kMerchantCategoryLength) {
      throw InvalidLengthException(
        fieldName: 'category',
        length: kMerchantCategoryLength,
      );
    }

    if (currency.length != kCurrencyLength) {
      throw InvalidLengthException(
        fieldName: 'currency',
        length: kCurrencyLength,
      );
    }

    _validateAmount();

    _validateConvenienceFee();

    if (countryCode.length != kCountryCodeLength) {
      throw InvalidLengthException(
        fieldName: 'countryCode',
        length: kCountryCodeLength,
      );
    }

    if (merchantName.isNotEmpty &&
        merchantName.length > kMerchantNameMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'merchantName',
        maxLength: kMerchantNameMaxLength,
      );
    }

    if (merchantCity.isNotEmpty &&
        merchantCity.length > kMerchantCityMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'merchantCity',
        maxLength: kMerchantCityMaxLength,
      );
    }

    if (postalCode.isNotEmpty && postalCode.length > kPostalCodeMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'postalCode',
        maxLength: kAmountMaxLength,
      );
    }

    additional.validate();
  }

  void _validateAmount() {
    if (amount.isEmpty) return;

    if (amount.length > kAmountMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'amount',
        maxLength: kAmountMaxLength,
      );
    }

    final numAmount = num.tryParse(amount);
    if (numAmount == null) {
      throw InvalidDataException(
        fieldName: 'amount',
        message: 'must be a valid number',
      );
    } else if (numAmount <= 0) {
      throw InvalidDataException(
        fieldName: 'amount',
        message: 'must be greater than 0',
      );
    }
  }

  void _validateConvenienceFee() {
    if (tipOrConvenience.isEmpty) return;

    if (tipOrConvenience.length != kTipOrConvenienceLength) {
      throw InvalidLengthException(
        fieldName: tipOrConvenience,
        length: kTipOrConvenienceLength,
      );
    }

    final indicator = TipOrConvenienceIndicator.fromValue(tipOrConvenience);
    if (indicator == null) {
      throw InvalidDataException(
        fieldName: tipOrConvenience,
        message:
            "must be one of: ${TipOrConvenienceIndicator.values.map((e) => e.value).join(', ')}",
      );
    }

    switch (indicator) {
      case TipOrConvenienceIndicator.promptForTip:
        break;
      case TipOrConvenienceIndicator.fixedFee:
        if (feeFixed.isEmpty || feeFixed.length > kFeeFixedMaxLength) {
          throw MaxLengthExceededCharException(
            fieldName: feeFixed,
            maxLength: kFeeFixedMaxLength,
          );
        }
        break;
      case TipOrConvenienceIndicator.percentageFee:
        if (feePercentage.isEmpty ||
            feePercentage.length > kFeePercentageMaxLength) {
          throw MaxLengthExceededCharException(
            fieldName: feePercentage,
            maxLength: kFeePercentageMaxLength,
          );
        }
        break;
    }
  }
}
