enum VietQrVersion {
  v_01('01');

  const VietQrVersion(this.value);

  final String value;
}

enum PointOfInitiationMethod {
  staticQr('11'),
  dynamicQr('12');

  const PointOfInitiationMethod(this.value);

  final String value;
}

enum VietQrService {
  /// NAPAS 24/7 Fast Transfer to Account
  accountNumber('QRIBFTTA'),

  /// NAPAS 24/7 Fast Transfer to Card
  cardNumber('QRIBFTTC');

  const VietQrService(this.value);

  final String value;
}

enum VietQrCurrency {
  vnd('704');

  const VietQrCurrency(this.value);

  final String value;
}

enum TipOrConvenienceIndicator {
  /// 01 - The consumer enters the tip amount manually.
  promptForTip('01'),

  /// 02 - The merchant charges a fixed convenience fee.
  fixedFee('02'),

  /// 03 - The merchant charges a percentage-based convenience fee.
  percentageFee('03');

  final String value;

  const TipOrConvenienceIndicator(this.value);

  static TipOrConvenienceIndicator? fromValue(String value) {
    if (value.isEmpty) return null;

    for (final indicator in TipOrConvenienceIndicator.values) {
      if (indicator.value == value) {
        return indicator;
      }
    }

    return null;
  }
}
