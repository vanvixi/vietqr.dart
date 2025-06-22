# Data Field Definitions in VietQR Code

Each data object in a VietQR code includes:

- **ID**: Field identifier
- **Length**: Fixed or maximum
- **Format**: N (numeric), S (string), ANS (alphanumeric + symbols)
- **Required**: M (Mandatory), C (Conditional), O (Optional)
- **Notes**: Description

### I. Root-Level Data Fields

| ID    | Field Name                                  | Length | Format | Required | Notes                           |
|-------|---------------------------------------------|--------|--------|----------|---------------------------------|
| 00    | Payload Format Indicator                    | 02     | N      | M        | Default "01"                    |
| 01    | Point of Initiation Method                  | 02     | N      | M        | "11" - static, "12" - dynamic   |
| 38    | Merchant Account Information                | ≤99    | S      | M        | Contains child fields           |
| 52    | Merchant Category Code                      | 04     | N      | O        | ISO 18245                       |
| 53    | Transaction Currency                        | 03     | N      | M        | ISO 4217, "704" = VND           |
| 54    | Transaction Amount                          | ≤13    | S      | C        | For dynamic QR only             |
| 55    | Tip/Convenience Indicator                   | 02     | N      | O        | "01", "02", or "03"             |
| 56    | Fixed Fee Value                             | ≤13    | S      | C        | If ID 55 = "02"                 |
| 57    | Percentage Fee Value                        | ≤05    | S      | C        | If ID 55 = "03"                 |
| 58    | Country Code                                | 02     | S      | M        | "VN" for Vietnam                |
| 59    | Merchant Name                               | ≤25    | ANS    | O        |                                 |
| 60    | Merchant City                               | ≤15    | ANS    | O        |                                 |
| 61    | Postal Code                                 | ≤10    | ANS    | O        |                                 |
| 62    | Additional Data Field Template              | ≤99    | ANS    | C        | Contains child fields           |
| 64    | Merchant Info - Alternate Language Template | ≤99    | ANS    | O        | Contains child fields           |
| 65–79 | RFU by EMVCo                                | ≤99    | ANS    | O        | Reserved for future use         |
| 80–99 | Unreserved Templates                        | ≤99    | ANS    | O        | May contain GUID & context data |
| 63    | CRC                                         | 04     | ANS    | M        | Always the last field           |

### II. Child Fields of ID "38" – Merchant Account Information

| ID | Field Name                 | Length | Required | Notes                        |
|----|----------------------------|--------|----------|------------------------------|
| 00 | GUID                       | ≤32    | M        | "A000000727"                 |
| 01 | Beneficiary Org            | --     | M        | Includes two subfields below |
|    | └ 00: Acquirer ID          | 06     | M        | Bank BIN                     |
|    | └ 01: Merchant/Consumer ID | ≤19    | M        | Account number or tax code   |
| 02 | Service Code               | ≤10    | C        | "QRIBFTTC" or "QRIBFTTA"     |

### III. Child Fields of ID "62" – Additional Data Field

| ID    | Field Name                        | Length   | Notes                                         |
|-------|-----------------------------------|----------|-----------------------------------------------|
| 01    | Bill Number                       | ≤25      |                                               |
| 02    | Mobile Number                     | ≤25      |                                               |
| 03    | Store Label                       | ≤25      |                                               |
| 04    | Loyalty Number                    | ≤25      |                                               |
| 05    | Reference Label                   | ≤25      |                                               |
| 06    | Customer Label                    | ≤25      |                                               |
| 07    | Terminal Label                    | ≤25      |                                               |
| 08    | Purpose of Transaction            | ≤25      |                                               |
| 09    | Additional Consumer Data Request  | ≤03      | e.g. "A", "M", "E"                            |
| 10–49 | RFU by EMVCo                      | Optional |                                               |
| 50–99 | Payment system-specific templates | Optional | Includes GUID (ID 00) and data fields (01–99) |

### IV. Child Fields of ID "64" – Alternate Language

| ID    | Field Name                         | Length   | Required | Notes |
|-------|------------------------------------|----------|----------|-------|
| 00    | Language Preference                | 02       | M        |       |
| 01    | Merchant Name (Alternate Language) | ≤25      | M        |       |
| 02    | Merchant City (Alternate Language) | ≤15      | O        |       |
| 03–99 | RFU by EMVCo                       | Optional |          |       |
