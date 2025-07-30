import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:vietqr_core/vietqr_core.dart';
import 'package:vietqr_widget/src/types/embedded_image.dart';

class VietQrWidget extends StatefulWidget {
  const VietQrWidget({
    super.key,
    required this.data,
    this.background,
    this.embeddedImage,
    this.errorBuilder,
  });

  /// VietQR data to encode and validate.
  final VietQrData data;

  /// Background color for the QR code.
  final Color? background;

  /// Image to embed in the center of the QR code.
  final EmbeddedImage? embeddedImage;

  /// Error builder to customize error display.
  final ImageErrorWidgetBuilder? errorBuilder;

  @override
  State<VietQrWidget> createState() => _VietQrWidgetState();
}

class _VietQrWidgetState extends State<VietQrWidget> {
  String qrString = "";
  Object? error;
  StackTrace? stackTrace;

  @override
  void initState() {
    _encodeData();
    super.initState();
  }

  @override
  void didUpdateWidget(VietQrWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _encodeData();
    }
  }

  void _encodeData() {
    try {
      qrString = VietQr.encode(widget.data);
      error = null;
    } on VietQrException catch (e, st) {
      error = e;
      stackTrace = st;
      qrString = "";
    } catch (e, st) {
      error = e;
      stackTrace = st;
      qrString = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, error!, stackTrace);
      }
      return const Icon(
        Icons.error_outline,
        color: Colors.red,
      );
    }

    return PrettyQrView.data(
      data: qrString,
      errorCorrectLevel: QrErrorCorrectLevel.M,
      decoration: PrettyQrDecoration(
          image: widget.embeddedImage,
          background: widget.background,
          shape: const PrettyQrRoundedSymbol(borderRadius: BorderRadius.zero)),
      errorBuilder: widget.errorBuilder,
    );
  }
}
