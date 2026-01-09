import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

/// Coffee cup brand mark used across auth screens.
class CoffeeLogo extends StatelessWidget {
  const CoffeeLogo({
    super.key,
    this.size = 56,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    // Menggunakan icon PNG dari assets
    return Image.asset(
      'assets/icons/icons8-coffee-50.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback ke custom paint jika image tidak ditemukan
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            size: Size.square(size),
            painter: CoffeeCupPainter(strokeWidth: size * 0.046),
          ),
        );
      },
    );
  }
}

class CoffeeCupPainter extends CustomPainter {
  const CoffeeCupPainter({
    this.strokeWidth = 2.6,
  });

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint cupPaint = Paint()
      ..color = primaryGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Paint steamPaint = Paint()
      ..color = primaryGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.92
      ..strokeCap = StrokeCap.round;

    final Paint saucerPaint = Paint()
      ..color = beige
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 2.3
      ..strokeCap = StrokeCap.round;

    final Paint handlePaint = Paint()
      ..color = primaryGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double steamTop = centerY - size.height * 0.35;

    // Draw three steam lines above the cup.
    final leftSteam = Path()
      ..moveTo(centerX - 10, centerY - 10)
      ..quadraticBezierTo(centerX - 12, centerY - 16, centerX - 10, steamTop)
      ..quadraticBezierTo(centerX - 8, centerY - 18, centerX - 10, centerY - 14);
    canvas.drawPath(leftSteam, steamPaint);

    final centerSteam = Path()
      ..moveTo(centerX, centerY - 10)
      ..quadraticBezierTo(centerX - 2, centerY - 16, centerX, steamTop)
      ..quadraticBezierTo(centerX + 2, centerY - 18, centerX, centerY - 14);
    canvas.drawPath(centerSteam, steamPaint);

    final rightSteam = Path()
      ..moveTo(centerX + 10, centerY - 10)
      ..quadraticBezierTo(centerX + 12, centerY - 16, centerX + 10, steamTop)
      ..quadraticBezierTo(centerX + 8, centerY - 18, centerX + 10, centerY - 14);
    canvas.drawPath(rightSteam, steamPaint);

    // Draw coffee cup body (rounded rectangle shape).
    final cupPath = Path()
      ..moveTo(centerX - 14, centerY - 2)
      ..lineTo(centerX + 12, centerY - 2)
      ..lineTo(centerX + 12, centerY + 10)
      ..quadraticBezierTo(centerX + 12, centerY + 12, centerX + 10, centerY + 12)
      ..quadraticBezierTo(centerX, centerY + 12, centerX - 12, centerY + 12)
      ..quadraticBezierTo(centerX - 14, centerY + 12, centerX - 14, centerY + 10)
      ..lineTo(centerX - 14, centerY - 2)
      ..close();
    canvas.drawPath(cupPath, cupPaint);

    // Draw cup handle on the right.
    final Path handlePath = Path()
      ..moveTo(centerX + 12, centerY - 1)
      ..quadraticBezierTo(centerX + 22, centerY + 2, centerX + 13, centerY + 9)
      ..quadraticBezierTo(centerX + 18, centerY + 4, centerX + 13, centerY + 2);
    canvas.drawPath(handlePath, handlePaint);

    // Draw saucer (rounded line below cup).
    final saucerPath = Path()
      ..moveTo(centerX - 16, centerY + 14)
      ..quadraticBezierTo(centerX, centerY + 15, centerX + 16, centerY + 14);
    canvas.drawPath(saucerPath, saucerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
