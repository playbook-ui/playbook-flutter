import 'package:flutter/material.dart';

class ScalableButton extends StatefulWidget {
  const ScalableButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final GestureTapCallback onTap;

  @override
  _ScalableButtonState createState() => _ScalableButtonState();
}

class _ScalableButtonState extends State<ScalableButton> with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      lowerBound: 0,
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
      child: Transform.scale(
        scale: _scale ?? 1,
        child: widget.child,
      ),
      onTapDown: (_) => _controller?.forward(),
      onTapUp: (_) => _controller?.reverse(),
      onTapCancel: _controller?.reverse,
      onTap: widget.onTap,
    );
  }
}
