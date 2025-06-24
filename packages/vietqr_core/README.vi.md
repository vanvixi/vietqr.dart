# VietQR Core

Ngôn ngữ: [English](README.md) | Tiếng Việt

Thư viện Dart thuần để mã hóa và giải mã dữ liệu VietQR theo chuẩn EMVCo. Gói này cung cấp các API cấp thấp để tạo mã QR thanh toán theo chuẩn VietQR, phù hợp cho cả môi trường client và server.

## Tính năng

- ✅ **Triển khai hoàn toàn bằng Dart** – Chạy được trên mọi nền tảng (di động, web, desktop, server)
- ✅ **Tuân thủ chuẩn VietQR** – Theo đúng chuẩn thanh toán QR tại Việt Nam
- ✅ **Tuân thủ chuẩn EMVCo** – Phù hợp với đặc tả mã QR của EMVCo
- ✅ **Mã hóa & Giải mã** – Hỗ trợ đầy đủ cho cả hai chức năng
- ✅ **Kiểu dữ liệu an toàn (Type-safe)** – Được kiểm tra và xác thực chặt chẽ
- ✅ **Hỗ trợ 18+ ngân hàng** – Tích hợp sẵn các ngân hàng lớn tại Việt Nam
- ✅ **Mở rộng dễ dàng** – Cho phép thêm cấu hình ngân hàng tùy chỉnh
- ✅ **Tài liệu đầy đủ** – Có hướng dẫn và ví dụ chi tiết

## Các ngân hàng được hỗ trợ

Gói thư viện đã tích hợp sẵn các ngân hàng phổ biến tại Việt Nam:

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

## Cách sử dụng

### Ví dụ cơ bản

```dart
import 'package:vietqr_core/vietqr_core.dart';

void main() {
  // Tạo dữ liệu thanh toán VietQR
  final payment = VietQrData(
    bankBinCode: SupportedBank.vietcombank,
    bankAccount: '0123456789',
    amount: '50000',
    merchantName: 'John Doe',
    merchantCity: 'Ho Chi Minh City',
    additional: const AdditionalData(
      purpose: 'Thanh toan hoa don #12345',
    ),
  );

  // Mã hóa thành chuỗi QR
  final qrString = VietQr.encode(payment);
  print('QR Code: $qrString');

  // Giải mã chuỗi QR trở lại dữ liệu
  final decodedData = VietQr.decode(qrString);
  print('Số tiền: ${decodedData.amount}');
  print('Ngân hàn: ${decodedData.merchantAccInfo.beneficiaryOrgData.bankBinCode}');
}
```

### Mã QR động (Không có số tiền cố định)

```dart
// Tạo QR động – người dùng sẽ nhập số tiền khi quét
final dynamicPayment = VietQrData(
  bankBinCode: SupportedBank.techcombank,
  bankAccount: '9876543210',
  merchantName: 'Quan ca phe ABC',
  merchantCity: 'Hanoi',
  additional: const AdditionalData(
    purpose: 'Thanh toan ca phe',
    storeLabel: 'Chi nhanh #001',
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

#### Phương thức

- `SupportedBank.fromBinCode(String binCode)` → `SupportedBank?`
  - Tìm ngân hàng theo mã BIN

## Kiểm tra hợp lệ

Thư viện có hệ thống kiểm tra hợp lệ mạnh mẽ:

- **Kiểm tra độ dài** của tất cả các trường
- **Kiểm tra định dạng** cho số tiền và mã
- **Kiểm tra trường bắt buộcn**
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