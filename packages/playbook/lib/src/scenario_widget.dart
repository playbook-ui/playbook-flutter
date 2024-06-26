import 'package:flutter/material.dart';
import 'package:playbook/src/scenario.dart';

typedef ScenarioWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

class ScenarioWidget extends StatelessWidget {
  const ScenarioWidget({
    super.key,
    required this.scenario,
    this.canvasColor,
    this.checkeredColor,
    this.checkeredRectSize,
    this.builder,
    required this.useMaterial,
  });

  final Color? canvasColor;
  final Color? checkeredColor;
  final double? checkeredRectSize;
  final bool useMaterial;
  final Scenario scenario;
  final ScenarioWidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final child = Align(
      alignment: scenario.alignment,
      child: builder?.call(context, scenario.child) ?? scenario.child,
    );

    final color = checkeredColor != null ? canvasColor : null;
    final content = checkeredColor != null
        ? Checkered(
            rectSize: checkeredRectSize ?? 5,
            color: checkeredColor!,
            child: child,
          )
        : child;

    return useMaterial
        ? Material(
            color: color,
            child: content,
          )
        : Container(
            color: color,
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
