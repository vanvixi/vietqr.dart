/// Base exception for VietQR operations
abstract class VietQrException implements Exception {
  /// Error message
  final String message;

  /// Optional inner exception
  final Object? innerException;

  const VietQrException(this.message, {this.innerException});

  @override
  String toString() {
    final buffer = StringBuffer('$runtimeType: $message');
    if (innerException != null) buffer.write(' | Inner: $innerException');
    return buffer.toString();
  }
}

/// Exception thrown for invalid input data
class InvalidDataException extends VietQrException {
  const InvalidDataException({required String message, this.fieldName = '', Object? innerException})
    : super(message, innerException: innerException);

  /// Field name that contains invalid data
  final String fieldName;

  @override
  String toString() {
    final buffer = StringBuffer('InvalidDataException: $runtimeType');
    if (fieldName.isNotEmpty) buffer.write(' Field: $fieldName');
    if (message.isNotEmpty) buffer.write(' $message');
    return buffer.toString();
  }
}

class MaxLengthExceededCharException extends InvalidDataException {
  const MaxLengthExceededCharException({
    required super.fieldName,
    required int maxLength,
    super.innerException,
  }) : super(message: 'cannot exceed $maxLength characters');
}

class InvalidLengthException extends InvalidDataException {
  const InvalidLengthException({
    required super.fieldName,
    required int length,
    super.innerException,
  }) : super(message: 'must be $length characters');
}

/// Exception thrown when checksum validation fails
class ChecksumException extends VietQrException {
  const ChecksumException(super.message, {super.innerException});
}
