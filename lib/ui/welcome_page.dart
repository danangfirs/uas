import 'package:flutter/material.dart';

import '../styles/text_styles.dart';
import '../widgets/coffee_logo.dart';
import 'login_page.dart';

const double _contentMaxWidth = 420;

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      const CoffeeLogo(size: 92),
                      const SizedBox(height: 18),
                      const Text(
                        'Ombe',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Coffee Shop App',
                        style: TextStyle(
                          fontSize: 18,
                          color: subtitleColor,
                        ),
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'Morning begins with Ombe coffee',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight > 640 ? 120 : 80),
                      _WelcomeButton(
                        backgroundColor: primaryGreen,
                        textColor: Colors.white,
                        leading: const Icon(Icons.mail_outlined, size: 26, color: Colors.white),
                        label: 'Login With Email',
                        onPressed: () => Navigator.of(context).pushNamed(LoginPage.routeName),
                      ),
                      const SizedBox(height: 18),
                      _WelcomeButton(
                        backgroundColor: const Color(0xFF3563E9),
                        textColor: Colors.white,
                        leading: const _FacebookIcon(),
                        label: 'Login With Facebook',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 18),
                      _WelcomeButton(
                        backgroundColor: Colors.white,
                        borderColor: const Color(0xFFDDDDDD),
                        textColor: primaryGreen,
                        leading: const _GoogleGIcon(),
                        label: 'Login With Google',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  const _WelcomeButton({
    required this.label,
    required this.onPressed,
    required this.leading,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Widget leading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackground = backgroundColor ?? Colors.white;
    final Color resolvedText = textColor ?? Colors.black87;

    return SizedBox(
      width: double.infinity,
      height: 66,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedBackground,
          foregroundColor: resolvedText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(color: borderColor ?? Colors.transparent, width: 1.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading,
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ).copyWith(color: resolvedText),
            ),
          ],
        ),
      ),
    );
  }
}

class _FacebookIcon extends StatelessWidget {
  const _FacebookIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.facebook,
        size: 22,
        color: Color(0xFF1877F2),
      ),
    );
  }
}

class _GoogleGIcon extends StatelessWidget {
  const _GoogleGIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CustomPaint(
        painter: _GoogleGPainter(),
      ),
    );
  }
}

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = size.width * 0.2;
    final Rect arcRect = Rect.fromLTWH(
      strokeWidth * 0.75,
      strokeWidth * 0.75,
      size.width - strokeWidth * 1.5,
      size.height - strokeWidth * 1.5,
    );

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(arcRect, -0.1, 1.6, false, paint);

    paint.color = const Color(0xFF34A853);
    canvas.drawArc(arcRect, 1.5, 1.1, false, paint);

    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(arcRect, 2.6, 1.1, false, paint);

    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(arcRect, 3.7, 1.4, false, paint);

    final Paint barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.55, size.height * 0.52),
      Offset(size.width * 0.82, size.height * 0.52),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
