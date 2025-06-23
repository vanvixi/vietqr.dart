// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'beneficiary_org_data.dart';

class BeneficiaryOrgDataMapper extends ClassMapperBase<BeneficiaryOrgData> {
  BeneficiaryOrgDataMapper._();

  static BeneficiaryOrgDataMapper? _instance;
  static BeneficiaryOrgDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BeneficiaryOrgDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BeneficiaryOrgData';

  static String _$bankBinCode(BeneficiaryOrgData v) => v.bankBinCode;
  static const Field<BeneficiaryOrgData, String> _f$bankBinCode =
      Field('bankBinCode', _$bankBinCode);
  static String _$bankAccount(BeneficiaryOrgData v) => v.bankAccount;
  static const Field<BeneficiaryOrgData, String> _f$bankAccount =
      Field('bankAccount', _$bankAccount);

  @override
  final MappableFields<BeneficiaryOrgData> fields = const {
    #bankBinCode: _f$bankBinCode,
    #bankAccount: _f$bankAccount,
  };

  static BeneficiaryOrgData _instantiate(DecodingData data) {
    return BeneficiaryOrgData.custom(
        bankBinCode: data.dec(_f$bankBinCode),
        bankAccount: data.dec(_f$bankAccount));
  }

  @override
  final Function instantiate = _instantiate;

  static BeneficiaryOrgData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BeneficiaryOrgData>(map);
  }

  static BeneficiaryOrgData fromJson(String json) {
    return ensureInitialized().decodeJson<BeneficiaryOrgData>(json);
  }
}

mixin BeneficiaryOrgDataMappable {
  String toJson() {
    return BeneficiaryOrgDataMapper.ensureInitialized()
        .encodeJson<BeneficiaryOrgData>(this as BeneficiaryOrgData);
  }

  Map<String, dynamic> toMap() {
    return BeneficiaryOrgDataMapper.ensureInitialized()
        .encodeMap<BeneficiaryOrgData>(this as BeneficiaryOrgData);
  }

  BeneficiaryOrgDataCopyWith<BeneficiaryOrgData, BeneficiaryOrgData,
          BeneficiaryOrgData>
      get copyWith => _BeneficiaryOrgDataCopyWithImpl<BeneficiaryOrgData,
          BeneficiaryOrgData>(this as BeneficiaryOrgData, $identity, $identity);
  @override
  String toString() {
    return BeneficiaryOrgDataMapper.ensureInitialized()
        .stringifyValue(this as BeneficiaryOrgData);
  }

  @override
  bool operator ==(Object other) {
    return BeneficiaryOrgDataMapper.ensureInitialized()
        .equalsValue(this as BeneficiaryOrgData, other);
  }

  @override
  int get hashCode {
    return BeneficiaryOrgDataMapper.ensureInitialized()
        .hashValue(this as BeneficiaryOrgData);
  }
}

extension BeneficiaryOrgDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BeneficiaryOrgData, $Out> {
  BeneficiaryOrgDataCopyWith<$R, BeneficiaryOrgData, $Out>
      get $asBeneficiaryOrgData => $base.as(
          (v, t, t2) => _BeneficiaryOrgDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BeneficiaryOrgDataCopyWith<$R, $In extends BeneficiaryOrgData,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? bankBinCode, String? bankAccount});
  BeneficiaryOrgDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BeneficiaryOrgDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BeneficiaryOrgData, $Out>
    implements BeneficiaryOrgDataCopyWith<$R, BeneficiaryOrgData, $Out> {
  _BeneficiaryOrgDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BeneficiaryOrgData> $mapper =
      BeneficiaryOrgDataMapper.ensureInitialized();
  @override
  $R call({String? bankBinCode, String? bankAccount}) =>
      $apply(FieldCopyWithData({
        if (bankBinCode != null) #bankBinCode: bankBinCode,
        if (bankAccount != null) #bankAccount: bankAccount
      }));
  @override
  BeneficiaryOrgData $make(CopyWithData data) => BeneficiaryOrgData.custom(
      bankBinCode: data.get(#bankBinCode, or: $value.bankBinCode),
      bankAccount: data.get(#bankAccount, or: $value.bankAccount));

  @override
  BeneficiaryOrgDataCopyWith<$R2, BeneficiaryOrgData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BeneficiaryOrgDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
