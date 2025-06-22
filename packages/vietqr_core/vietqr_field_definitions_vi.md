# Định nghĩa các Trường Dữ liệu trong Mã QR VietQR

Mỗi trường dữ liệu trong mã QR VietQR bao gồm:

- **ID**: Mã định danh trường
- **Độ dài**: Độ dài cố định hoặc tối đa
- **Định dạng**: N (số), S (chuỗi), ANS (chữ + số + ký tự đặc biệt)
- **Tính bắt buộc**: M (Bắt buộc), C (Có điều kiện), O (Không bắt buộc)
- **Ghi chú**: Mô tả ngắn về ý nghĩa trường

### I. Các Trường Dữ liệu Gốc (Root-Level)

| ID    | Tên Trường                      | Độ dài | Định dạng | Bắt buộc | Ghi chú                                    |
|-------|---------------------------------|--------|-----------|----------|--------------------------------------------|
| 00    | Phiên bản dữ liệu               | 02     | N         | M        | Mặc định là "01"                           |
| 01    | Phương thức khởi tạo            | 02     | N         | M        | "11" - tĩnh, "12" - động                   |
| 38    | Thông tin định danh ĐVCNTT      | ≤99    | S         | M        | Chứa các trường con (xem bên dưới)         |
| 52    | Mã danh mục ĐVCNTT              | 04     | N         | O        | Theo chuẩn ISO 18245                       |
| 53    | Mã tiền tệ                      | 03     | N         | M        | ISO 4217, "704" = VND                      |
| 54    | Số tiền giao dịch               | ≤13    | S         | C        | Chỉ dùng cho mã QR động                    |
| 55    | Chỉ thị tip/phí                 | 02     | N         | O        | "01", "02", "03"                           |
| 56    | Phí cố định                     | ≤13    | S         | C        | Nếu ID 55 = "02"                           |
| 57    | Phí theo %                      | ≤05    | S         | C        | Nếu ID 55 = "03"                           |
| 58    | Mã quốc gia                     | 02     | S         | M        | "VN" cho Việt Nam                          |
| 59    | Tên ĐVCNTT                      | ≤25    | ANS       | O        |                                            |
| 60    | Thành phố                       | ≤15    | ANS       | O        |                                            |
| 61    | Mã bưu điện                     | ≤10    | ANS       | O        |                                            |
| 62    | Thông tin bổ sung               | ≤99    | ANS       | C        | Có thể chứa các trường con                 |
| 64    | Ngôn ngữ thay thế               | ≤99    | ANS       | O        | Có thể chứa các trường con                 |
| 65–79 | RFU bởi EMVCo                   | ≤99    | ANS       | O        | Dành cho sử dụng tương lai                 |
| 80–99 | Thông tin bổ sung không đăng ký | ≤99    | ANS       | O        | Có thể chứa GUID và dữ liệu phạm vi cụ thể |
| 63    | CRC                             | 04     | ANS       | M        | Luôn là trường cuối cùng                   |

### II. Trường con của ID "38" – Thông tin ĐVCNTT

| ID | Tên Trường                 | Độ dài | Bắt buộc | Ghi chú                 |
|----|----------------------------|--------|----------|-------------------------|
| 00 | GUID                       | ≤32    | M        | "A000000727"            |
| 01 | Tổ chức thụ hưởng          | --     | M        | Gồm 2 subfield bên dưới |
|    | └ 00: Acquirer ID          | 06     | M        | Mã BIN ngân hàng        |
|    | └ 01: Merchant/Consumer ID | ≤19    | M        | Số tài khoản / MST      |
| 02 | Mã dịch vụ                 | ≤10    | C        | "QRIBFTTC", "QRIBFTTA"  |

### III. Trường con của ID "62" – Thông tin bổ sung

| ID    | Tên Trường                           | Độ dài   | Ghi chú                              |
|-------|--------------------------------------|----------|--------------------------------------|
| 01    | Số hóa đơn                           | ≤25      |                                      |
| 02    | Số điện thoại di động                | ≤25      |                                      |
| 03    | Mã cửa hàng                          | ≤25      |                                      |
| 04    | Mã KH thân thiết                     | ≤25      |                                      |
| 05    | Mã tham chiếu                        | ≤25      |                                      |
| 06    | Mã khách hàng                        | ≤25      |                                      |
| 07    | Mã số điểm bán hàng                  | ≤25      |                                      |
| 08    | Mục đích giao dịch                   | ≤25      |                                      |
| 09    | Yêu cầu dữ liệu KH bổ sung           | ≤03      | "A", "M", "E"                        |
| 10–49 | RFU bởi EMVCo                        | Tùy chọn |                                      |
| 50–99 | Template đặc thù hệ thống thanh toán | Tùy chọn | Có GUID (ID 00) & dữ liệu (ID 01–99) |

### IV. Trường con của ID "64" – Ngôn ngữ thay thế

| ID    | Tên Trường                     | Độ dài   | Bắt buộc | Ghi chú |
|-------|--------------------------------|----------|----------|---------|
| 00    | Ngôn ngữ ưu tiên               | 02       | M        |         |
| 01    | Tên ĐVCNTT (ngôn ngữ thay thế) | ≤25      | M        |         |
| 02    | Thành phố (ngôn ngữ thay thế)  | ≤15      | O        |         |
| 03–99 | RFU bởi EMVCo                  | Tùy chọn |          |         |
