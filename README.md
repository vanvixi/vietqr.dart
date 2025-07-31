# VietQR.dart

<p align="left">
  <a href="https://github.com/vanvixi/vietqr.dart"><img src="https://img.shields.io/github/stars/vanvixi/vietqr.dart.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/platform-flutter%20%7C%20dart%20vm%20%7C%20web-ff69b4.svg" alt="Platform"></a>
</p>

A comprehensive Dart ecosystem for **VietQR** (Vietnamese QR Payment Standard) - EMVCo compliant QR code generation, rendering, and image export.

## 🚀 Quick Start

Choose the package that fits your needs:

- **Flutter App**: Use [vietqr_widget](packages/vietqr_widget) for beautiful QR UI widgets
- **Image Generation**: Use [vietqr_image](packages/vietqr_image) for PNG/JPEG export  
- **Core Logic**: Use [vietqr_core](packages/vietqr_core) for encoding/decoding

```yaml
dependencies:
  vietqr_widget: ^0.1.1    # Flutter UI widgets
  vietqr_image: ^0.1.0     # Image generation  
  vietqr_core: ^0.2.3      # Core encoding/decoding
```

## 📦 Packages Overview

This monorepo contains three complementary packages that work together to provide a complete VietQR solution:

### 🧠 [vietqr_core](packages/vietqr_core)
[![Pub Version](https://img.shields.io/pub/v/vietqr_core.svg)](https://pub.dev/packages/vietqr_core)

**The foundation** - Pure Dart library for VietQR data encoding and decoding.

- ✅ **Pure Dart** - Works everywhere (Flutter, web, server, CLI)
- ✅ **18+ Vietnamese banks** - Built-in support for major banks
- ✅ **EMVCo compliant** - Follows international standards
- ✅ **Type-safe** - Strong typing with validation
- ✅ **Encode & Decode** - Full bidirectional support

```dart
import 'package:vietqr_core/vietqr_core.dart';

final payment = VietQrData(
  bankBinCode: SupportedBank.vietcombank,
  bankAccount: '0123456789',
  amount: '50000',
  merchantName: 'Coffee Shop',
);

final qrString = VietQr.encode(payment);
```

### 🎨 [vietqr_widget](packages/vietqr_widget)
[![Pub Version](https://img.shields.io/pub/v/vietqr_widget.svg)](https://pub.dev/packages/vietqr_widget)

**For Flutter apps** - Beautiful, customizable QR code widgets.

- ✅ **Easy Integration** - Drop-in Flutter widget
- ✅ **Customizable** - Colors, embedded images, error handling
- ✅ **Responsive** - Adapts to different screen sizes
- ✅ **Built-in validation** - Automatic error handling

```dart
import 'package:vietqr_widget/vietqr_widget.dart';

VietQrWidget(
  data: payment,
  embeddedImage: EmbeddedImage(
    image: AssetImage('assets/logo.png'),
  ),
)
```

### 🖼️ [vietqr_image](packages/vietqr_image)
[![Pub Version](https://img.shields.io/pub/v/vietqr_image.svg)](https://pub.dev/packages/vietqr_image)

**For image generation** - Export QR codes as PNG, JPEG, or other formats.

- ✅ **Multiple formats** - PNG, JPEG, WebP support
- ✅ **Server-side** - Perfect for backend services
- ✅ **Customizable** - Size, colors, error correction
- ✅ **Memory efficient** - Optimized for batch processing

```dart
import 'package:vietqr_image/vietqr_image.dart';

final imageBytes = await VietQrImage.generatePng(
  data: payment,
  size: 512,
);
```

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   vietqr_widget │    │   vietqr_image  │    │     Your App    │
│                 │    │                 │    │                 │
│  Flutter UI     │    │  Image Export   │    │   Custom Logic  │
│  Components     │    │  PNG/JPEG/etc   │    │                 │
└─────────┬───────┘    └─────────┬───────┘    └─────────┬───────┘
          │                      │                      │
          └──────────────────────┼──────────────────────┘
                                 │
                   ┌─────────────▼───────────┐
                   │       vietqr_core       │
                   │                         │
                   │  • VietQR Encoding      │
                   │  • VietQR Decoding      │
                   │  • Bank Support         │
                   │  • Data Validation      │
                   │  • EMVCo Compliance     │
                   └─────────────────────────┘
```

## 🏦 Supported Banks

All packages support 18+ major Vietnamese banks including:

| Bank | BIN Code | Bank | BIN Code |
|------|----------|------|----------|
| Vietcombank | 970436 | MB Bank | 970422 |
| Vietinbank | 970415 | ACB | 970416 |
| BIDV | 970418 | VPBank | 970432 |
| Agribank | 970405 | Sacombank | 970403 |
| Techcombank | 970407 | TPBank | 970423 |

[View all supported banks →](packages/vietqr_core/README.md#supported-banks)

## 🌟 Use Cases

### 🏪 **E-commerce & Retail**
```dart
// Dynamic QR for product checkout
final productPayment = VietQrData(
  bankBinCode: SupportedBank.techcombank,
  bankAccount: 'STORE123456',
  merchantName: 'Online Store',
  additional: AdditionalData(
    purpose: 'Product purchase',
    referenceLabel: 'ORDER-${orderId}',
  ),
);
```

### 🍕 **Restaurants & Food Service**  
```dart
// Table-specific QR codes
final tablePayment = VietQrData(
  bankBinCode: SupportedBank.vietcombank,
  bankAccount: '0123456789',
  merchantName: 'Pho Restaurant',
  additional: AdditionalData(
    purpose: 'Table payment',
    storeLabel: 'Table ${tableNumber}',
  ),
);
```

### 💼 **Business Invoicing**
```dart
// Invoice payment QR
final invoicePayment = VietQrData(
  bankBinCode: SupportedBank.bidv,
  bankAccount: 'COMPANY789',
  amount: '1500000',
  merchantName: 'ABC Company Ltd',
  additional: AdditionalData(
    purpose: 'Invoice payment',
    billNumber: 'INV-2024-001',
    customerLabel: 'Client XYZ',
  ),
);
```

### 🎫 **Event & Ticketing**
```dart
// Event ticket payment
final ticketPayment = VietQrData(
  bankBinCode: SupportedBank.mbbank,
  bankAccount: 'EVENT456789',
  amount: '299000',
  merchantName: 'Concert Venue',
  additional: AdditionalData(
    purpose: 'Concert ticket',
    referenceLabel: 'TICKET-${ticketId}',
  ),
);
```

## 🔧 Development

This project uses [Melos](https://melos.invertase.dev/) for monorepo management.

```bash
# Install Melos
dart pub global activate melos

# Bootstrap the workspace
melos bootstrap

# Run tests for all packages
melos test

# Publish all packages
melos publish
```

### Package Commands

```bash
# Core package
cd packages/vietqr_core
dart test

# Widget package  
cd packages/vietqr_widget
flutter test

# Image package
cd packages/vietqr_image
dart test
```

## 📚 Documentation

- [**vietqr_core**](packages/vietqr_core/README.md) - Core encoding/decoding documentation
- [**vietqr_widget**](packages/vietqr_widget/README.md) - Flutter widget usage guide  
- [**vietqr_image**](packages/vietqr_image/README.md) - Image generation examples

### Technical References
- [VietQR Field Definitions](packages/vietqr_core/vietqr_field_definitions_en.md)
- [EMVCo QR Code Specification](https://vietqr.net/portal-service/download/documents/QR_Format_T&C_v1.5.2_EN_102022.pdf)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


<p align="center">
  <strong>Made with ❤️ for the Vietnamese developer community</strong>
</p>

<p align="center">
  If you find this project helpful, please give it a ⭐ on GitHub!
</p>