part of './indicators.dart';

class _CirclePainter extends CustomPainter {
  final Color fillColor;
  final double strokeWidth;
  final double elevation;
  final double radius;

  const _CirclePainter({
    required this.fillColor,
    this.strokeWidth = 1,
    this.elevation = 0,
    this.radius = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = fillColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    final shadowOffset = Offset(10, 10);
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);
    // Draw shadow for the main circle
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center + shadowOffset, radius, shadowPaint);
    final borderPaint = Paint()..color = Colors.black.withOpacity(0.3);
    canvas.drawCircle(center, radius + 20, borderPaint);
    // final radius = size.width / 2 - 20;
    // Draw the bump
    final bumpCenter = Offset(center.dx, center.dy + radius);
    final bumpRadius = radius / 4.5;
    final lineEnd = Offset(bumpCenter.dx, bumpCenter.dy + 15);
    canvas.drawLine(bumpCenter, lineEnd, linePaint);
    canvas.drawCircle(bumpCenter, bumpRadius, paint);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return fillColor != oldDelegate.fillColor ||
        elevation != oldDelegate.elevation ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}

class _Circle extends StatelessWidget {
  final Color color;
  final double elevation;
  final double radius;

  const _Circle({
    required this.color,
    this.elevation = 0,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
          fillColor: color,
          strokeWidth: 1,
          elevation: elevation,
          radius: radius),
    );
  }
}
