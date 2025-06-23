const String kNapasAID = 'A000000727';
const String kDefaultCountryCode = 'VN';

// Placeholder for CRC checksum in the QR code string
const String kCRC = '6304';

// Validation constants
const int kVersionLength = 2;
const int kMethodLength = 2;
const int kCurrencyLength = 3;
const int kAmountMaxLength = 13;
const int kCountryCodeLength = 2;
const int kBankBinCodeLength = 6;
const int kBankAccountMaxLength = 19;
const int kServiceCodeMaxLength = 10;
const int kMerchantGUidLength = 32;
const int kMerchantCategoryLength = 4;
const int kMerchantNameMaxLength = 25;
const int kMerchantCityMaxLength = 15;
const int kTipOrConvenienceLength = 2;
const int kFeeFixedMaxLength = 13;
const int kFeePercentageMaxLength = 5;
const int kPostalCodeMaxLength = 10;
const int kAdditionalMaxLength = 25;
const int kAdditionalRequestMaxLength = 3;
const int kQrStringMinLength = 50;

// CRC constants
const int kCRCPolynomial = 0x1021;
const int kCRCInitialValue = 0xFFFF;
const int kCRCChecksumLength = 4;
