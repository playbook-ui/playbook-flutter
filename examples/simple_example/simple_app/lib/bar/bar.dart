import 'package:flutter/material.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.star),
          SizedBox(width: 16),
          Text(text, style: Theme.of(context).textTheme.headline5)
        ],
      ),
    );
  }
}
