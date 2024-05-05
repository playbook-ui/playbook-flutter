import 'package:flutter/material.dart';

Widget scrollable({required bool primary}) => Row(
      children: [
        Flexible(
          child: ListView.builder(
            primary: primary,
            itemBuilder: (context, index) => Material(
              type: MaterialType.transparency,
              child: ListTile(
                title: Text('Item $index'),
              ),
            ),
            itemCount: 40,
          ),
        ),
        Flexible(
          child: ListView.builder(
            primary: primary,
            itemBuilder: (context, index) => Material(
              type: MaterialType.transparency,
              child: ListTile(
                title: Text('Item $index'),
              ),
            ),
            itemCount: 10,
          ),
        ),
      ],
    );
