import '../const/const.dart';
import '../const/supported_bank.dart';
import '../const/vietqr_enum.dart';
import '../exceptions/vietqr_exceptions.dart';
import 'beneficiary_org_data.dart';
import 'data.dart';

/// Represents Merchant Account Information  (Field id: 38)
class MerchantAccountInfoData extends Data {
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

  /// Create MerchantAccountInfoData from a Map
  factory MerchantAccountInfoData.fromMap(Map<String, dynamic> map) {
    return MerchantAccountInfoData.custom(
      globalUid: map['globalUid'] as String? ?? kNapasAID,
      beneficiaryOrgData: BeneficiaryOrgData.fromMap(
        map['beneficiaryOrgData'] as Map<String, dynamic>,
      ),
      serviceCode: map['serviceCode'] as String,
    );
  }

  /// Convert this MerchantAccountInfoData to a Map
  Map<String, dynamic> toMap() {
    return {
      'globalUid': globalUid,
      'beneficiaryOrgData': beneficiaryOrgData.toMap(),
      'serviceCode': serviceCode,
    };
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write("MerchantAccountInfoData(");
    buffer.write(" globalUid: $globalUid, ");
    buffer.write(" beneficiaryOrgData: $beneficiaryOrgData, ");
    buffer.write(" serviceCode: $serviceCode");
    buffer.write(")");
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MerchantAccountInfoData &&
        other.globalUid == globalUid &&
        other.beneficiaryOrgData == beneficiaryOrgData &&
        other.serviceCode == serviceCode;
  }

  @override
  int get hashCode => Object.hash(globalUid, beneficiaryOrgData, serviceCode);
}
