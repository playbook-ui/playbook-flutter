import 'package:flutter/material.dart';

class DialogScaffold extends StatelessWidget {
  const DialogScaffold({
    Key? key,
    this.body,
    this.title,
  }) : super(key: key);

  final Widget? body;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    const height = 32.0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height,
        title: SizedBox(
          height: height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: title,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.cancel),
                ),
              ),
            ],
          ),
        ),
      ),
      body: body,
    );
  }
}
