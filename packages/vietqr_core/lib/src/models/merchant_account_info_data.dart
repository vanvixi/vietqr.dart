import 'package:dart_mappable/dart_mappable.dart';

import '../const/const.dart';
import '../const/supported_bank.dart';
import '../const/vietqr_enum.dart';
import '../exceptions/vietqr_exceptions.dart';
import 'beneficiary_org_data.dart';
import 'data.dart';

part 'merchant_account_info_data.mapper.dart';

/// Represents Merchant Account Information  (Field id: 38)
@MappableClass()
class MerchantAccountInfoData extends Data
    with MerchantAccountInfoDataMappable {
  const MerchantAccountInfoData._({
    required this.globalUid,
    required this.beneficiaryOrgData,
    required this.serviceCode,
  });

  /// Create a MerchantAccountInfoData instance using enum values for better type safety
  factory MerchantAccountInfoData({
    String globalUid = kNapasAID,
    required SupportedBank bankBinCode,
    required String bankAccount,
    required VietQrService? serviceCode,
  }) {
    return MerchantAccountInfoData._(
      globalUid: globalUid,
      beneficiaryOrgData: BeneficiaryOrgData(
        bankBinCode: bankBinCode,
        bankAccount: bankAccount,
      ),
      serviceCode: serviceCode?.value ?? VietQrService.accountNumber.value,
    );
  }

  @MappableConstructor()
  factory MerchantAccountInfoData.custom({
    String globalUid = kNapasAID,
    required BeneficiaryOrgData beneficiaryOrgData,
    required String serviceCode,
  }) {
    return MerchantAccountInfoData._(
      globalUid: globalUid,
      beneficiaryOrgData: beneficiaryOrgData,
      serviceCode: serviceCode,
    );
  }

  /// Globally Unique Identifier
  final String globalUid;

  /// Beneficiary Organization
  final BeneficiaryOrgData beneficiaryOrgData;

  /// Service code (e.g., "QRIBFTTA" for transfer to account)
  final String serviceCode;

  @override
  void validate() {
    if (globalUid.isEmpty || globalUid.length > kMerchantGUidLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'globalUid',
        maxLength: kMerchantGUidLength,
      );
    }

    beneficiaryOrgData.validate();

    if (serviceCode.isEmpty || serviceCode.length > kServiceCodeMaxLength) {
      throw MaxLengthExceededCharException(
        fieldName: 'service',
        maxLength: kServiceCodeMaxLength,
      );
    }
  }
}
