import '../const/const.dart';
import '../const/supported_bank.dart';
import '../exceptions/vietqr_exceptions.dart';
import 'data.dart';

class BeneficiaryOrgData extends Data {
  const BeneficiaryOrgData._({
    required this.bankBinCode,
    required this.bankAccount,
  });

  /// Create BeneficiaryOrgData using enum values for better type safety
  factory BeneficiaryOrgData({
    required SupportedBank bankBinCode,
    required String bankAccount,
  }) {
    return BeneficiaryOrgData._(
      bankBinCode: bankBinCode.binCode,
      bankAccount: bankAccount,
    );
  }

  factory BeneficiaryOrgData.custom({
    required String bankBinCode,
    required String bankAccount,
  }) {
    return BeneficiaryOrgData._(
      bankBinCode: bankBinCode,
      bankAccount: bankAccount,
    );
  }

  /// Acquirer ID (BIN code) of the bank
  final String bankBinCode;

  /// Merchant/Consumer ID (Account number or tax code)
  final String bankAccount;

  @override
  void validate() {
    if (bankBinCode.length != kBankBinCodeLength) {
      throw InvalidLengthException(
        fieldName: 'bankBinCode',
        length: kBankBinCodeLength,
      );
    }

    if (bankAccount.isEmpty || bankAccount.length > kBankAccountMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'bankAccount',
        maxLength: kBankAccountMaxLength,
      );
    }
  }

  /// Create BeneficiaryOrgData from a Map
  factory BeneficiaryOrgData.fromMap(Map<String, dynamic> map) {
    return BeneficiaryOrgData.custom(
      bankBinCode: map['bankBinCode'] as String,
      bankAccount: map['bankAccount'] as String,
    );
  }

  /// Convert this BeneficiaryOrgData to a Map
  Map<String, dynamic> toMap() {
    return {
      'bankBinCode': bankBinCode,
      'bankAccount': bankAccount,
    };
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write("BeneficiaryOrgData(");
    buffer.write(" bankBinCode: $bankBinCode, ");
    buffer.write(" bankAccount: $bankAccount");
    buffer.write(")");
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BeneficiaryOrgData &&
        other.bankBinCode == bankBinCode &&
        other.bankAccount == bankAccount;
  }

  @override
  int get hashCode => Object.hash(bankBinCode, bankAccount);
}
