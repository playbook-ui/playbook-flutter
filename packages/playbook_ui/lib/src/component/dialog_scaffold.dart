import 'package:flutter/material.dart';

class DialogScaffold extends StatelessWidget {
  const DialogScaffold({
    super.key,
    this.body,
    this.title,
  });

  final Widget? body;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    const height = 44.0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height,
        centerTitle: true,
        title: title,
        actions: [
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
      body: body,
    );
  }
}
