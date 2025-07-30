import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class EmbeddedImage extends PrettyQrDecorationImage {
  EmbeddedImage({
    required super.image,
    super.scale = 0.2,
    super.onError,
    super.colorFilter,
    super.fit,
    super.repeat = ImageRepeat.noRepeat,
    super.matchTextDirection = false,
    super.opacity = 1.0,
    super.filterQuality = FilterQuality.low,
    super.invertColors = false,
    super.isAntiAlias = false,
  }) : super(
          padding: EdgeInsets.zero,
          position: PrettyQrDecorationImagePosition.embedded,
        );
}
