import 'package:flutter/material.dart';
import 'package:playbook/src/scenario.dart';

class ScenarioWidget extends StatelessWidget {
  const ScenarioWidget({
    super.key,
    required this.scenario,
    this.canvasColor,
    this.checkeredColor,
    this.checkeredRectSize,
    required this.useMaterial,
  });

  final Color? canvasColor;
  final Color? checkeredColor;
  final double? checkeredRectSize;
  final bool useMaterial;
  final Scenario scenario;

  @override
  Widget build(BuildContext context) {
    final child = Align(
      alignment: scenario.alignment,
      child: scenario.child,
    );

    final content = checkeredColor != null
        ? Checkered(
            rectSize: checkeredRectSize ?? 5,
            color: checkeredColor!,
            child: child,
          )
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
    required this.rectSize,
    required this.color,
    required this.child,
  });

  final double rectSize;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CheckeredPainter(
        rectSize: rectSize,
        color: color,
      ),
      child: child,
    );
  }
}

class CheckeredPainter extends CustomPainter {
  const CheckeredPainter({
    super.repaint,
    required this.rectSize,
    required this.color,
  });

  final double rectSize;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final h = List.generate(size.height ~/ rectSize + 1, (i) => i * rectSize);
    final w = List.generate(size.width ~/ rectSize + 1, (i) => i * rectSize);
    final rectsPath = Path();

    for (final y in h) {
      for (final x in w) {
        if ((x ~/ rectSize).isOdd == (y ~/ rectSize).isOdd) {
          rectsPath.addRect(Rect.fromLTWH(x, y, rectSize, rectSize));
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
