import '../const/const.dart';
import '../exceptions/vietqr_exceptions.dart';
import 'data.dart';

/// Represents additional data fields for VietQR payment
class AdditionalData extends Data {
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

  /// Create AdditionalData from a Map
  factory AdditionalData.fromMap(Map<String, dynamic> map) {
    return AdditionalData(
      billNumber: map['billNumber'] as String? ?? '',
      mobileNumber: map['mobileNumber'] as String? ?? '',
      storeLabel: map['storeLabel'] as String? ?? '',
      loyaltyNumber: map['loyaltyNumber'] as String? ?? '',
      referenceLabel: map['referenceLabel'] as String? ?? '',
      customerLabel: map['customerLabel'] as String? ?? '',
      terminalLabel: map['terminalLabel'] as String? ?? '',
      purpose: map['purpose'] as String? ?? '',
      consumerRequest: map['consumerRequest'] as String? ?? '',
    );
  }

  /// Convert this AdditionalData to a Map
  Map<String, dynamic> toMap() {
    return {
      'billNumber': billNumber,
      'mobileNumber': mobileNumber,
      'storeLabel': storeLabel,
      'loyaltyNumber': loyaltyNumber,
      'referenceLabel': referenceLabel,
      'customerLabel': customerLabel,
      'terminalLabel': terminalLabel,
      'purpose': purpose,
      'consumerRequest': consumerRequest,
    };
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write("AdditionalData(");
    buffer.write(" billNumber: $billNumber, ");
    buffer.write(" mobileNumber: $mobileNumber, ");
    buffer.write(" storeLabel: $storeLabel, ");
    buffer.write(" loyaltyNumber: $loyaltyNumber, ");
    buffer.write(" referenceLabel: $referenceLabel, ");
    buffer.write(" customerLabel: $customerLabel, ");
    buffer.write(" terminalLabel: $terminalLabel, ");
    buffer.write(" purpose: $purpose, ");
    buffer.write(" consumerRequest: $consumerRequest");
    buffer.write(")");
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AdditionalData &&
        other.billNumber == billNumber &&
        other.mobileNumber == mobileNumber &&
        other.storeLabel == storeLabel &&
        other.loyaltyNumber == loyaltyNumber &&
        other.referenceLabel == referenceLabel &&
        other.customerLabel == customerLabel &&
        other.terminalLabel == terminalLabel &&
        other.purpose == purpose &&
        other.consumerRequest == consumerRequest;
  }

  @override
  int get hashCode {
    return Object.hash(
      billNumber,
      mobileNumber,
      storeLabel,
      loyaltyNumber,
      referenceLabel,
      customerLabel,
      terminalLabel,
      purpose,
      consumerRequest,
    );
  }
}
