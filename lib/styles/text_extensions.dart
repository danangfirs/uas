import 'package:flutter/material.dart';
import 'text_styles.dart';

/// Extension untuk memudahkan akses style teks melalui BuildContext
/// 
/// Contoh penggunaan:
/// Text('Hello', style: context.ombHeadingLarge())
/// Text('Body', style: context.ombBodyMedium())
extension OmbeTextStylesExtension on BuildContext {
  // Heading styles
  TextStyle ombHeadingLarge() => OmbeTextStyles.headingLarge;
  TextStyle ombHeadingMedium() => OmbeTextStyles.headingMedium;
  TextStyle ombHeadingSmall() => OmbeTextStyles.headingSmall;

  // Body styles
  TextStyle ombBodyLarge() => OmbeTextStyles.bodyLarge;
  TextStyle ombBodyMedium() => OmbeTextStyles.bodyMedium;
  TextStyle ombBodySmall() => OmbeTextStyles.bodySmall;

  // Subtitle styles
  TextStyle ombSubtitleLarge() => OmbeTextStyles.subtitleLarge;
  TextStyle ombSubtitleMedium() => OmbeTextStyles.subtitleMedium;
  TextStyle ombSubtitleSmall() => OmbeTextStyles.subtitleSmall;

  // Button styles
  TextStyle ombButtonLarge() => OmbeTextStyles.buttonLarge;
  TextStyle ombButtonMedium() => OmbeTextStyles.buttonMedium;
  TextStyle ombButtonSmall() => OmbeTextStyles.buttonSmall;

  // Label styles
  TextStyle ombLabelMedium() => OmbeTextStyles.labelMedium;
  TextStyle ombLabelSmall() => OmbeTextStyles.labelSmall;
}

