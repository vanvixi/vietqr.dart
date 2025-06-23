import 'package:dart_mappable/dart_mappable.dart';

import '../const/const.dart';
import '../const/supported_bank.dart';
import '../exceptions/vietqr_exceptions.dart';
import 'data.dart';

part 'beneficiary_org_data.mapper.dart';

@MappableClass()
class BeneficiaryOrgData extends Data with BeneficiaryOrgDataMappable {
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

  @MappableConstructor()
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
}
