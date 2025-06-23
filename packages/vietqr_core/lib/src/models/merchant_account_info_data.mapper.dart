// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'merchant_account_info_data.dart';

class MerchantAccountInfoDataMapper
    extends ClassMapperBase<MerchantAccountInfoData> {
  MerchantAccountInfoDataMapper._();

  static MerchantAccountInfoDataMapper? _instance;
  static MerchantAccountInfoDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MerchantAccountInfoDataMapper._());
      BeneficiaryOrgDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MerchantAccountInfoData';

  static String _$globalUid(MerchantAccountInfoData v) => v.globalUid;
  static const Field<MerchantAccountInfoData, String> _f$globalUid =
      Field('globalUid', _$globalUid, opt: true, def: kNapasAID);
  static BeneficiaryOrgData _$beneficiaryOrgData(MerchantAccountInfoData v) =>
      v.beneficiaryOrgData;
  static const Field<MerchantAccountInfoData, BeneficiaryOrgData>
      _f$beneficiaryOrgData = Field('beneficiaryOrgData', _$beneficiaryOrgData);
  static String _$serviceCode(MerchantAccountInfoData v) => v.serviceCode;
  static const Field<MerchantAccountInfoData, String> _f$serviceCode =
      Field('serviceCode', _$serviceCode);

  @override
  final MappableFields<MerchantAccountInfoData> fields = const {
    #globalUid: _f$globalUid,
    #beneficiaryOrgData: _f$beneficiaryOrgData,
    #serviceCode: _f$serviceCode,
  };

  static MerchantAccountInfoData _instantiate(DecodingData data) {
    return MerchantAccountInfoData.custom(
        globalUid: data.dec(_f$globalUid),
        beneficiaryOrgData: data.dec(_f$beneficiaryOrgData),
        serviceCode: data.dec(_f$serviceCode));
  }

  @override
  final Function instantiate = _instantiate;

  static MerchantAccountInfoData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MerchantAccountInfoData>(map);
  }

  static MerchantAccountInfoData fromJson(String json) {
    return ensureInitialized().decodeJson<MerchantAccountInfoData>(json);
  }
}

mixin MerchantAccountInfoDataMappable {
  String toJson() {
    return MerchantAccountInfoDataMapper.ensureInitialized()
        .encodeJson<MerchantAccountInfoData>(this as MerchantAccountInfoData);
  }

  Map<String, dynamic> toMap() {
    return MerchantAccountInfoDataMapper.ensureInitialized()
        .encodeMap<MerchantAccountInfoData>(this as MerchantAccountInfoData);
  }

  MerchantAccountInfoDataCopyWith<MerchantAccountInfoData,
          MerchantAccountInfoData, MerchantAccountInfoData>
      get copyWith => _MerchantAccountInfoDataCopyWithImpl<
              MerchantAccountInfoData, MerchantAccountInfoData>(
          this as MerchantAccountInfoData, $identity, $identity);
  @override
  String toString() {
    return MerchantAccountInfoDataMapper.ensureInitialized()
        .stringifyValue(this as MerchantAccountInfoData);
  }

  @override
  bool operator ==(Object other) {
    return MerchantAccountInfoDataMapper.ensureInitialized()
        .equalsValue(this as MerchantAccountInfoData, other);
  }

  @override
  int get hashCode {
    return MerchantAccountInfoDataMapper.ensureInitialized()
        .hashValue(this as MerchantAccountInfoData);
  }
}

extension MerchantAccountInfoDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MerchantAccountInfoData, $Out> {
  MerchantAccountInfoDataCopyWith<$R, MerchantAccountInfoData, $Out>
      get $asMerchantAccountInfoData => $base.as((v, t, t2) =>
          _MerchantAccountInfoDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MerchantAccountInfoDataCopyWith<
    $R,
    $In extends MerchantAccountInfoData,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  BeneficiaryOrgDataCopyWith<$R, BeneficiaryOrgData, BeneficiaryOrgData>
      get beneficiaryOrgData;
  $R call(
      {String? globalUid,
      BeneficiaryOrgData? beneficiaryOrgData,
      String? serviceCode});
  MerchantAccountInfoDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MerchantAccountInfoDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MerchantAccountInfoData, $Out>
    implements
        MerchantAccountInfoDataCopyWith<$R, MerchantAccountInfoData, $Out> {
  _MerchantAccountInfoDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MerchantAccountInfoData> $mapper =
      MerchantAccountInfoDataMapper.ensureInitialized();
  @override
  BeneficiaryOrgDataCopyWith<$R, BeneficiaryOrgData, BeneficiaryOrgData>
      get beneficiaryOrgData => $value.beneficiaryOrgData.copyWith
          .$chain((v) => call(beneficiaryOrgData: v));
  @override
  $R call(
          {String? globalUid,
          BeneficiaryOrgData? beneficiaryOrgData,
          String? serviceCode}) =>
      $apply(FieldCopyWithData({
        if (globalUid != null) #globalUid: globalUid,
        if (beneficiaryOrgData != null) #beneficiaryOrgData: beneficiaryOrgData,
        if (serviceCode != null) #serviceCode: serviceCode
      }));
  @override
  MerchantAccountInfoData $make(CopyWithData data) =>
      MerchantAccountInfoData.custom(
          globalUid: data.get(#globalUid, or: $value.globalUid),
          beneficiaryOrgData:
              data.get(#beneficiaryOrgData, or: $value.beneficiaryOrgData),
          serviceCode: data.get(#serviceCode, or: $value.serviceCode));

  @override
  MerchantAccountInfoDataCopyWith<$R2, MerchantAccountInfoData, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MerchantAccountInfoDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
