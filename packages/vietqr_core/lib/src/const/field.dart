sealed class Field {
  const Field(this.id, this.description);

  final String id;
  final String description;

  @override
  String toString() => id;
}

// Main QR Code fields
enum RootField implements Field {
  version('00', 'Payload Format Indicator'),
  initiationMethod('01', 'Point of Initiation Method'),
  merchantAccount('38', 'Merchant Account Information'),
  category('52', 'Merchant Category Code'),
  currency('53', 'Transaction Currency'),
  amount('54', 'Transaction Amount'),
  tipOrConvenience('55', 'Tip or Convenience Indicator'),
  feeFixed('56', 'Value of Convenience Fee Fixed'),
  feePercentage('57', 'Value of Convenience Fee Percentage'),
  country('58', 'Country Code'),
  merchantName('59', 'Merchant Name'),
  merchantCity('60', 'Merchant City'),
  postal('61', 'Postal Code'),
  additionalData('62', 'Additional Data Field Template'),
  crc('63', 'Cyclic Redundancy Check');

  const RootField(this.id, this.description);

  @override
  final String id;
  @override
  final String description;
}

// Merchant-related fields
enum MerchantAccSubField implements Field {
  gUID('00', 'Globally Unique Identifier'),
  beneficiaryOrg('01', 'Beneficiary Organization'),
  service('02', 'Service Code'),

  // Subfields for Beneficiary Organization
  binCode('00', 'Acquirer ID/BNB ID'),
  accountNum('01', 'Merchant ID/Consumer ID');

  const MerchantAccSubField(this.id, this.description);

  @override
  final String id;
  @override
  final String description;
}

// Additional data sub fields
enum AdditionalDataSubField implements Field {
  billNumber('01', 'Bill Number'),
  mobileNumber('02', 'Mobile Number'),
  storeLabel('03', 'Store Label'),
  loyaltyNumber('04', 'Loyalty Number'),
  referenceLabel('05', 'Reference Label'),
  customerLabel('06', 'Customer Label'),
  terminalLabel('07', 'Terminal Label'),
  purpose('08', 'Purpose of Transaction'),
  consumerDataRequest('09', 'Additional Consumer Data Request');

  const AdditionalDataSubField(this.id, this.description);

  @override
  final String id;
  @override
  final String description;
}
