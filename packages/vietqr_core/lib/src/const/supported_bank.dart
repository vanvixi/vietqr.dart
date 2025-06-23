/// Vietnamese bank codes (BIN codes) for major banks
enum SupportedBank {
  /// Vietnam Joint Stock Commercial Bank for Industry and Trade (Ngân hàng TMCP Công Thương Việt Nam)
  vietinbank('970415', 'Vietinbank'),

  /// Joint Stock Commercial Bank For Foreign Trade Of Vietnam (Ngân hàng TMCP Ngoại thương Việt Nam)
  vietcombank('970436', 'Vietcombank'),

  /// Joint Stock Commercial Bank for Investment and Development of Vietnam (Ngân hàng TMCP Đầu tư và Phát triển Việt Nam)
  bidv('970418', 'BIDV'),

  /// Vietnam Bank for Agriculture and Rural Development (Ngân hàng Nông nghiệp và Phát triển Nông thôn Việt Nam)
  agribank('970405', 'Agribank'),

  /// Vietnam Technological and Commercial Joint Stock Bank (Ngân hàng TMCP Kỹ thương Việt Nam)
  techcombank('970407', 'Techcombank'),

  /// Military Commercial Joint Stock Bank (Ngân hàng TMCP Quân đội)
  mbbank('970422', 'MB Bank'),

  /// Asia Commercial Joint Stock Bank (Ngân hàng TMCP Á Châu)
  acb('970416', 'ACB'),

  /// Vietnam Prosperity Joint stock Commercial Bank – Thuong Tin Branch (Ngân hàng TMCP Việt Nam Thịnh Vượng)
  vpbank('970432', 'VPBank'),

  /// Saigon Thuong Tin Commercial Joint Stock Bank (Ngân hàng TMCP Sài Gòn Thương Tín)
  sacombank('970403', 'Sacombank'),

  /// Tien Phong Commercial Joint Stock Bank (Ngân hàng TMCP Tiên Phong)
  tpbank('970423', 'TPBank'),

  /// Vietnam Export Import Commercial Joint - Stock Bank (Ngân hàng TMCP Xuất Nhập khẩu Việt Nam)
  eximbank('970431', 'Eximbank'),

  /// Vietnam Maritime Commercial Joint Stock Bank (Ngân hàng TMCP Hàng Hải)
  msb('970426', 'MSB'),

  /// Nam A Commercial Joint Stock Bank (Ngân hàng TMCP Nam Á)
  namabank('970428', 'Nam A Bank'),

  /// Orient Commercial Joint Stock Bank (Ngân hàng TMCP Phương Đông)
  ocb('970448', 'OCB'),

  /// Southeast Asia Commercial Joint Stock Bank (Ngân hàng TMCP Đông Nam Á)
  seabank('970440', 'SeABank'),

  /// Fortune Vietnam Joint Stock Commercial Bank (Ngân hàng TMCP Bưu Điện Liên Việt)
  lpbank('970449', 'LPBank'),

  /// Vietnam Asia Commercial Joint Stock Bank (Ngân hàng TMCP Việt Á)
  vietabank('970427', 'VietA Bank'),

  /// Bao Viet Joint Stock Commercial Bank (Ngân hàng TMCP Bảo Việt)
  baovietbank('970438', 'BaoViet Bank'),

  /// An Binh Commercial Joint Stock Bank (Ngân hàng TMCP An Bình)
  abbank('970425', 'ABBank');

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
  String toString() => displayName;
}
