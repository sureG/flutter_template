import 'package:flutter/material.dart';
import '../values/colors.dart';

Widget buildLine({double padding = 0}) {
  if (padding == 0) {
    return Container(height: 0.5, color: AppColors.line);
  }
  return Padding(
    padding: EdgeInsets.only(left: padding, right: padding),
    child: Container(height: 0.5, color: AppColors.line),
  );
}

Widget buildDottedLine({double padding = 0}) {
  if (padding == 0) {
    return DottedLine(height: 0.5, color: AppColors.line, strokeWidth: 1.0, gap: 2.0, dashLength: 4.0);
  }
  return Padding(
    padding: EdgeInsets.only(left: padding, right: padding),
    child: DottedLine(height: 0.5, color: AppColors.line, strokeWidth: 1.0, gap: 2.0, dashLength: 4.0),
  );
}

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;

  DottedLine({
    this.height = 1.0,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 2.0,
    this.dashLength = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        gap: gap,
        dashLength: dashLength,
      ),
      size: Size(double.infinity, height),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;

  _DottedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.dashLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashLength, size.height / 2),
        paint,
      );
      startX += dashLength + gap;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        gap != oldDelegate.gap ||
        dashLength != oldDelegate.dashLength;
  }
}
