import 'dart:convert';

import '../const/const.dart';

class CRC16Util {
  /// Cache for CRC lookup table to improve performance
  static final List<int> _crcTable = _generateCrcTable();

  /// Optimized CRC16 calculation using lookup table
  static String calculateChecksum(String payload) {
    final bytes = utf8.encode(payload);
    int crc = kCRCInitialValue;

    for (final byte in bytes) {
      final tableIndex = ((crc >> 8) ^ byte) & 0xFF;
      crc = ((crc << 8) ^ _crcTable[tableIndex]) & 0xFFFF;
    }

    return crc.toRadixString(16).toUpperCase().padLeft(kCRCChecksumLength, '0');
  }

  /// Generate CRC lookup table for optimized calculation
  static List<int> _generateCrcTable() {
    final table = List<int>.filled(256, 0);

    for (int i = 0; i < 256; i++) {
      int crc = i << 8;
      for (int j = 0; j < 8; j++) {
        if ((crc & 0x8000) != 0) {
          crc = (crc << 1) ^ kCRCPolynomial;
        } else {
          crc <<= 1;
        }
        crc &= 0xFFFF;
      }
      table[i] = crc;
    }

    return table;
  }
}
