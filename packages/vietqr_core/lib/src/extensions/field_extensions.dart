import '../const/field.dart';

extension FieldExtension on Field {
  /// Encodes field value in TLV (Tag-Length-Value) format
  String toTLV(String value) {
    final length = value.length.toString().padLeft(2, '0');
    return '$id$length$value';
  }
}
