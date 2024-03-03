import 'package:flutter/material.dart';

class SnapshotBase extends StatelessWidget {
  const SnapshotBase({
    super.key,
    this.rectSide = 20.0,
    this.canvasColor,
    this.checkeredColor,
    required this.useMaterial,
    required this.child,
  });

  final double rectSide;
  final Color? canvasColor;
  final Color? checkeredColor;
  final bool useMaterial;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final content = checkeredColor != null
        ? Checkered(rectSide: rectSide, color: checkeredColor!, child: child)
        : child;

    return useMaterial
        ? Material(
            color: canvasColor,
            child: content,
          )
        : Container(
            color: canvasColor,
            child: content,
          );
  }
}

class Checkered extends StatelessWidget {
  const Checkered({
    super.key,
    required this.rectSide,
    required this.color,
    required this.child,
  });

  final double rectSide;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CheckeredPainter(
        rectSide: rectSide,
        color: color,
      ),
      child: child,
    );
  }
}

class CheckeredPainter extends CustomPainter {
  const CheckeredPainter({
    super.repaint,
    required this.rectSide,
    required this.color,
  });

  final double rectSide;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final h = List.generate(size.height ~/ rectSide + 1, (i) => i * rectSide);
    final w = List.generate(size.width ~/ rectSide + 1, (i) => i * rectSide);
    final rectsPath = Path();

    for (final y in h) {
      for (final x in w) {
        if ((x ~/ rectSide).isOdd == (y ~/ rectSide).isOdd) {
          rectsPath.addRect(Rect.fromLTWH(x, y, rectSide, rectSide));
        }
      }
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(rectsPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
