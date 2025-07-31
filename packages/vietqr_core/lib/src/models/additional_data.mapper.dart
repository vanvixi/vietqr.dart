// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'additional_data.dart';

class AdditionalDataMapper extends ClassMapperBase<AdditionalData> {
  AdditionalDataMapper._();

  static AdditionalDataMapper? _instance;
  static AdditionalDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdditionalDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AdditionalData';

  static String _$billNumber(AdditionalData v) => v.billNumber;
  static const Field<AdditionalData, String> _f$billNumber = Field(
    'billNumber',
    _$billNumber,
    opt: true,
    def: '',
  );
  static String _$mobileNumber(AdditionalData v) => v.mobileNumber;
  static const Field<AdditionalData, String> _f$mobileNumber = Field(
    'mobileNumber',
    _$mobileNumber,
    opt: true,
    def: '',
  );
  static String _$storeLabel(AdditionalData v) => v.storeLabel;
  static const Field<AdditionalData, String> _f$storeLabel = Field(
    'storeLabel',
    _$storeLabel,
    opt: true,
    def: '',
  );
  static String _$loyaltyNumber(AdditionalData v) => v.loyaltyNumber;
  static const Field<AdditionalData, String> _f$loyaltyNumber = Field(
    'loyaltyNumber',
    _$loyaltyNumber,
    opt: true,
    def: '',
  );
  static String _$referenceLabel(AdditionalData v) => v.referenceLabel;
  static const Field<AdditionalData, String> _f$referenceLabel = Field(
    'referenceLabel',
    _$referenceLabel,
    opt: true,
    def: '',
  );
  static String _$customerLabel(AdditionalData v) => v.customerLabel;
  static const Field<AdditionalData, String> _f$customerLabel = Field(
    'customerLabel',
    _$customerLabel,
    opt: true,
    def: '',
  );
  static String _$terminalLabel(AdditionalData v) => v.terminalLabel;
  static const Field<AdditionalData, String> _f$terminalLabel = Field(
    'terminalLabel',
    _$terminalLabel,
    opt: true,
    def: '',
  );
  static String _$purpose(AdditionalData v) => v.purpose;
  static const Field<AdditionalData, String> _f$purpose = Field(
    'purpose',
    _$purpose,
    opt: true,
    def: '',
  );
  static String _$consumerRequest(AdditionalData v) => v.consumerRequest;
  static const Field<AdditionalData, String> _f$consumerRequest = Field(
    'consumerRequest',
    _$consumerRequest,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<AdditionalData> fields = const {
    #billNumber: _f$billNumber,
    #mobileNumber: _f$mobileNumber,
    #storeLabel: _f$storeLabel,
    #loyaltyNumber: _f$loyaltyNumber,
    #referenceLabel: _f$referenceLabel,
    #customerLabel: _f$customerLabel,
    #terminalLabel: _f$terminalLabel,
    #purpose: _f$purpose,
    #consumerRequest: _f$consumerRequest,
  };

  static AdditionalData _instantiate(DecodingData data) {
    return AdditionalData(
      billNumber: data.dec(_f$billNumber),
      mobileNumber: data.dec(_f$mobileNumber),
      storeLabel: data.dec(_f$storeLabel),
      loyaltyNumber: data.dec(_f$loyaltyNumber),
      referenceLabel: data.dec(_f$referenceLabel),
      customerLabel: data.dec(_f$customerLabel),
      terminalLabel: data.dec(_f$terminalLabel),
      purpose: data.dec(_f$purpose),
      consumerRequest: data.dec(_f$consumerRequest),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AdditionalData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdditionalData>(map);
  }

  static AdditionalData fromJson(String json) {
    return ensureInitialized().decodeJson<AdditionalData>(json);
  }
}

mixin AdditionalDataMappable {
  String toJson() {
    return AdditionalDataMapper.ensureInitialized().encodeJson<AdditionalData>(
      this as AdditionalData,
    );
  }

  Map<String, dynamic> toMap() {
    return AdditionalDataMapper.ensureInitialized().encodeMap<AdditionalData>(
      this as AdditionalData,
    );
  }

  AdditionalDataCopyWith<AdditionalData, AdditionalData, AdditionalData>
      get copyWith =>
          _AdditionalDataCopyWithImpl<AdditionalData, AdditionalData>(
            this as AdditionalData,
            $identity,
            $identity,
          );
  @override
  String toString() {
    return AdditionalDataMapper.ensureInitialized().stringifyValue(
      this as AdditionalData,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdditionalDataMapper.ensureInitialized().equalsValue(
      this as AdditionalData,
      other,
    );
  }

  @override
  int get hashCode {
    return AdditionalDataMapper.ensureInitialized().hashValue(
      this as AdditionalData,
    );
  }
}

extension AdditionalDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdditionalData, $Out> {
  AdditionalDataCopyWith<$R, AdditionalData, $Out> get $asAdditionalData =>
      $base.as((v, t, t2) => _AdditionalDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdditionalDataCopyWith<$R, $In extends AdditionalData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? billNumber,
    String? mobileNumber,
    String? storeLabel,
    String? loyaltyNumber,
    String? referenceLabel,
    String? customerLabel,
    String? terminalLabel,
    String? purpose,
    String? consumerRequest,
  });
  AdditionalDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AdditionalDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdditionalData, $Out>
    implements AdditionalDataCopyWith<$R, AdditionalData, $Out> {
  _AdditionalDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdditionalData> $mapper =
      AdditionalDataMapper.ensureInitialized();
  @override
  $R call({
    String? billNumber,
    String? mobileNumber,
    String? storeLabel,
    String? loyaltyNumber,
    String? referenceLabel,
    String? customerLabel,
    String? terminalLabel,
    String? purpose,
    String? consumerRequest,
  }) =>
      $apply(
        FieldCopyWithData({
          if (billNumber != null) #billNumber: billNumber,
          if (mobileNumber != null) #mobileNumber: mobileNumber,
          if (storeLabel != null) #storeLabel: storeLabel,
          if (loyaltyNumber != null) #loyaltyNumber: loyaltyNumber,
          if (referenceLabel != null) #referenceLabel: referenceLabel,
          if (customerLabel != null) #customerLabel: customerLabel,
          if (terminalLabel != null) #terminalLabel: terminalLabel,
          if (purpose != null) #purpose: purpose,
          if (consumerRequest != null) #consumerRequest: consumerRequest,
        }),
      );
  @override
  AdditionalData $make(CopyWithData data) => AdditionalData(
        billNumber: data.get(#billNumber, or: $value.billNumber),
        mobileNumber: data.get(#mobileNumber, or: $value.mobileNumber),
        storeLabel: data.get(#storeLabel, or: $value.storeLabel),
        loyaltyNumber: data.get(#loyaltyNumber, or: $value.loyaltyNumber),
        referenceLabel: data.get(#referenceLabel, or: $value.referenceLabel),
        customerLabel: data.get(#customerLabel, or: $value.customerLabel),
        terminalLabel: data.get(#terminalLabel, or: $value.terminalLabel),
        purpose: data.get(#purpose, or: $value.purpose),
        consumerRequest: data.get(#consumerRequest, or: $value.consumerRequest),
      );

  @override
  AdditionalDataCopyWith<$R2, AdditionalData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) =>
      _AdditionalDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
