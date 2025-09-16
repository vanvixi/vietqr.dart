# VietQR Core

<p align="left">
  <a href="https://pub.dev/packages/vietqr_core"><img src="https://img.shields.io/pub/v/vietqr_core.svg" alt="Pub"></a>
  <a href="https://pub.dev/packages/vietqr_core/score"><img src="https://img.shields.io/pub/likes/vietqr_core?logo=dart" alt="Likes on pub.dev"></a>
  <a href="https://github.com/vanvixi/vietqr.dart"><img src="https://img.shields.io/github/stars/vanvixi/vietqr.dart.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

Ngôn ngữ: [English](README.md) | Tiếng Việt

Thư viện Dart thuần để mã hóa và giải mã dữ liệu VietQR theo chuẩn EMVCo. Gói này cung cấp các API cấp thấp để tạo mã QR thanh toán theo chuẩn VietQR, phù hợp cho cả môi trường client và server.

## Tính năng

* **Triển khai hoàn toàn bằng Dart** – Chạy được trên mọi nền tảng (di động, web, desktop, server)
* **Tuân thủ chuẩn VietQR** – Theo đúng chuẩn thanh toán QR tại Việt Nam
* **Tuân thủ chuẩn EMVCo** – Phù hợp với đặc tả mã QR của EMVCo
* **Mã hóa & Giải mã** – Hỗ trợ đầy đủ cho cả hai chức năng
* **Kiểu dữ liệu an toàn (Type-safe)** – Được kiểm tra và xác thực chặt chẽ
* **Hỗ trợ 60 ngân hàng** – Tích hợp sẵn các ngân hàng lớn tại Việt Nam
* **Mở rộng dễ dàng** – Cho phép thêm cấu hình ngân hàng tùy chỉnh
* **Tài liệu đầy đủ** – Có hướng dẫn và ví dụ chi tiết

Nếu bạn muốn cảm ơn, hãy star cho chúng tôi trên GitHub hoặc like trên pub.dev.

## Bạn đang tìm kiếm Flutter Widget?

Nếu bạn đang xây dựng ứng dụng Flutter và muốn hiển thị mã VietQR với giao diện đẹp, hãy xem [**vietqr_widget**](https://pub.dev/packages/vietqr_widget) - một Flutter widget sử dụng thư viện này để tạo mã VietQr.

## Cách sử dụng

Trước tiên, làm theo [hướng dẫn cài đặt package](https://pub.dev/packages/vietqr_core/install) và import thư viện:

### Ví dụ cơ bản

```dart
import 'package:vietqr_core/vietqr_core.dart';

// Tạo dữ liệu thanh toán VietQR
final payment = VietQrData(
  bankBinCode: SupportedBank.vietcombank,
  bankAccount: '0123456789',
  amount: '50000',
  merchantName: 'John Doe',
  merchantCity: 'Ho Chi Minh City',
  additional: const AdditionalData(
    purpose: 'Thanh toán hóa đơn #12345',
  ),
);

// Mã hóa thành chuỗi QR
final qrString = VietQr.encode(payment);
print('QR Code: $qrString');

// Giải mã chuỗi QR trở lại dữ liệu
final decodedData = VietQr.decode(qrString);
print('Số tiền: ${decodedData.amount}');
print('Ngân hàng: ${decodedData.merchantAccInfo.beneficiaryOrgData.bankBinCode}');
```

### Mã QR động (Người dùng nhập số tiền)

```dart
// Tạo QR động – người dùng sẽ nhập số tiền khi quét
final dynamicPayment = VietQrData(
  bankBinCode: SupportedBank.techcombank,
  bankAccount: '0123456789',
  merchantName: 'Quán cà phê ABC',
  merchantCity: 'Hà Nội',
  additional: const AdditionalData(
    purpose: 'Thanh toán cà phê',
    storeLabel: 'Chi nhánh #001',
  ),
);

final qrString = VietQr.encode(dynamicPayment);
```

### Sử dụng nâng cao với dữ liệu bổ sung

```dart
final detailedPayment = VietQrData(
  bankBinCode: SupportedBank.bidv,
  bankAccount: '1122334455',
  amount: '100000',
  merchantName: 'Nha hang XYZ',
  merchantCity: 'Da Nang',
  postalCode: '550000',
  additional: const AdditionalData(
    purpose: 'Thanh toan bua toi',
    billNumber: 'BILL-2024-001',
    mobileNumber: '0912345678',
    storeLabel: 'Chi nhanh chinh',
    customerLabel: 'Khach VIP',
    referenceLabel: 'REF-001',
    terminalLabel: 'POS-01',
  ),
);

final qrString = VietQr.encode(detailedPayment);
```

### Cấu hình ngân hàng tùy chỉnh

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
  merchantName: 'Cua hang Online',
  additional: const AdditionalData(
    purpose: 'Mua hang truc tuyen',
    referenceLabel: 'ORDER-789',
  ),
);
```

### Sử dụng với Flutter

#### Khuyến nghị: Sử dụng [**VietQR Widget**](https://pub.dev/packages/vietqr_widget)

Để có trải nghiệm phát triển tốt nhất với tích hợp liền mạch, chúng tôi khuyến nghị sử dụng package [**vietqr_widget**](https://pub.dev/packages/vietqr_widget) cung cấp widget Flutter sẵn dùng

#### Thay thế: Tích hợp thủ công với qr_flutter

Nếu bạn không muốn sử dụng `vietqr_widget`, đây là ví dụ đơn giản kết hợp `vietqr_core` với `qr_flutter`:

```dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vietqr_core/vietqr_core.dart';

class SimpleQrCode extends StatelessWidget {
  const SimpleQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    final payment = VietQrData(
      bankBinCode: SupportedBank.vietcombank,
      bankAccount: 'v9x',
      merchantName: 'VietQR Widget',
      merchantCity: 'Hanoi',
      additional: const AdditionalData(purpose: 'Thanh toán cà phê'),
    );

    final qrString = VietQr.encode(payment);

    return Scaffold(
      appBar: AppBar(title: Text('Thanh Toán VietQR')),
      body: Center(
        child: QrImageView(
          data: qrString,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
```

## Tài liệu tham khảo
- [Định nghĩa các trường](vietqr_field_definitions_en.md)
- [Tài liệu đặc tả kỹ thuật định dạng](https://vietqr.net/portal-service/download/documents/QR_Format_T&C_v1.5.2_EN_102022.pdf)

## Tài liệu tham khảo
- [Định nghĩa các trường](vietqr_field_definitions_en.md)
- [Tài liệu đặc tả kỹ thuật định dạng](https://vietqr.net/portal-service/download/documents/QR_Format_T&C_v1.5.2_EN_102022.pdf)

## API Reference

### VietQr Class

Class chính để mã hóa và giải mã dữ liệu VietQR.

#### Phương thức

- `VietQr.encode(VietQrData data)` → `String`
  - Mã hóa VietQrData thành chuỗi VietQR
  
- `VietQr.decode(String qrString)` → `VietQrData`
  - Giải mã chuỗi VietQR thành đối tượng VietQrData

### VietQrData Class

Đại diện cho thông tin thanh toán VietQR có kèm xác thực.

#### Hàm khởi tạo

- `VietQrData({required SupportedBank bankBinCode, required String bankAccount, ...})`
  - Tạo dữ liệu với ngân hàng hỗ trợ có sẵn
  
- `VietQrData.custom({required MerchantAccountInfoData merchantAccInfo, ...})`
  - Tạo dữ liệu với thông tin tài khoản tùy chỉnh

#### Properties

- `bankBinCode`: Mã định danh ngân hàng
- `bankAccount`: Số tài khoản thụ hưởng
- `amount`: Số tiền giao dịch (bỏ trống nếu QR động)
- `merchantName`: Tên hiển thị người nhận
- `merchantCity`: Thành phố
- `additional`: Thông tin bổ sung

### AdditionalData Class

Thông tin bổ sung cho giao dịch thanh toán.

#### Properties

- `purpose`: Mục đích thanh toán/mô tả
- `billNumber`: Hóa đơn hoặc số hóa đơn
- `mobileNumber`: Số điện thoại
- `storeLabel`: Mã chi nhánh cửa hàng
- `customerLabel`: Mã khách hàng
- `referenceLabel`: Mã tham chiếu
- `terminalLabel`: Mã thiết bị thanh toán
- `loyaltyNumber`: Mã hội viên/tích điểm

### SupportedBank Enum

Tập hợp các ngân hàng được hỗ trợ và mã BIN tương ứng.
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
- Xem danh sách đầy đủ trong [**SupportedBank**](https://github.com/vanvixi/vietqr.dart/blob/main/packages/vietqr_core/lib/src/const/supported_bank.dart) enum.

#### Phương thức

- `SupportedBank.fromBinCode(String binCode)` → `SupportedBank?`
  - Tìm ngân hàng theo mã BIN

## Kiểm tra hợp lệ

Thư viện có hệ thống kiểm tra hợp lệ mạnh mẽ:

- **Kiểm tra độ dài** của tất cả các trường
- **Kiểm tra định dạng** cho số tiền và mã
- **Kiểm tra trường bắt buộc**
- **Kiểm tra quy tắc nghiệp vụ**

Dữ liệu không hợp lệ sẽ ném các exception cụ thể:
- `InvalidDataException`
- `InvalidLengthException`
- `MaxLengthExceededCharException`
- `ChecksumException`
- `FormatException`

## Xử lý lỗi

```dart
try {
  final payment = VietQrData(
    bankBinCode: SupportedBank.vietcombank,
    bankAccount: '123', // Quá ngắn
    amount: '50000',
    merchantName: 'Test Merchant',
  );
  
  final qrString = VietQr.encode(payment);
} on VietQrException catch (e) {
  print('VietQR Error: ${e.message}');
} catch (e) {
  print('General Error: $e');
}
```

## Đóng góp

1. Fork the repository
2. Tạo nhánh mới (`git checkout -b feature/amazing-feature`)
3. Commit thay đổi (`git commit -m 'Add some amazing feature'`)
4. Push lên nhánh (`git push origin feature/amazing-feature`)
5. Mở Pull Request