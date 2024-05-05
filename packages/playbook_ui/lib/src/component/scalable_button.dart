import 'package:flutter/material.dart';

class ScalableButton extends StatefulWidget {
  const ScalableButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final GestureTapCallback onTap;

  @override
  ScalableButtonState createState() => ScalableButtonState();
}

class ScalableButtonState extends State<ScalableButton>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      upperBound: 0.05,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1.0 - (_controller?.value ?? 0);

    return GestureDetector(
      onTapDown: (_) => _controller?.forward(),
      onTapUp: (_) => _controller?.reverse(),
      onTapCancel: _controller?.reverse,
      onTap: widget.onTap,
      child: Transform.scale(
        scale: _scale ?? 1,
        child: widget.child,
      ),
    );
  }
}
