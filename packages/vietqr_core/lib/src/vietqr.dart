import 'package:vietqr_core/src/core/vietqr_decoder.dart';
import 'package:vietqr_core/src/models/vietqr_data.dart';

import 'core/vietqr_encoder.dart';

class VietQr {
  const VietQr._();

  /// Encode [VietQrData] into a VietQR-compliant string.
  static String encode(VietQrData data) {
    return VietQrEncoder.encodePaymentQr(data);
  }

  /// Decode a VietQR-compliant string into a [VietQrData] object.
  static VietQrData decode(String qrString) {
    return VietQrDecoder.decodePaymentQr(qrString);
  }
}
