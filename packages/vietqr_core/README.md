# VietQR Core

Language: English | [Tiếng Việt](README.vi.md)

A pure Dart library for encoding and decoding VietQR data according to the EMVCo standard. This package provides low-level APIs for generating VietQR-compliant payment QR codes suitable for both client and server environments.

## Features

- ✅ **Pure Dart implementation** – Works on all platforms (mobile, web, desktop, server)
- ✅ **VietQR compliant** – Follows Vietnamese QR payment standards
- ✅ **EMVCo compliant** – Adheres to EMVCo QR Code Specification
- ✅ **Encode & Decode** – Full support for encoding and decoding VietQR data
- ✅ **Type-safe** – Strong typing with comprehensive validation
- ✅ **18+ Vietnamese banks** – Built-in support for major Vietnamese banks
- ✅ **Extensible** – Easy to add custom bank configurations
- ✅ **Well-documented** – Comprehensive documentation and examples

## Supported Banks

The package includes built-in support for major Vietnamese banks:

- **Vietcombank** (970436)
- **Vietinbank** (970415)
- **BIDV** (970418)
- **Agribank** (970405)
- **Techcombank** (970407)
- **MB Bank** (970422)
- **ACB** (970416)
- **VPBank** (970432)
- **Sacombank** (970403)
- **TPBank** (970423)
- **Eximbank** (970431)
- **MSB** (970426)
- **Nam A Bank** (970428)
- **OCB** (970448)
- **SeABank** (970440)
- **LPBank** (970449)
- **VietA Bank** (970427)
- **BaoViet Bank** (970438)
- **ABBank** (970425)

## Usage

### Basic Example

```dart
import 'package:vietqr_core/vietqr_core.dart';

void main() {
  // Create VietQR payment data
  final payment = VietQrData(
    bankBinCode: SupportedBank.vietcombank,
    bankAccount: '0123456789',
    amount: '50000',
    merchantName: 'John Doe',
    merchantCity: 'Ho Chi Minh City',
    additional: const AdditionalData(
      purpose: 'Payment for invoice #12345',
    ),
  );

  // Encode to QR string
  final qrString = VietQr.encode(payment);
  print('QR Code: $qrString');

  // Decode back to data
  final decodedData = VietQr.decode(qrString);
  print('Amount: ${decodedData.amount}');
  print('Bank: ${decodedData.merchantAccInfo.beneficiaryOrgData.bankBinCode}');
}
```

### Dynamic QR (No Amount)

```dart
// Create dynamic QR where user enters amount when scanning
final dynamicPayment = VietQrData(
  bankBinCode: SupportedBank.techcombank,
  bankAccount: '9876543210',
  merchantName: 'Coffee Shop ABC',
  merchantCity: 'Hanoi',
  additional: const AdditionalData(
    purpose: 'Coffee payment',
    storeLabel: 'Store #001',
  ),
);

final qrString = VietQr.encode(dynamicPayment);
```

### Advanced Usage with Additional Data

```dart
final detailedPayment = VietQrData(
  bankBinCode: SupportedBank.bidv,
  bankAccount: '1122334455',
  amount: '100000',
  merchantName: 'Restaurant XYZ',
  merchantCity: 'Da Nang',
  postalCode: '550000',
  additional: const AdditionalData(
    purpose: 'Dinner payment',
    billNumber: 'BILL-2024-001',
    mobileNumber: '0912345678',
    storeLabel: 'Main Branch',
    customerLabel: 'VIP Customer',
    referenceLabel: 'REF-001',
    terminalLabel: 'POS-01',
  ),
);

final qrString = VietQr.encode(detailedPayment);
```

### Custom Bank Configuration

```dart
// Using custom merchant account info
final beneficiaryOrg = BeneficiaryOrgData.custom(
  bankBinCode: "970418",
  bankAccount: '5566778899',
);

final customMerchantInfo = MerchantAccountInfoData.custom(
  beneficiaryOrgData: beneficiaryOrg,
  serviceCode: VietQrService.accountNumber, // Optional
);

final payment = VietQrData.custom(
  merchantAccInfo: customMerchantInfo,
  amount: '25000',
  merchantName: 'Online Store',
  additional: const AdditionalData(
    purpose: 'Online purchase',
    referenceLabel: 'ORDER-789',
  ),
);
```
## Documentation reference
- [Field Definitions](vietqr_field_definitions_en.md)
- [Format Technical Specification](https://vietqr.net/portal-service/download/documents/QR_Format_T&C_v1.5.2_EN_102022.pdf)

## API Reference

### VietQr Class

The main class for encoding and decoding VietQR data.

#### Methods

- `VietQr.encode(VietQrData data)` → `String`
  - Encodes VietQrData into a VietQR-compliant string
  
- `VietQr.decode(String qrString)` → `VietQrData`
  - Decodes a VietQR-compliant string into VietQrData

### VietQrData Class

Represents VietQR payment information with validation.

#### Constructors

- `VietQrData({required SupportedBank bankBinCode, required String bankAccount, ...})`
  - Creates VietQrData with enum values for type safety
  
- `VietQrData.custom({required MerchantAccountInfoData merchantAccInfo, ...})`
  - Creates VietQrData with custom merchant account info

#### Properties

- `bankBinCode`: Bank identification code
- `bankAccount`: Beneficiary account number
- `amount`: Transaction amount (optional for dynamic QR)
- `merchantName`: Merchant display name
- `merchantCity`: Merchant city
- `additional`: Additional payment information

### AdditionalData Class

Contains optional additional payment information.

#### Properties

- `purpose`: Payment purpose/description
- `billNumber`: Bill or invoice number
- `mobileNumber`: Mobile phone number
- `storeLabel`: Store identifier
- `customerLabel`: Customer identifier
- `referenceLabel`: Reference number
- `terminalLabel`: Terminal identifier
- `loyaltyNumber`: Loyalty program number

### SupportedBank Enum

Enum containing supported Vietnamese banks with their BIN codes.

#### Methods

- `SupportedBank.fromBinCode(String binCode)` → `SupportedBank?`
  - Find bank by BIN code

## Validation

The library includes comprehensive validation:

- **Length validation** for all fields
- **Format validation** for amounts and codes
- **Required field validation**
- **Business rule validation**

Invalid data will throw specific exceptions:
- `InvalidDataException`
- `InvalidLengthException`
- `MaxLengthExceededCharException`
- `ChecksumException`
- `FormatException`

## Error Handling

```dart
try {
  final payment = VietQrData(
    bankBinCode: SupportedBank.vietcombank,
    bankAccount: '123', // Too short
    amount: '50000',
  );
  
  final qrString = VietQr.encode(payment);
} on VietQrException catch (e) {
  print('VietQR Error: ${e.message}');
} catch (e) {
  print('General Error: $e');
}
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request