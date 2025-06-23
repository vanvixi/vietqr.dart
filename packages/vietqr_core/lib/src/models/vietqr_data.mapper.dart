// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vietqr_data.dart';

class VietQrDataMapper extends ClassMapperBase<VietQrData> {
  VietQrDataMapper._();

  static VietQrDataMapper? _instance;
  static VietQrDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VietQrDataMapper._());
      MerchantAccountInfoDataMapper.ensureInitialized();
      AdditionalDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'VietQrData';

  static String _$version(VietQrData v) => v.version;
  static const Field<VietQrData, String> _f$version = Field(
    'version',
    _$version,
    opt: true,
  );
  static MerchantAccountInfoData _$merchantAccInfo(VietQrData v) =>
      v.merchantAccInfo;
  static const Field<VietQrData, MerchantAccountInfoData> _f$merchantAccInfo =
      Field('merchantAccInfo', _$merchantAccInfo);
  static String _$merchantCategory(VietQrData v) => v.merchantCategory;
  static const Field<VietQrData, String> _f$merchantCategory = Field(
    'merchantCategory',
    _$merchantCategory,
    opt: true,
  );
  static String _$currency(VietQrData v) => v.currency;
  static const Field<VietQrData, String> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
  );
  static String _$amount(VietQrData v) => v.amount;
  static const Field<VietQrData, String> _f$amount = Field(
    'amount',
    _$amount,
    opt: true,
  );
  static String _$tipOrConvenience(VietQrData v) => v.tipOrConvenience;
  static const Field<VietQrData, String> _f$tipOrConvenience = Field(
    'tipOrConvenience',
    _$tipOrConvenience,
    opt: true,
  );
  static String _$feeFixed(VietQrData v) => v.feeFixed;
  static const Field<VietQrData, String> _f$feeFixed = Field(
    'feeFixed',
    _$feeFixed,
    opt: true,
  );
  static String _$feePercentage(VietQrData v) => v.feePercentage;
  static const Field<VietQrData, String> _f$feePercentage = Field(
    'feePercentage',
    _$feePercentage,
    opt: true,
  );
  static String _$countryCode(VietQrData v) => v.countryCode;
  static const Field<VietQrData, String> _f$countryCode = Field(
    'countryCode',
    _$countryCode,
    opt: true,
    def: kDefaultCountryCode,
  );
  static String _$merchantName(VietQrData v) => v.merchantName;
  static const Field<VietQrData, String> _f$merchantName = Field(
    'merchantName',
    _$merchantName,
    opt: true,
  );
  static String _$merchantCity(VietQrData v) => v.merchantCity;
  static const Field<VietQrData, String> _f$merchantCity = Field(
    'merchantCity',
    _$merchantCity,
    opt: true,
  );
  static String _$postalCode(VietQrData v) => v.postalCode;
  static const Field<VietQrData, String> _f$postalCode = Field(
    'postalCode',
    _$postalCode,
    opt: true,
  );
  static AdditionalData _$additional(VietQrData v) => v.additional;
  static const Field<VietQrData, AdditionalData> _f$additional = Field(
    'additional',
    _$additional,
    opt: true,
  );
  static String _$initiationMethod(VietQrData v) => v.initiationMethod;
  static const Field<VietQrData, String> _f$initiationMethod = Field(
    'initiationMethod',
    _$initiationMethod,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<VietQrData> fields = const {
    #version: _f$version,
    #merchantAccInfo: _f$merchantAccInfo,
    #merchantCategory: _f$merchantCategory,
    #currency: _f$currency,
    #amount: _f$amount,
    #tipOrConvenience: _f$tipOrConvenience,
    #feeFixed: _f$feeFixed,
    #feePercentage: _f$feePercentage,
    #countryCode: _f$countryCode,
    #merchantName: _f$merchantName,
    #merchantCity: _f$merchantCity,
    #postalCode: _f$postalCode,
    #additional: _f$additional,
    #initiationMethod: _f$initiationMethod,
  };

  static VietQrData _instantiate(DecodingData data) {
    return VietQrData.custom(
      version: data.dec(_f$version),
      merchantAccInfo: data.dec(_f$merchantAccInfo),
      merchantCategory: data.dec(_f$merchantCategory),
      currency: data.dec(_f$currency),
      amount: data.dec(_f$amount),
      tipOrConvenience: data.dec(_f$tipOrConvenience),
      feeFixed: data.dec(_f$feeFixed),
      feePercentage: data.dec(_f$feePercentage),
      countryCode: data.dec(_f$countryCode),
      merchantName: data.dec(_f$merchantName),
      merchantCity: data.dec(_f$merchantCity),
      postalCode: data.dec(_f$postalCode),
      additional: data.dec(_f$additional),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VietQrData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VietQrData>(map);
  }

  static VietQrData fromJson(String json) {
    return ensureInitialized().decodeJson<VietQrData>(json);
  }
}

mixin VietQrDataMappable {
  String toJson() {
    return VietQrDataMapper.ensureInitialized().encodeJson<VietQrData>(
      this as VietQrData,
    );
  }

  Map<String, dynamic> toMap() {
    return VietQrDataMapper.ensureInitialized().encodeMap<VietQrData>(
      this as VietQrData,
    );
  }

  VietQrDataCopyWith<VietQrData, VietQrData, VietQrData> get copyWith =>
      _VietQrDataCopyWithImpl<VietQrData, VietQrData>(
        this as VietQrData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VietQrDataMapper.ensureInitialized().stringifyValue(
      this as VietQrData,
    );
  }

  @override
  bool operator ==(Object other) {
    return VietQrDataMapper.ensureInitialized().equalsValue(
      this as VietQrData,
      other,
    );
  }

  @override
  int get hashCode {
    return VietQrDataMapper.ensureInitialized().hashValue(this as VietQrData);
  }
}

extension VietQrDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VietQrData, $Out> {
  VietQrDataCopyWith<$R, VietQrData, $Out> get $asVietQrData =>
      $base.as((v, t, t2) => _VietQrDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VietQrDataCopyWith<$R, $In extends VietQrData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MerchantAccountInfoDataCopyWith<
    $R,
    MerchantAccountInfoData,
    MerchantAccountInfoData
  >
  get merchantAccInfo;
  AdditionalDataCopyWith<$R, AdditionalData, AdditionalData> get additional;
  $R call({
    String? version,
    MerchantAccountInfoData? merchantAccInfo,
    String? merchantCategory,
    String? currency,
    String? amount,
    String? tipOrConvenience,
    String? feeFixed,
    String? feePercentage,
    String? countryCode,
    String? merchantName,
    String? merchantCity,
    String? postalCode,
    AdditionalData? additional,
  });
  VietQrDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VietQrDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VietQrData, $Out>
    implements VietQrDataCopyWith<$R, VietQrData, $Out> {
  _VietQrDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VietQrData> $mapper =
      VietQrDataMapper.ensureInitialized();
  @override
  MerchantAccountInfoDataCopyWith<
    $R,
    MerchantAccountInfoData,
    MerchantAccountInfoData
  >
  get merchantAccInfo =>
      $value.merchantAccInfo.copyWith.$chain((v) => call(merchantAccInfo: v));
  @override
  AdditionalDataCopyWith<$R, AdditionalData, AdditionalData> get additional =>
      ($value.additional as AdditionalData).copyWith.$chain(
        (v) => call(additional: v),
      );
  @override
  $R call({
    Object? version = $none,
    MerchantAccountInfoData? merchantAccInfo,
    Object? merchantCategory = $none,
    Object? currency = $none,
    Object? amount = $none,
    Object? tipOrConvenience = $none,
    Object? feeFixed = $none,
    Object? feePercentage = $none,
    String? countryCode,
    Object? merchantName = $none,
    Object? merchantCity = $none,
    Object? postalCode = $none,
    Object? additional = $none,
  }) => $apply(
    FieldCopyWithData({
      if (version != $none) #version: version,
      if (merchantAccInfo != null) #merchantAccInfo: merchantAccInfo,
      if (merchantCategory != $none) #merchantCategory: merchantCategory,
      if (currency != $none) #currency: currency,
      if (amount != $none) #amount: amount,
      if (tipOrConvenience != $none) #tipOrConvenience: tipOrConvenience,
      if (feeFixed != $none) #feeFixed: feeFixed,
      if (feePercentage != $none) #feePercentage: feePercentage,
      if (countryCode != null) #countryCode: countryCode,
      if (merchantName != $none) #merchantName: merchantName,
      if (merchantCity != $none) #merchantCity: merchantCity,
      if (postalCode != $none) #postalCode: postalCode,
      if (additional != $none) #additional: additional,
    }),
  );
  @override
  VietQrData $make(CopyWithData data) => VietQrData.custom(
    version: data.get(#version, or: $value.version),
    merchantAccInfo: data.get(#merchantAccInfo, or: $value.merchantAccInfo),
    merchantCategory: data.get(#merchantCategory, or: $value.merchantCategory),
    currency: data.get(#currency, or: $value.currency),
    amount: data.get(#amount, or: $value.amount),
    tipOrConvenience: data.get(#tipOrConvenience, or: $value.tipOrConvenience),
    feeFixed: data.get(#feeFixed, or: $value.feeFixed),
    feePercentage: data.get(#feePercentage, or: $value.feePercentage),
    countryCode: data.get(#countryCode, or: $value.countryCode),
    merchantName: data.get(#merchantName, or: $value.merchantName),
    merchantCity: data.get(#merchantCity, or: $value.merchantCity),
    postalCode: data.get(#postalCode, or: $value.postalCode),
    additional: data.get(#additional, or: $value.additional),
  );

  @override
  VietQrDataCopyWith<$R2, VietQrData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VietQrDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
