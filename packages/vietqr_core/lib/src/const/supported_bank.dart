/// Vietnamese bank codes (BIN codes) for major banks
enum SupportedBank {
  vietinbank('970415', 'Vietinbank'),
  vietcombank('970436', 'Vietcombank'),
  bidv('970418', 'BIDV'),
  agribank('970405', 'Agribank'),
  techcombank('970407', 'Techcombank'),
  mbbank('970422', 'MB Bank'),
  acb('970416', 'ACB'),
  vpbank('970432', 'VPBank'),
  sacombank('970403', 'Sacombank'),
  tpbank('970423', 'TPBank'),
  eximbank('970431', 'Eximbank'),
  msb('970426', 'MSB'),
  namabank('970428', 'Nam A Bank'),
  ocb('970448', 'OCB'),
  seabank('970440', 'SeABank'),
  lpbank('970449', 'LPBank'),
  vietabank('970427', 'VietA Bank'),
  baovietbank('970438', 'BaoViet Bank'),
  abbank('970425', 'ABBank'),
  dongabank('970406', 'DongA Bank'),
  oceanbank('970414', 'OceanBank'),
  ncb('970419', 'NCB'),
  shb('970443', 'SHB'),
  vib('970441', 'VIB'),
  hdbank('970437', 'HDBank'),
  scb('970429', 'SCB'),
  vietbank('970433', 'VietBank'),
  vietcapitalbank('970454', 'VietCapital Bank'),
  kienlongbank('970452', 'KienLongBank'),
  pgbank('970430', 'PGBank'),
  saigonbank('970400', 'SaigonBank'),
  pvcombank('970412', 'PVcomBank'),
  vrb('970421', 'VRB'),
  indovinabank('970434', 'Indovina Bank'),
  wooribank('970457', 'Woori Bank'),
  publicbank('970439', 'Public Bank Vietnam'),
  hongleongbank('970442', 'Hong Leong Bank'),
  shinhanbank('970424', 'Shinhan Bank Vietnam'),
  ibkHanoi('970455', 'IBK Hanoi'),
  ibkHCM('970456', 'IBK Ho Chi Minh'),
  cimb('422589', 'CIMB Bank'),
  uob('970458', 'UOB'),
  hsbc('458761', 'HSBC Vietnam'),
  standardchartered('970410', 'Standard Chartered Vietnam'),
  dbs('796500', 'DBS Bank'),
  kbank('668888', 'KasikornBank'),
  vbsp('999888', 'VBSP'),
  kebHanaHanoi('970467', 'KEB Hana Hanoi'),
  kebHanaHCM('970466', 'KEB Hana HCM'),
  liobank('963369', 'Liobank'),
  citibank('533948', 'Citibank Vietnam'),
  gpbank('970408', 'GPBank'),
  bacabank('970409', 'BacABank'),

  // Non-bank financial institutions
  vnptMoney('971011', 'VNPT Money'),
  mafc('977777', 'Mirae Asset Finance'),
  mcredit('970470', 'Mcredit');

  const SupportedBank(this.binCode, this.displayName);

  /// Bank Identification Number (BIN) code
  final String binCode;

  /// Human-readable bank name
  final String displayName;

  /// Find bank by BIN code
  static SupportedBank? fromBinCode(String binCode) {
    for (final bank in SupportedBank.values) {
      if (bank.binCode == binCode) return bank;
    }
    return null;
  }

  @override
  String toString() => 'BIN: $binCode, Name: $displayName';
}
