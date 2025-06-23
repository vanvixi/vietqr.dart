import 'package:dart_mappable/dart_mappable.dart';

import '../const/const.dart';
import '../exceptions/vietqr_exceptions.dart';
import 'data.dart';
part 'additional_data.mapper.dart';

/// Represents additional data fields for VietQR payment
@MappableClass()
class AdditionalData extends Data with AdditionalDataMappable {
  const AdditionalData({
    this.billNumber = '',
    this.mobileNumber = '',
    this.storeLabel = '',
    this.loyaltyNumber = '',
    this.referenceLabel = '',
    this.customerLabel = '',
    this.terminalLabel = '',
    this.purpose = '',
    this.consumerRequest = '',
  });

  final String billNumber;
  final String mobileNumber;
  final String storeLabel;
  final String loyaltyNumber;
  final String referenceLabel;
  final String customerLabel;
  final String terminalLabel;

  /// Purpose of the transaction
  final String purpose;

  /// Additional Consumer Data Request
  final String consumerRequest;

  bool get isEmpty {
    return billNumber.isEmpty &&
        mobileNumber.isEmpty &&
        storeLabel.isEmpty &&
        loyaltyNumber.isEmpty &&
        referenceLabel.isEmpty &&
        customerLabel.isEmpty &&
        terminalLabel.isEmpty &&
        purpose.isEmpty &&
        consumerRequest.isEmpty;
  }

  @override
  void validate() {
    // Only validate if additional data is not empty
    // When isEmpty is true, it means no additional data fields are provided,
    // which is valid - the entire additional data section will be omitted

    if (billNumber.isNotEmpty && billNumber.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'billNumber',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (mobileNumber.isNotEmpty && mobileNumber.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'mobileNumber',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (storeLabel.isNotEmpty && storeLabel.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'storeLabel',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (loyaltyNumber.isNotEmpty &&
        loyaltyNumber.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'loyaltyNumber',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (referenceLabel.isNotEmpty &&
        referenceLabel.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'referenceLabel',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (customerLabel.isNotEmpty &&
        customerLabel.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'customerLabel',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (terminalLabel.isNotEmpty &&
        terminalLabel.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'terminalLabel',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (purpose.isNotEmpty && purpose.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'purpose',
        maxLength: kAdditionalMaxLength,
      );
    }

    if (consumerRequest.isNotEmpty &&
        consumerRequest.length > kAdditionalMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'consumerRequest',
        maxLength: kAdditionalMaxLength,
      );
    }
  }
}
